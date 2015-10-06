//
//  WODContainerViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 24.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODContainerViewController.h"
#import "WODPicturesCollectionViewController.h"
#import "WODTableViewController.h"
#import "WODSaveModelViewController.h"
#import "WODInstagramAuthViewController.h"

float const kDurationAnimation = 0.1;
static NSString * const kTableViewControllerIdentifier = @"Table";
static NSString * const kCollectionViewControllerIdentifier = @"Collection";
static NSString * const kSegueIdentifier = @"pushSaveViewController";

@interface WODContainerViewController (){
    WODInstagramAuthViewController *instagramAuthController;
}

@property (nonatomic, assign) BOOL switcherVC;
@property (nonatomic, strong) WODTableViewController *tableViewController;
@property (nonatomic, strong) WODPicturesCollectionViewController *collectionViewController;

@end

@implementation WODContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    instagramAuthController = [WODInstagramAuthViewController new];
//    [self performSelector:@selector(checkInstagramAuth) withObject:nil afterDelay:0];
    [self checkInstagramAuth];

    self.switcherVC = YES;
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:kTableViewControllerIdentifier];

    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.view];
    [self.tableViewController didMoveToParentViewController:self];
}

-(void) didAuthWithToken:(NSString*)token {
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
                                       }
                                   });
                               }
                           }];
        __weak WODInstagramAuthViewController *weakAuthController = instagramAuthController;
        [weakAuthController dismissViewControllerAnimated:YES completion:nil];

}

-(void) checkInstagramAuth {
    instagramAuthController.authDelegate = self;
    
    instagramAuthController.modalPresentationStyle = UIModalPresentationFormSheet;
    instagramAuthController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:instagramAuthController animated:YES completion:nil];
}

- (void)swapFromViewController:(UIViewController *)fromViewController
              toViewController:(UIViewController *)toViewController {
    
    self.navigationController.navigationBar.translucent = NO;
    toViewController.view.frame = self.view.bounds;
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController duration:kDurationAnimation
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:^(BOOL finished) {
                                [fromViewController removeFromParentViewController];
                                [toViewController didMoveToParentViewController:self];
                            }];
}

- (IBAction)switchVC:(id)sender {
    if (self.switcherVC == YES) {
        self.switcherVC = NO;
        self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:kCollectionViewControllerIdentifier];

        [self swapFromViewController:self.tableViewController
                    toViewController:self.collectionViewController];
    } else {
        self.switcherVC = YES;
        self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:kTableViewControllerIdentifier];

        [self swapFromViewController:self.collectionViewController
                    toViewController:self.tableViewController];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueIdentifier]) {
        WODSaveModelViewController *wSaveVC = segue.destinationViewController;
        if (self.switcherVC) {
            wSaveVC.wODDB = self.tableViewController.wODDB;
        } else {
            wSaveVC.wODDB = self.collectionViewController.wODDB;
        }
    }
}
@end
