//
//  WODCustomCollectionViewCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 20.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCollectionViewCell.h"
#import "WODModel.h"

@interface WODCustomCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation WODCustomCollectionViewCell

- (void)setupWithModel:(WODModel *)wModel {
    self.image.image = wModel.myPikture;    
}
@end
