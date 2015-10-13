//
//  WODSizerView.h
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WODInstagramAuthViewController.h"

#warning это похоже на какие-то костыли. Зачем нужен такой класс? Обычно все проблемы с ресайзингом решаются настройкой автолэйаута
@interface WODSizerView : UIView

- (id)initWithFrame:(CGRect)frame frameChangeDelegate:(id<FrameChangeDelegate>)_delegate;

@end
