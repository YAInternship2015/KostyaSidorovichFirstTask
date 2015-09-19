//
//  WODConnectCD.m
//  YalantisFirstTask
//
//  Created by Woddi on 12.09.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODConnectCD.h"
#import "Signature.h"
#import "Picture.h"

@implementation WODConnectCD
//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil)
        return _fetchedResultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Signature" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    [fetchRequest setFetchBatchSize:20];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pictureSignature" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    
    NSError *error = nil;
    if(![self.fetchedResultsController performFetch:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    
    return _fetchedResultsController;
}

- (void)insertNewObject {
    NSManagedObjectContext *managedObjectContext = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    [newManagedObject setValue:[NSDate date] forKey:@"pictureSignature"];
    
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
}

- (NSManagedObjectModel *)managedObjectModel {
    if(_managedObjectModel != nil){
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WODCoreDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if(_persistentStoreCoordinator != nil){
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BasicApplication.sqlite"];
    
    NSError* error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext {
    if(_managedObjectContext != nil){
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if(coordinator != nil){
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    if(managedObjectContext != nil) {
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (void)insertNewObjectWithPictureName:(NSString *)name forSignature:(NSString *)signature {
    NSManagedObjectContext *context = [self managedObjectContext];
    Signature *kSignature = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"Signature"
                                      inManagedObjectContext:context];
    kSignature.pictureSignature = signature;
    Picture *kPicture = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"Picture"
                                            inManagedObjectContext:context];
    kPicture.named = name;
    kSignature.pictureName = kPicture;
    kPicture.signature = kSignature;
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
@end
