//
//  WODFactoryModel.h
//  YalantisFirstTask
//
//  Created by Woddi on 28.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WODModel;
@interface WODFactoryModel : NSObject
+ (WODModel *)createObjectWithText:(NSString *)text image:(NSString *)imageNamed;
@end
