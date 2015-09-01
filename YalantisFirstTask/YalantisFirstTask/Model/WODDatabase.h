//
//  WODDatabase.h
//  YalantisFirstTask
//
//  Created by Woddi on 08.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODModel.h"

#warning имена нотификейшнов стоит вынести в отдельный файл WODNotifications.h, и объявить их там константами в формате:
//  static NSString *const WODDataFileContentDidChangeNotificationName = @"WODDataFileContentDidChangeNotification"
OBJC_EXTERN NSString * const kWODDataFileContentDidChangeNotification;
OBJC_EXTERN NSString * const kWODTitleUserInfoKey;

@protocol WODDataModelDelegate;

#warning почему датасорс отнаследован от модели?
@interface WODDatabase : WODModel

#warning зачем показывать массив в *.h?
@property (nonatomic, strong) NSMutableArray *itemArray;
#warning зачем это здесь?
@property (nonatomic, weak) NSString *tempStringForNotification;

- (WODModel *)modelAtIndex:(NSInteger)index;
- (instancetype)initWithDelegate:(id<WODDataModelDelegate>)delegate;

#warning лучше просто saveModel:, кроме датасорса никто не должен знать о способе хранения данных
- (void)saveModelToPlist:(WODModel *)model;

@end

@protocol WODDataModelDelegate <NSObject>
@required
- (void)dataWasChanged:(WODDatabase *)data array:(NSArray *)array;

@end