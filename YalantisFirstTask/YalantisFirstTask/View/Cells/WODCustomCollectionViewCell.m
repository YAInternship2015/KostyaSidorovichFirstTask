//
//  WODCustomCollectionViewCell.m
//  YalantisFirstTask
//
//  Created by Woddi on 20.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODCustomCollectionViewCell.h"
#import "WODSignature.h"
#import <SDWebImage/SDWebImageManager.h>

@interface WODCustomCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *image;

@end
@implementation WODCustomCollectionViewCell

- (void)setupWithModel:(WODSignature *)wModel {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:(NSURL *)wModel.pictureNamed
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image && finished) {
                                self.image.image = image;
                            }
                        }];}
@end
