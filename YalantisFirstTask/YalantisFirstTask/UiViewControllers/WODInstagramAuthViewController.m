//
//  WODInstagramAuthViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODInstagramAuthViewController.h"
#import "WODInstagramAuthenticatorWebView.h"
#import "WODSizerView.h"

@interface WODInstagramAuthViewController ()

@end

@implementation WODInstagramAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[WODSizerView alloc] initWithFrame:CGRectZero frameChangeDelegate:self];
    self.authDelegate = nil;
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
