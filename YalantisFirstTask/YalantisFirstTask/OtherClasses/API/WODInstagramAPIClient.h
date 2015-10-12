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

//@property (nonatomic, strong) NSDictionary *instagramInfo;
@property (nonatomic, strong) WODSaveModelViewController *wodSave;

+ (WODInstagramAPIClient *)sharedInstance;

- (void)setToken:(NSString *)token;
- (void)setTagForRequest:(NSString *)tag;
- (void)getInfFromInstagram;
@end
