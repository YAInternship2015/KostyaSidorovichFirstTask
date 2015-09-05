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

static NSString * const kReuseIdentifier = @"Cell";

@interface WODPicturesCollectionViewController ()<WODDataModelDelegate>

@property (nonatomic, strong) WODDatabase *wODDB;

@end

@implementation WODPicturesCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wODDB = [[WODDatabase alloc] initWithDelegate:self];
    [self.collectionView registerNib:[UINib nibWithNibName:@"WODCustomCollectionCell" bundle:nil]
          forCellWithReuseIdentifier:kReuseIdentifier];
}

#pragma mark <CollectionViewDataSource,delegat>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.wODDB modelCount];
}

- (WODCustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                         cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WODCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier
                                                                                  forIndexPath:indexPath];
    [cell setupWithModel:[self.wODDB modelAtIndex:indexPath.row]];
    return cell;
}

- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array {
    [self.collectionView reloadData];
}

@end
