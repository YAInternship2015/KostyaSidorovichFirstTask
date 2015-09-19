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
#import "WODConnectCD.h"
#import "Signature.h"
#import "Picture.h"

static NSString *const kEmptyPictureNamed = @"Пустая картинка.jpeg";

@interface WODDatabase ()

@property (nonatomic, weak) id<WODDataModelDelegate> delegate;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, retain) NSString *plistFile;
@property (nonatomic, strong) WODConnectCD *connectedCoreData;
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
        self.connectedCoreData = [WODConnectCD new];
        self.itemArray = [NSMutableArray arrayWithArray:[self coreDataArray]];
        
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

- (WODModel *)modelAtIndex:(NSInteger)index {
    return [self.itemArray objectAtIndex:index];
}

- (NSInteger)modelCount {
    return self.itemArray.count;
}

- (void)dataDidChanged:(NSNotification *)notification {
    self.itemArray = [self coreDataArray];
    [self.delegate dataWasChanged:self array:[self coreDataArray]];
}

- (NSArray *)coreDataArray {
    NSMutableArray *wModel = [NSMutableArray new];
    NSManagedObjectContext *context = [self.connectedCoreData managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Signature" inManagedObjectContext:context];
    [request setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:request error:nil];
    for (Signature *info in fetchedObjects) {
        NSLog(@"Name: %@", info.pictureSignature);
        Picture *details = info.pictureName;
        NSLog(@"Zip: %@", details.named);
        if (details.named != nil & info.pictureSignature != nil) {
            [wModel addObject:[[WODModel alloc] initWithString:details.named
                                                imageSignature:info.pictureSignature]];
        }
    }
    return wModel;
}

- (NSArray *)readValueForKey:(NSString *)key{
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile:self.plistFile];
    NSArray *arr = [NSArray arrayWithArray:[savedStock valueForKey:key]];
    return arr;
}

-(void)setTempStringForNotification:(NSString *)tempStringForNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:WODDataFileContentDidChangeNotificationName object:nil];
}

- (void)saveModel:(WODModel *)model {
    NSString *named = [NSString stringWithFormat:@"природа %i.jpeg",arc4random()%9];
    
    [self.connectedCoreData insertNewObjectWithPictureName:named forSignature:model.picturesSignature];
    self.tempStringForNotification = model.picturesSignature;
}
@end
