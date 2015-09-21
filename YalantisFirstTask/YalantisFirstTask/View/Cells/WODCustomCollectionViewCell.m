//
//  WODCustomCollectionViewCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 20.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCollectionViewCell.h"
#import "Signature.h"

@interface WODCustomCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *image;

@end
@implementation WODCustomCollectionViewCell

- (void)setupWithModel:(Signature *)wModel {
    self.image.image =[UIImage imageNamed:wModel.pictureNamed];
}
@end
