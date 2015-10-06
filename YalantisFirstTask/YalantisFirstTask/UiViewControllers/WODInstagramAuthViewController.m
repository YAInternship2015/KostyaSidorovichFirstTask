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
- (id)init {
    self = [super init];
    if (self) {
        self.view = [[WODSizerView alloc] initWithFrame:CGRectZero frameChangeDelegate:self];
        self.authDelegate = nil;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) didAuthWithToken:(NSString*)token {
    [self.authDelegate didAuthWithToken:token];
}

-(void) frameChanged:(CGRect)frame {
    WODInstagramAuthenticatorWebView *instagramAWV = [[WODInstagramAuthenticatorWebView alloc] initWithFrame:frame];
    instagramAWV.authDelegate = self;
    [self.view addSubview:instagramAWV];
}


@end
