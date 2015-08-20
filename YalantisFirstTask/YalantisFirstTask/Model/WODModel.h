//
//  WODModel.h
//  YalantisFirstTask
//
//  Created by Woddi on 12.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WODModel : NSObject

#warning опечатались в myPikture
@property (nonatomic, readonly) UIImage *myPikture;
@property (nonatomic, readonly) NSString *picturesName;

- (id)initWithString:(NSString *)name imageSignature:(NSString *)signature;

@end
