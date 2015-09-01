//
//  WODValidateModel.m
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODValidateModel.h"

@implementation WODValidateModel
- (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error{
#warning цифру 3 надо объявить константой с именем kMinModelTitleLength и использовать ее. Надо избегать появления случайных чисел в коде, вместо них использовать константы с понятными именами
    if (title.length < 3) {
        if (error != nil) {
            NSString *description = NSLocalizedString(@"Input Validation Failed", @"");
            NSString *reason = NSLocalizedString(@"Too few characters", @"");
            NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
            NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,
                                                          NSLocalizedFailureReasonErrorKey, nil];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray
                                                                 forKeys:keyArray];
            *error = [NSError errorWithDomain:@"InputValidationErrorDomain"
                                         code:4
                                     userInfo:userInfo];
        }
        return NO;
    }
    return YES;
}
@end
