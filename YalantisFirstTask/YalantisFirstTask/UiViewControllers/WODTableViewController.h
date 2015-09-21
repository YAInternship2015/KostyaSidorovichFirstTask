//
//  WODTableViewController.h
//  YalantisFirstTask
//
//  Created by Woddi on 01.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WODDatabase;

@interface WODTableViewController : UITableViewController

@property (nonatomic, strong) WODDatabase *wODDB;

@end

