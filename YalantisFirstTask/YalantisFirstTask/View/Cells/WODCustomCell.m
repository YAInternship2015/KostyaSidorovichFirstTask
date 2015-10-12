//
//  WODCustomCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCell.h"
#import "Signature.h"
#import <SDWebImage/SDImageCache.h>
@interface WODCustomCell ()

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *image;

@end

@implementation WODCustomCell

- (void)setupWithModel:(Signature *)wModel {
    self.image.image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:wModel.pictureIdNamed];
    self.name.text = wModel.pictureSignature;
}

@end
