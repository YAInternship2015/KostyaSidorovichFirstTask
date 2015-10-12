//
//  WODGetterInstagramInfo.m
//  YalantisFirstTask
//
//  Created by Woddi on 07.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODGetterInstagramInfo.h"
#import <UIKit/UIKit.h>
#import "WODInstagramAPIClient.h"
@interface WODGetterInstagramInfo ()

@property (nonatomic, strong) NSMutableArray *usersPictureId;
@property (nonatomic, strong) NSMutableArray *picturesURL;
@property (nonatomic, strong) NSMutableArray *pictureCaptionText;

@end

@implementation WODGetterInstagramInfo

- (void)didAuthWithToken:(NSString*)token forTagNmaed:(NSString *)tag {
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
    NSString *popularURLString = [NSString stringWithFormat:@"%@/tags/%@/media/recent?access_token=%@", instagramBase, tag, token];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:popularURLString]];
    NSOperationQueue *theQ = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:theQ
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *err;
                               id val = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
                               if(!err && !error && val && [NSJSONSerialization isValidJSONObject:val]) {
                                   NSArray *data = [val objectForKey:@"data"];
                                   dispatch_sync(dispatch_get_main_queue(),^{
                                       if(!data) {
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                               message:@"Failed to request perform request."
                                                                                              delegate:nil
                                                                                     cancelButtonTitle:@"OK"
                                                                                     otherButtonTitles:nil];
                                           [alertView show];
                                       } else {
                                           WODInstagramAPIClient *instAPI = [WODInstagramAPIClient new];
                                           for (NSDictionary *dict in data) {
                                               [[instAPI valueForKey:@"idNamed"]addObject:[dict valueForKey:@"id"]];
                                               [[instAPI valueForKey:@"captionText"]addObject:[[dict valueForKey:@"caption"]valueForKey:@"text"]];
                                               [[instAPI valueForKey:@"imagesURL"]addObject:[[[dict valueForKey:@"images"] valueForKey:@"standard_resolution"] valueForKey:@"url"]];
                                           }
                                           [instAPI getInfFromInstagram];
                                       }
                                   });
                               }
                           }];
}


@end
