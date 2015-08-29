//
//  WODDatabase.h
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODModel.h"

OBJC_EXTERN NSString * const kWODDataFileContentDidChangeNotification;
OBJC_EXTERN NSString * const kWODTitleUserInfoKey;

@protocol WODDataModelDelegate;

@interface WODDatabase : WODModel

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, weak) NSString *tempStringForNotification;

- (WODModel *)modelAtIndex:(NSInteger)index;
- (instancetype)initWithDelegate:(id<WODDataModelDelegate>)delegate;
- (void)saveModelToPlist:(WODModel *)model;

@end

@protocol WODDataModelDelegate <NSObject>
@required
- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array;

@end