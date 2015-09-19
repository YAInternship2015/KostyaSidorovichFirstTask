//
//  Picture.h
//  YalantisFirstTask
//
//  Created by Woddi on 15.09.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Signature;

@interface Picture : NSManagedObject

@property (nonatomic, retain) NSString * named;
@property (nonatomic, retain) Signature *signature;

@end
