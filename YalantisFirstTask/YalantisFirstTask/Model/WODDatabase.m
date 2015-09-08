//
//  WODDatabase.m
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDatabase.h"
#import <UIKit/UIKit.h>
#import "WODNotifications.h"

@interface WODDatabase ()

@property (nonatomic, weak) id<WODDataModelDelegate> delegate;
#warning не понял, зачем нужно свойство tempStringForNotification
@property (nonatomic, weak) NSString *tempStringForNotification;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, retain) NSString *plistFile;

@end

@implementation WODDatabase

- (instancetype)initWithDelegate:(id<WODDataModelDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self openPlistFile];
        self.itemArray = [NSMutableArray arrayWithArray:[self dataFromPlist]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(dataDidChanged:)
                                                     name:WODDataFileContentDidChangeNotificationName
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (WODModel *)modelAtIndex:(NSInteger)index{
    return [self.itemArray objectAtIndex:index];
}

- (NSInteger)modelCount {
    return self.itemArray.count;
}

- (NSArray *)dataFromPlist {
    NSArray *namesValueArray = [self readValueForKey:@"names"];
    NSArray *imagesValueArray = [self readValueForKey:@"images"];
    NSMutableArray *wModel = [NSMutableArray new];
    
    for (int a = 0; a < namesValueArray.count; a++) {
        [wModel addObject:[[WODModel alloc] initWithString:[imagesValueArray objectAtIndex:a]
                                            imageSignature:[namesValueArray objectAtIndex:a]]];
    }
    return wModel;
}

- (void)dataDidChanged:(NSNotification *)notification {
    self.itemArray = [self dataFromPlist];
    [self.delegate dataWasChanged:self array:[self dataFromPlist]];
}

- (void)saveModel:(WODModel *)model {
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:self.plistFile];
    NSMutableArray *imgArray = [savedStock valueForKey:@"images"];
    NSMutableArray *titleArray = [savedStock valueForKey:@"names"];
    
    [titleArray addObject:model.picturesSignature];
#warning название картинки по умолчанию вынесите в константы
    [imgArray addObject:[NSString stringWithFormat:@"Пустая картинка.jpeg"]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:imgArray, @"images",
                                                                    titleArray, @"names", nil];
    [dict writeToFile:self.plistFile atomically: YES];
    self.tempStringForNotification = model.picturesSignature;
    
}

- (void)openPlistFile {
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

-(void)setTempStringForNotification:(NSString *)tempStringForNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:WODDataFileContentDidChangeNotificationName object:nil];

}

@end
