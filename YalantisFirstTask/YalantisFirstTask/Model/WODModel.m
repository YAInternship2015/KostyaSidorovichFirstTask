//
//  WODModel.m
//  YalantisFirstTask
//
//  Created by Woddi on 12.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODModel.h"

@implementation WODModel

- (id)initWithString:(NSString *)name imageSignature:(NSString *)signature {
    self = [super init];
    if (self){
#warning потеряли сдвиг вправо
    _picturesName = signature;
    _myPikture = [UIImage imageNamed:name];
    }
    return self;
}

@end
