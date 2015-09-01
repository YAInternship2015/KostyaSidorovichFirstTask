//
//  WODPlist.h
//  YalantisFirstTask
//
//  Created by Woddi on 26.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WODModel;

#warning в принципе обертку над plist'ом можно было не делать, достаточно категории на NSFileManager, которая бы возвращала путь к файлу
@interface WODPlist : NSObject

@property (nonatomic, retain) NSString *plistFile;

- (void)openPlistFile;
- (NSArray *)readValueForKey:(NSString *)key;
@end
