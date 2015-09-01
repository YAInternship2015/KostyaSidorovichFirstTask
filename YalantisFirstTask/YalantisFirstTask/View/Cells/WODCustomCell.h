//
//  WODCustomCell.h
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WODModel;

#warning здесь правда нужны <UIAlertViewDelegate,UIApplicationDelegate> ?
@interface WODCustomCell : UITableViewCell <UIAlertViewDelegate,UIApplicationDelegate>

- (void)setupWithModel:(WODModel *)wModel;

@end
