//
//  WODValidateModel.h
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WODValidateModel : NSObject
- (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error;
@end
