//
//  WODCustomCollectionViewCell.h
//  YalantisFirstTask
//
//  Created by Woddi on 20.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WODSignature;

@interface WODCustomCollectionViewCell : UICollectionViewCell

- (void)setupWithModel:(WODSignature *)wModel;

@end
