//
//  WODPlist.h
//  YalantisFirstTask
//
//  Created by Woddi on 26.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WODModel;
@interface WODPlist : NSObject

@property (nonatomic, retain) NSString *plistFile;

- (void)openPlistFile;
- (NSArray *)readValueForKey:(NSString *)key;
@end
