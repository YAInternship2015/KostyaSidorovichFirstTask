//
//  WODTableViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 01.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODTableViewController.h"
#import "WODCustomCell.h"
#import "WODDatabase.h"
#import "WODPicturesCollectionViewController.h"

static NSString *kCellIdentifier = @"WODCustomCell";

@interface WODTableViewController ()<WODDataModelDelegate>

@property (nonatomic, strong) WODDatabase *wODDB;
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    self.wODDB = [[WODDatabase alloc]initWithDelegate:self];
    self.modelArray = [NSMutableArray arrayWithArray:self.wODDB.itemArray];
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark <TableViewDataSource,delegat>

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WODCustomCell* cell =[tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                         forIndexPath:indexPath];
    [cell setupWithModel:[self.modelArray objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array{
     self.modelArray = [[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}
@end
