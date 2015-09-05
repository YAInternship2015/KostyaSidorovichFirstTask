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

float const kDurationAnimation = 0.1;

@interface WODContainerViewController ()

@property (nonatomic, assign) BOOL switcherVC;

@property (nonatomic, strong) WODTableViewController *tableViewController;
@property (nonatomic, strong) WODPicturesCollectionViewController *collectionViewController;

@end

@implementation WODContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.switcherVC = YES;
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Table"];
    self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Collection"];
    
    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.view];
    [self.tableViewController didMoveToParentViewController:self];
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
        [self swapFromViewController:self.tableViewController
                    toViewController:self.collectionViewController];
    } else {
        self.switcherVC = YES;
        [self swapFromViewController:self.collectionViewController
                    toViewController:self.tableViewController];
    }
}

@end
