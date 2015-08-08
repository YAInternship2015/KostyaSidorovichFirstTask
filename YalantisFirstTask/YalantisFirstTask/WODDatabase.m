//
//  WODDatabase.m
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDatabase.h"
#import <UIKit/UIKit.h>

@implementation WODDatabase

-(NSArray *)myPicture{
    
    NSMutableArray *pictureArray = [NSMutableArray new];
    for (int a = 0; a<10; a++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"природа %i.jpeg",a]];
        [pictureArray addObject:image];
    }
    return pictureArray;
}
-(NSArray *)pictureName{
    
    return [NSArray arrayWithObjects:
            @"Новый Виндовс",@"Карпаты",@"Вишневое озеро",
            @"Тропа в загадку",@"Древо Гондора",@"Долина",
            @"Зеркало",@"Рыбное место",@"Сад",@"Горы на закате", nil];
    
}
@end
