//
//  WODDatabase.m
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDatabase.h"
#import "WODSignature.h"
#import <SDWebImage/SDImageCache.h>
#import "WODInstagramAPIClient.h"
#import "WODConst.h"

@interface WODDatabase ()

@property (nonatomic, weak) id<NSFetchedResultsControllerDelegate> delegate;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation WODDatabase


- (instancetype)initWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (WODSignature *)modelAtIndexPath:(NSIndexPath *)indexPath {
    WODSignature *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return model;
}

- (NSInteger)modelCountForSections:(NSInteger)section {
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)deleteModelWithIndex:(NSIndexPath *)index {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:[self.fetchedResultsController objectAtIndexPath:index]];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#warning получается дублирование кода в установке значений для новой модели и для имеющейся модели. Код по заполнению "какой-то" модели данными должен быть общим, независимо от того, "новая" она, или "старая"
- (BOOL)replaceParametersForId:(NSString *)pictureId signature:(NSString *)signature pictureURL:(NSString *)urlString {
    NSEntityDescription *entityDesc = [[self.fetchedResultsController fetchRequest] entity];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pictureIdNamed == %@",pictureId];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [[self.fetchedResultsController managedObjectContext] executeFetchRequest:request error:&error];
    if (matchingData.count != 0) {
        for (NSManagedObject *obj in matchingData) {
            [obj setValue:urlString forKey:kPictureNameAttribute];
            [obj setValue:signature forKey:kPictureSignatureAttribute];
            [obj setValue:[NSDate date] forKey:kPictureCreationDateAttribute];
        }
        return YES;
    } else {
        return NO;
    }
}

- (void)insertNewObjectWithPictureName:(NSString *)name pictureIdName:(NSString *)idName forSignature:(NSString *)signature {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
    if (![self replaceParametersForId:idName signature:signature pictureURL:name]) {
        WODSignature *wSignature = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        wSignature.pictureIdNamed = idName;
        wSignature.pictureNamed = name;
        wSignature.pictureSignature =signature;
        wSignature.currentDate = [NSDate date];
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}

#pragma mark - Cora Data

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description =[NSEntityDescription entityForName:@"Signature" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    [fetchRequest setFetchBatchSize:kFetchBatchSize];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kPictureCreationDateAttribute ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest
                                     managedObjectContext:context
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
    self.fetchedResultsController.delegate = self.delegate;
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"%@, %@", error, [error userInfo]);
    }
    return _fetchedResultsController;
}

- (NSManagedObjectModel *)managedObjectModel {
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WODCoreDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSError* error = nil;
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BasicApplication.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if(_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
