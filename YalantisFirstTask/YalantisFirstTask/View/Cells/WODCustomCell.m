//
//  WODCustomCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 02.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCell.h"
#import "WODSignature.h"
#import <SDWebImage/SDWebImageManager.h>
@interface WODCustomCell ()

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UIImageView *image;

@end

@implementation WODCustomCell

- (void)setupWithModel:(WODSignature *)wModel {
    self.name.text = wModel.pictureSignature;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:(NSURL *)wModel.pictureNamed
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                self.image.image = image;
                            }
                        }];
}

@end
