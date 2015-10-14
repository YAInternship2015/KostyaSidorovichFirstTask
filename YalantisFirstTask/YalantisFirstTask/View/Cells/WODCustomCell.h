//
//  WODCustomCell.h
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WODSignature;

@interface WODCustomCell : UITableViewCell

- (void)setupWithModel:(WODSignature *)wModel;

@end
