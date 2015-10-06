//
//  WODInstagramAuthViewController.h
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FrameChangeDelegate

-(void) frameChanged:(CGRect)frame;

@end

@protocol InstagramAuthDelegate <NSObject>

-(void) didAuthWithToken:(NSString*)token;

@end

@interface WODInstagramAuthViewController : UIViewController<FrameChangeDelegate, InstagramAuthDelegate>

@property(nonatomic, weak) id<InstagramAuthDelegate> authDelegate;

@end

