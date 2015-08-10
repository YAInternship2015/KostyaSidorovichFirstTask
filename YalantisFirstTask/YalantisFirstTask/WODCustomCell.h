//
//  WODCustomCell.h
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning чего файл с ксибой ячейки оставил без префикса WOT?

@interface WODCustomCell : UITableViewCell <UIAlertViewDelegate,UIApplicationDelegate>

#warning тут снова проблема с инкапсуляцией. Не нужно показывать наружу (в *.h файле) лишние свойства/методы. Если вы напишите метод вроде setupWithModel:, в котором ячейка сама себя будет заполнять моделью, то объявления свойств переедут в *.m файл. Также нет необходимости показывать метод toBuy:, его извне никто не вызывает. Почитайте еще раз принципы SOLID
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;

- (IBAction)toBuy:(id)sender;

@end
