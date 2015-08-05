//
//  TableViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 01.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"

@interface TableViewController (){
    
    NSArray *myArray;
}


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    myArray = [NSArray arrayWithObjects:@"а",@"б",@"в",@"г",@"д",@"е",@"ж",@"з",@"и",@"й", nil];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CustomCell";
    CustomCell* cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[CustomCell class]])
                cell = (CustomCell *) oneObject;
        }
    }
    cell.name.text = [myArray objectAtIndex:indexPath.row];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"природа %li.jpeg",(long)indexPath.row]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myArray.count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
