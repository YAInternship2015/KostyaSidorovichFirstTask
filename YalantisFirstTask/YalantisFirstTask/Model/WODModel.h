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

@property (nonatomic, readonly) UIImage *myPicture;
@property (nonatomic, readonly) NSString *picturesSignature;
@property (nonatomic, readonly) NSString *imageNamed;

- (id)initWithString:(NSString *)name imageSignature:(NSString *)signature;

@end
