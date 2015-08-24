//
//  WODMainViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 24.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODMainViewController.h"
#import "WODPicturesCollectionViewController.h"
#import "WODTableViewController.h"
@interface WODMainViewController ()

@property (nonatomic, assign) BOOL switcherVC;

@property (strong, nonatomic) WODTableViewController *tableViewController;
@property (strong, nonatomic) WODPicturesCollectionViewController *collectionViewController;
@end

@implementation WODMainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.switcherVC = YES;
    self.tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Table"];
    self.collectionViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Collection"];
    
    [self addChildViewController:self.tableViewController];
    [self.view addSubview:self.tableViewController.view];
    [self.tableViewController didMoveToParentViewController:self];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"switch"
                                              style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(switchVC:)];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

- (void)swapFromViewController:(UIViewController *)fromViewController
              toViewController:(UIViewController *)toViewController {
    self.navigationController.navigationBar.translucent = NO;

    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                             self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController duration:0.1
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
