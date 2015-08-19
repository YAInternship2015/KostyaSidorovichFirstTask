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

static NSString *kCellIdentifier = @"WODCustomCell";

@interface WODTableViewController ()

@property (nonatomic, strong) WODDatabase *wODDB;
    
@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    self.wODDB = [WODDatabase new];
    
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
}

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WODCustomCell* cell =[tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                                            forIndexPath:indexPath];
    [cell setupWithModel:[self.wODDB modelAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wODDB.objectsCount;
}

@end
