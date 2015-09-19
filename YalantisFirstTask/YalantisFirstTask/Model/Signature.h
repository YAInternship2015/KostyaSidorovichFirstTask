//
//  Signature.h
//  YalantisFirstTask
//
//  Created by Woddi on 15.09.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Picture;

@interface Signature : NSManagedObject

@property (nonatomic, retain) NSString * pictureSignature;
@property (nonatomic, retain) Picture *pictureName;

@end
