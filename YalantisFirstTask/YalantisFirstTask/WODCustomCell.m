//
//  WODCustomCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCell.h"
#import "WODCustomIOS7AlertView.h"
#import "WODModel.h"
@interface WODCustomCell ()

#warning айтлеты принято помечать как weak, так как ими владеет, в данном случае, сама ячейка. Пока ячейки жива, аутлеты тоже живы. Как только ячейка становится nil, все ее аутлеты также становятся nil
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end

@implementation WODCustomCell

- (void)setupWithModel:(WODModel *)wModel {
#warning здесь не нужна пустая строка
    self.image.image = wModel.myPikture;
    self.name.text = wModel.picturesName;
}

- (IBAction)showAlertWhenPressed:(id)sender {
#warning здесь не нужна пустая строка
    WODCustomIOS7AlertView *alertView = [[WODCustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
        
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(WODCustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}


- (UIView *)createDemoView {
    
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    
    [imageView setImage:self.image.image];
    [demoView addSubview:imageView];
    
    return demoView;
}

@end
