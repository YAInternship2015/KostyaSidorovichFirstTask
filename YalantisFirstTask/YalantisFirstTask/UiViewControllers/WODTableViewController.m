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
#import "WODSignature.h"
#import "WODDataManager.h"
#import "WODConst.h"

@interface WODTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) WODDataManager *manager;

@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wODDB = [[WODDatabase alloc] initWithDelegate:self];
    self.manager = [[WODDataManager alloc]initWithDatabase:self.wODDB];
    [self.tableView registerNib:[UINib nibWithNibName:WODCellIdentifier bundle:nil]
         forCellReuseIdentifier:WODCellIdentifier];
    if ([self.wODDB modelCountForSections:0] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Attention please", nil) message:NSLocalizedString(@"Enter tag", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark <TableViewDataSource,delegat>

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    WODSignature *wSignature = [self.wODDB modelAtIndexPath:indexPath];
    UIAlertView *fullTag = [[UIAlertView alloc]initWithTitle:WODSignForRow message:wSignature.pictureSignature delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [fullTag show];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.wODDB modelCountForSections:0] - WODCellsIntervalToDownloadTableView) {
        if(![self.manager sendRequestForLoadPicture]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Attention please", nil) message:NSLocalizedString(@"Enter tag please", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.wODDB deleteModelWithIndex:indexPath];
    }
}

- (WODCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WODCustomCell *cell =[tableView dequeueReusableCellWithIdentifier:WODCellIdentifier
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
