//
//  WODDatabase.m
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDatabase.h"
#import "Signature.h"
#import <SDWebImage/SDImageCache.h>
#import "WODInstagramAPIClient.h"
static NSString *kPictureSignatureAttribute = @"pictureSignature";
static NSString *kPictureNameAttribute = @"pictureNamed";
static NSString *kPictureIdAttribute = @"pictureIdNamed";
static NSString *kPictureCreationDateAttribute = @"curentDate";

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
        
        if (![WODInstagramAPIClient sharedInstance].firstLoad) {
            [self loadCache];
            [WODInstagramAPIClient sharedInstance].firstLoad = YES;
        }
            }
    return self;
}
- (void)loadCache {
    for (int a = 0; a < self.fetchedResultsController.fetchedObjects.count; a++) {
        NSString *pictureId =[NSString stringWithFormat:@"%@",[[self.fetchedResultsController.fetchedObjects objectAtIndex:a]valueForKey:kPictureIdAttribute]];
        NSString *pictureURLstring = [NSString stringWithFormat:@"%@",[[self.fetchedResultsController.fetchedObjects objectAtIndex:a]valueForKey:kPictureNameAttribute]];
        [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:pictureURLstring]]] forKey:pictureId];
    }
}
- (Signature *)modelAtIndexPath:(NSIndexPath *)indexPath {
    Signature *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return model;
}

- (NSString *)selectedRowStringWithModel:(Signature *)model {
   return [NSString stringWithFormat:@"%@",model.pictureSignature];
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
- (void)searchId:(NSString *)idNamed {
    
    NSEntityDescription *entityDesc = [[self.fetchedResultsController fetchRequest] entity];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:entityDesc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pictureIdNamed like %@",idNamed];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchingData = [[self.fetchedResultsController managedObjectContext] executeFetchRequest:request error:&error];
    if (matchingData.count != 0) {
        for (NSManagedObject *obj in matchingData) {
            [[self.fetchedResultsController managedObjectContext] deleteObject:obj];
        }
    }
}
- (void)insertNewObjectWithPictureName:(NSString *)name pictureIdName:(NSString *)idName forSignature:(NSString *)signature {

    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name]
                                                                      inManagedObjectContext:context];
    [self searchId:idName];
    [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:name]]] forKey:idName];
    [newManagedObject setValue:[NSDate date] forKey:kPictureCreationDateAttribute];
    [newManagedObject setValue:signature forKey:kPictureSignatureAttribute];
    [newManagedObject setValue:name forKey:kPictureNameAttribute];
    [newManagedObject setValue:idName forKey:kPictureIdAttribute];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
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
    [fetchRequest setFetchBatchSize:20];
    
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
