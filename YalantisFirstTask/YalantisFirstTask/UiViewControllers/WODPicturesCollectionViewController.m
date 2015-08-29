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
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation WODPicturesCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.wODDB = [[WODDatabase alloc]initWithDelegate:self];
    self.modelArray = [NSMutableArray arrayWithArray:self.wODDB.itemArray];
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(120, 120);
    layout.minimumInteritemSpacing = 0;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"WODCustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:kReuseIdentifier];
}


#pragma mark <CollectionViewDataSource,delegat>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (WODCustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                         cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WODCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier
                                                                                  forIndexPath:indexPath];
    [cell setupWithModel:[self.modelArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array{
    self.modelArray = [NSMutableArray arrayWithArray:array];
    [self.collectionView reloadData];
}
@end
