//
//  WODFactoryModel.m
//  YalantisFirstTask
//
//  Created by Woddi on 28.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODFactoryModel.h"
#import "WODModel.h"
#warning здесь должна быть пустая строка
@implementation WODFactoryModel
+ (WODModel *)createObjectWithText:(NSString *)text image:(NSString *)imageNamed {
#warning после alloc] должен быть пробел
    WODModel *obj= [[WODModel alloc]initWithString:imageNamed imageSignature:text];
    return obj;
}
@end
