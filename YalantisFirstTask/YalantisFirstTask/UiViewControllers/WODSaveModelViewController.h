//
//  WODSaveModelViewController.h
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WODDatabase;
@class WODDataManager;

@interface WODSaveModelViewController : UIViewController

@property (nonatomic, strong) WODDatabase *wODDB;
@property (nonatomic, strong) WODDataManager *manager;

@end
