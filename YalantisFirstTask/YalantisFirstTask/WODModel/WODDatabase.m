//
//  WODDatabase.m
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDatabase.h"
#import <UIKit/UIKit.h>
@interface WODDatabase ()

@property NSMutableArray *itemArray;

@end

@implementation WODDatabase

- (id)init {
    
    self=[super init];
    
    [self pictureSignature];

    self.itemArray = [NSMutableArray new];
    
    for (int a = 0; a < [self pictureSignature].count; a++) {
        [self.itemArray addObject:[[WODModel alloc] initWithString:[NSString stringWithFormat:@"природа %i.jpeg",a]
                                                    imageSignature:[[self pictureSignature] objectAtIndex:a]]];
    }
    _objectsCount = self.itemArray.count;
    
    return self;
}

- (WODModel *)dataForCellsWhithIndex:(NSInteger)index{
    
    return [self.itemArray objectAtIndex:index];
}

- (NSArray *)pictureSignature {
    return [NSArray arrayWithObjects:
            @"Новый Виндовс",@"Карпаты",@"Вишневое озеро",
            @"Тропа в загадку",@"Древо Гондора",@"Долина",
            @"Зеркало",@"Рыбное место",@"Сад",@"Горы на закате", nil];
}
@end
