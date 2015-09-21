//
//  WODCustomCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCell.h"
#import "Signature.h"
@interface WODCustomCell ()

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *image;

@end

@implementation WODCustomCell

- (void)setupWithModel:(Signature *)wModel {
    self.image.image = [UIImage imageNamed:wModel.pictureNamed];
    self.name.text = wModel.pictureSignature;
}

@end
