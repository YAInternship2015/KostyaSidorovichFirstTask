//
//  WODModelValidator.m
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODModelValidator.h"

#warning в задании вроде была длина не менее трех символов
float const kMinModelTitleLength = 0.1;

@implementation WODModelValidator

- (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error {
    if (title.length < kMinModelTitleLength) {
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
