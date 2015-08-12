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

@property WODDatabase *wODDB;
    
@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.wODDB = [WODDatabase new];
}

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"WODCustomCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil]
         forCellReuseIdentifier:CellIdentifier];
    
    WODCustomCell* cell = (WODCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                            forIndexPath:indexPath];
    [cell setupWithModel:[self.wODDB dataForCellsWhithIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wODDB.objectsCount;
}

@end
