//
//  WODInstagramAuthenticatorWebView.h
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODInstagramAuthViewController.h"

@interface WODInstagramAuthenticatorWebView : UIWebView <UIWebViewDelegate>

@property(nonatomic, weak) id<InstagramAuthDelegate> authDelegate;

@end
