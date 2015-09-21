//
//  WODCustomCell.h
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Signature;

@interface WODCustomCell : UITableViewCell

- (void)setupWithModel:(Signature *)wModel;

@end
