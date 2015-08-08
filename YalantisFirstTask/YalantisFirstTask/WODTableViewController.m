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
@interface WODTableViewController (){
    WODDatabase *wODDB;

}

@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    wODDB = [WODDatabase new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CustomCell";
    WODCustomCell* cell = (WODCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[WODCustomCell class]])
                cell = (WODCustomCell *) oneObject;
        }
    }
    
    cell.name.text = [wODDB.pictureName objectAtIndex:indexPath.row];
    cell.image.image = [wODDB.myPicture objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return wODDB.myPicture.count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
