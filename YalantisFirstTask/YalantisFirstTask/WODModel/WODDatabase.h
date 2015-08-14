//
//  WODDatabase.h
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODModel.h"

@interface WODDatabase : WODModel

@property (readonly) NSInteger objectsCount;

- (WODModel *)dataForCellsWhithIndex:(NSInteger)index;

@end
