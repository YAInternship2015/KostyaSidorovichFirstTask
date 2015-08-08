//
//  WODCustomCell.h
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WODCustomCell : UITableViewCell <UIAlertViewDelegate,UIApplicationDelegate>
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;
- (IBAction)toBuy:(id)sender;

@end
