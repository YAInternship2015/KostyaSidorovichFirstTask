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
#warning используйте свойства вместо ivar'ов. Свойства позволяют модифицировать поведение в классах-наследниках
    WODDatabase *wODDB;

}

@end

@implementation WODTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    wODDB = [WODDatabase new];
}

#warning нет смысла в реализации данного метода в данном задании. Все ячейки одной высоты, поэтому это значение лучше задавать либо в сториборде в таблице, либо в коде через свойств rowHeight таблицы. Если бы ячейки были разной высоты, тогда да, использовался бы этот метод
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CustomCell";
    WODCustomCell* cell = (WODCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
#warning эта проверка не нужна была бы, если использовать метод - (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath, который всегда возвращает ячейку
    if (cell == nil) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[WODCustomCell class]])
                cell = (WODCustomCell *) oneObject;
        }
    }
#warning заполнение ячейки данными надо инкапсулировать в самой ячейке
    cell.name.text = [wODDB.pictureName objectAtIndex:indexPath.row];
    cell.image.image = [wODDB.myPicture objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return wODDB.myPicture.count;
}

#warning по сути пустой метод, надо удалять
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
