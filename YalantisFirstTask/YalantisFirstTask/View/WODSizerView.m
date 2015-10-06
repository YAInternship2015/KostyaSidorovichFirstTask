//
//  WODSizerView.m
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODSizerView.h"

@interface WODSizerView()
@property(nonatomic, weak) id<FrameChangeDelegate> delegate;
@end

@implementation WODSizerView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame frameChangeDelegate:(id<FrameChangeDelegate>)_delegate
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = _delegate;
    }
    return self;
}

-(void) layoutSubviews
{
    [self.delegate frameChanged:self.frame];
}

@end
