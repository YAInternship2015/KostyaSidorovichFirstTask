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

#warning зачем здесь property? можно обойтись простым методом и возвращать кол-во элементов в массиве моделей
@property (readonly) NSInteger objectsCount;

#warning не лучшее имя для метода. Зачем здесь слово "cell"? У нас просто получение объекта по индексу, типа modelAtIndex:
- (WODModel *)dataForCellsWhithIndex:(NSInteger)index;

@end
