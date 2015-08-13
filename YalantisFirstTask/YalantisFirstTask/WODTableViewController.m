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
@interface WODTableViewController ()

#warning не забывайте писать nonatomic/atomic, strong/assign/weak/copy
@property WODDatabase *wODDB;
    
@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.wODDB = [WODDatabase new];
}

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#warning мы пишем всё camelCase'ом, локальные константы принято помечать преставкой k, вроде kCellReuseIdentifier
    static NSString *CellIdentifier = @"WODCustomCell";
    
#warning эту строку надо выполнять только один раз, там же, где Вы задавали высоту ячейки
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
#warning WODCustomCell* cell -> WODCustomCell *cell, (WODCustomCell *) [tableView ... -> (WODCustomCell *)[tableView ...
    WODCustomCell* cell = (WODCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                            forIndexPath:indexPath];
    [cell setupWithModel:[self.wODDB dataForCellsWhithIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wODDB.objectsCount;
}

@end
