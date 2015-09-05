//
//  WODDatabase.h
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODModel.h"

@protocol WODDataModelDelegate;

@interface WODDatabase : NSObject

- (WODModel *)modelAtIndex:(NSInteger)index;
- (instancetype)initWithDelegate:(id<WODDataModelDelegate>)delegate;
- (NSInteger)modelCount;

- (void)saveModel:(WODModel *)model;

@end

@protocol WODDataModelDelegate <NSObject>
@required

- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array;

@end