//
//  WODFactoryModel.m
//  YalantisFirstTask
//
//  Created by Woddi on 28.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODFactoryModel.h"
#import "WODModel.h"

@implementation WODFactoryModel

+ (WODModel *)modelWithText:(NSString *)text image:(NSString *)imageNamed {
    WODModel *obj= [[WODModel alloc] initWithString:imageNamed imageSignature:text];
    return obj;
}

@end
