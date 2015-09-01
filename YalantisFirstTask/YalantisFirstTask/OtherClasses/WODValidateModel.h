//
//  WODValidateModel.h
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning стоило назвать класс WODModelValidator
@interface WODValidateModel : NSObject

#warning после @interface/@implementation/@protocol и перед @end должны быть пустые строки. Это касается всего приложения
- (BOOL)isValidModelTitle:(NSString *)title error:(NSError **)error;
@end
