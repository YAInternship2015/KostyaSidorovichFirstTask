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

#warning не нужно хранить массив, который и так есть в датасорс. Тем более, что данные в нем в какой-то момент могут не совпадать с данными в датасорсе. Это же касается и WODPicturesCollectionViewController
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#warning перенесите следующую строку в storyboard
    self.tableView.rowHeight = 80;
    self.wODDB = [[WODDatabase alloc]initWithDelegate:self];
    self.modelArray = [NSMutableArray arrayWithArray:self.wODDB.itemArray];
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark <TableViewDataSource,delegat>

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#warning относитесь серьезнее к форматированию кода, расставлению звездочек, пробелов и отступов
#warning WODCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    WODCustomCell* cell =[tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                         forIndexPath:indexPath];
#warning обращения за данными должны идти к датасорсу
    [cell setupWithModel:[self.modelArray objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning обращения за данными должны идти к датасорсу
    return self.modelArray.count;
}

- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array{
     self.modelArray = [[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}
@end
