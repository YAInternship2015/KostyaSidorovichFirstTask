//
//  WODFactoryModel.h
//  YalantisFirstTask
//
//  Created by Woddi on 28.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#warning зачем здесь показывать WODModel?
@class WODModel;
@interface WODFactoryModel : NSObject
#warning create в имени метода лишний. Так как из метода возвращается модель, он должен называться modelWithText:imageName:
+ (WODModel *)createObjectWithText:(NSString *)text image:(NSString *)imageNamed;
@end
