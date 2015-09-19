//
//  WODConnectCD.h
//  YalantisFirstTask
//
//  Created by Woddi on 12.09.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WODConnectCD : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)saveContext;
- (NSURL *)applicationsDocumentsDirectory;


- (void)insertNewObjectWithPictureName:(NSString *)name forSignature:(NSString *)signature;

@end
