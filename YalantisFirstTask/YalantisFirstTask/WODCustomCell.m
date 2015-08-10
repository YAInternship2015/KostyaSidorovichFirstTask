//
//  WODCustomCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCell.h"
#import "WODCustomIOS7AlertView.h"

@implementation WODCustomCell
#warning @synthesize для простых свойств писать не нужно с Xcode 5
@synthesize image;
@synthesize name;

#warning по сути пустой метод, его нужно удалить
- (void) setSelected:(BOOL) selected animated: (BOOL) animated {
    
    [super setSelected:selected animated:animated];
}

#warning не очень осмысленное название метода, не заходя в реализацию неясно, что в нем происходит
- (IBAction)toBuy:(id)sender {
    
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
#warning по сути пустой метод, его нужно удалить
- (void)customIOS7dialogButtonTouchUpInside: (WODCustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Button at position %ld is clicked on alertView %ld.", (long)buttonIndex, (long)[alertView tag]);
}

#warning проблемы с форматированием кода
- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
        [imageView setImage:image.image];
        [demoView addSubview:imageView];
    
    return demoView;
}



@end
