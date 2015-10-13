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
#import "WODInstagramAPIClient.h"

static NSString *kCellIdentifier = @"WODCustomCell";

@interface WODTableViewController ()<NSFetchedResultsControllerDelegate>

@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wODDB = [[WODDatabase alloc] initWithDelegate:self];
    [self.tableView registerNib:[UINib nibWithNibName:kCellIdentifier bundle:nil]
         forCellReuseIdentifier:kCellIdentifier];
}

#pragma mark <TableViewDataSource,delegat>
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
#warning странный метод. Почему просто не получать объект-модели и затем здесь брать у него нужное свойство?
    NSString *fullTagName = [self.wODDB selectedRowStringWithModel:[self.wODDB modelAtIndexPath:indexPath]];
#warning строковые константы надо поместить в Localizable.strings
    UIAlertView *fullTag = [[UIAlertView alloc]initWithTitle:@"Full name" message:fullTagName delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [fullTag show];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
#warning цифра 2 должна быть в константах
    if (indexPath.row == [self.wODDB modelCountForSections:0] - 2) {
        WODInstagramAPIClient *instClient = [WODInstagramAPIClient sharedInstance];
        [instClient setTagForRequest:nil];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.wODDB deleteModelWithIndex:indexPath];
    }
}

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WODCustomCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIdentifier
                                                         forIndexPath:indexPath];
    [cell setupWithModel:[self.wODDB modelAtIndexPath:indexPath]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.wODDB modelCountForSections:section];
}

#pragma mark - core data

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            break;
    }
}

@end
