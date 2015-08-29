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
        _imageNamed = name;
        _picturesSignature = signature;
        _myPicture = [UIImage imageNamed:name];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image imageSignature:(NSString *)signature{
    self = [super init];
    if (self){
        _picturesSignature = signature;
        _myPicture = image;
    }
    return self;
}

@end
