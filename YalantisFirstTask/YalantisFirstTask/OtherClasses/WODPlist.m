//
//  WODPlist.m
//  YalantisFirstTask
//
//  Created by Woddi on 26.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODPlist.h"
#import "WODModel.h"
#import "WODDatabase.h"
@interface WODPlist ()

#warning этот объект держит strong ссылку на WODDatabase, который в свою очередь дердит strong ссылку на WODPlist. Retain cycle в чистом виде
@property (nonatomic, strong) WODDatabase *wDB;

@end
@implementation WODPlist
- (id)init {
    self = [super init];
    if (self) {
        [self openPlistFile];

    }
    return self;
}
- (void)openPlistFile{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.plistFile = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: self.plistFile]) {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"WODData" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: self.plistFile error:&error];
    }
}
- (NSArray *)readValueForKey:(NSString *)key{
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:self.plistFile];
    NSArray *arr = [NSArray arrayWithArray:[savedStock valueForKey:key]];
    return arr;
}


@end
