//
//  WODDatabase.h
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Signature;

@interface WODDatabase : NSObject

- (Signature *)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)modelCountForSections:(NSInteger)section;
- (instancetype)initWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void)insertNewObjectWithPictureName:(NSString *)name pictureIdName:(NSString *)idName forSignature:(NSString *)signature;
- (void)deleteModelWithIndex:(NSIndexPath *)index;
- (void)saveContext;

@end

