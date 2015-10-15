//
//  WODPicturesCollectionViewController.h
//  YalantisFirstTask
//
//  Created by Woddi on 20.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WODDatabase;

#warning здесь актуальны все те же замечания, то и в табличном контроллере

@interface WODPicturesCollectionViewController : UICollectionViewController

@property (nonatomic, strong) WODDatabase *wODDB;

@end
