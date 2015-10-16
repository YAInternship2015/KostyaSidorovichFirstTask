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
#import "WODConst.h"

@interface WODContainerViewController ()

@property (nonatomic, assign) BOOL switcherVC;
@property (nonatomic, strong) WODTableViewController *tableViewController;
@property (nonatomic, strong) WODPicturesCollectionViewController *collectionViewController;

@end

@implementation WODContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.switcherVC = YES;
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:kTableViewControllerIdentifier];

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
    if ([segue.identifier isEqualToString:kSegueIdentifierFromContainerVC]) {
        WODSaveModelViewController *wSaveVC = segue.destinationViewController;
        if (self.switcherVC) {
            wSaveVC.wODDB = self.tableViewController.wODDB;
        } else {
            wSaveVC.wODDB = self.collectionViewController.wODDB;
        }
    }
}

@end
