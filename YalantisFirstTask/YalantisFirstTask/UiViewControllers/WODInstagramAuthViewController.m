//
//  WODInstagramAuthViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODInstagramAuthViewController.h"
#import "WODInstagramAuthenticatorWebView.h"
#import "WODContainerViewController.h"
#import "WODSizerView.h"

@interface WODInstagramAuthViewController ()

@end

@implementation WODInstagramAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[WODSizerView alloc] initWithFrame:CGRectZero frameChangeDelegate:self];
    self.authDelegate = nil;
}

- (void)didAuthWithToken:(NSString*)token {
    if(!token) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Failed to request token."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    NSString *instagramBase = @"https://api.instagram.com/v1";
    NSString *popularURLString = [NSString stringWithFormat:@"%@/tags/car/media/recent?access_token=%@", instagramBase, token];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:popularURLString]];
    
    NSOperationQueue *theQ = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:theQ
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *err;
                               
                               id val = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                               if(!err && !error && val && [NSJSONSerialization isValidJSONObject:val]) {
                                   NSArray *data = [val objectForKey:@"data"];
                                   NSLog(@"data = %@",data);
                                   dispatch_sync(dispatch_get_main_queue(),^{
                                       if(!data) {
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                               message:@"Failed to request perform request."
                                                                                              delegate:nil
                                                                                     cancelButtonTitle:@"OK"
                                                                                     otherButtonTitles:nil];
                                           [alertView show];
                                       } else { [self pushToContainerVC]; }
                                   });
                               }
                           }];
}

- (void)frameChanged:(CGRect)frame {
    WODInstagramAuthenticatorWebView *instagramAWV = [[WODInstagramAuthenticatorWebView alloc] initWithFrame:frame];
    instagramAWV.authDelegate = self;
    [self.view addSubview:instagramAWV];
}

- (void)pushToContainerVC {
    [self performSegueWithIdentifier:@"afterLogin" sender:self];
}
@end
