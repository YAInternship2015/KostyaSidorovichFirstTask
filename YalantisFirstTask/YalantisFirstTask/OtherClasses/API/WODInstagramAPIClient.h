//
//  WODInstagramAPIClient.h
//  YalantisFirstTask
//
//  Created by Woddi on 10.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WODSaveModelViewController;
@interface WODInstagramAPIClient : NSObject

@property (nonatomic, strong) WODSaveModelViewController *wodSave;
@property (nonatomic, assign) BOOL firstLoad;
+ (WODInstagramAPIClient *)sharedInstance;

- (void)setToken:(NSString *)token;
- (void)setTagForRequest:(NSString *)tag;
- (void)getInfFromInstagram;

@end
