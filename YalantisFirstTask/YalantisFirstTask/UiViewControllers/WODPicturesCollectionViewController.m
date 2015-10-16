//
//  WODPicturesCollectionViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 20.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODPicturesCollectionViewController.h"
#import "WODDatabase.h"
#import "WODCustomCollectionViewCell.h"
#import "WODDataManager.h"
#import "WODConst.h"

@interface WODPicturesCollectionViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) WODDataManager *manager;

@end

@implementation WODPicturesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [WODDataManager new];
    self.wODDB = [[WODDatabase alloc] initWithDelegate:self];
    [self.collectionView registerNib:[UINib nibWithNibName:kNibName bundle:nil]
          forCellWithReuseIdentifier:kReuseCollectionIdentifier];
    if ([self.wODDB modelCountForSections:0] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Attention please", nil) message:NSLocalizedString(@"Enter tag", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark <CollectionViewDataSource,delegat>

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.wODDB modelCountForSections:0] - kCellsIntervalToDownloadCollectionView) {
        self.manager.wODDB = self.wODDB;
        if(![self.manager sendRequestForLoadPicture]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Attention please", nil)  message:NSLocalizedString(@"Enter tag please", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    
    CGPoint locationPoint = [sender locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:locationPoint];
    
    if (sender.state == UIGestureRecognizerStateBegan && indexPath) {
        [self.wODDB deleteModelWithIndex:indexPath];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.items = [[NSMutableArray alloc] init];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.wODDB modelCountForSections:section];
}

- (WODCustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                         cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WODCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCollectionIdentifier
                                                                                  forIndexPath:indexPath];
    [cell setupWithModel:[self.wODDB modelAtIndexPath:indexPath]];
    return cell;
}

#pragma mark - <NSFetchedResultsControllerDelegate>

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
                                                                atIndexPath:(NSIndexPath *)indexPath
                                                              forChangeType:(NSFetchedResultsChangeType)type
                                                               newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
            
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            break;
    }
    [self.items addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView performBatchUpdates:^{
        
        for (NSDictionary *change in self.items) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        break;
                    case NSFetchedResultsChangeMove:
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        self.items = nil;
    }];
}

@end
