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

@protocol InstagramAuthCompletedDelegate <NSObject>

- (void)pushToContainerVC;

@end

@interface WODInstagramAuthViewController : UIViewController<FrameChangeDelegate,InstagramAuthCompletedDelegate>

@property(nonatomic, weak) id<InstagramAuthCompletedDelegate> authDelegate;


@end

