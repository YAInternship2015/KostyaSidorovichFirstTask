//
//  WODInstagramAPIClient.h
//  YalantisFirstTask
//
//  Created by Woddi on 10.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WODSaveModelViewController;

@protocol WODLoadCompletedDelegat <NSObject>

- (void)fetchNextBatchPhotoWith:(NSURLResponse *)respone andData:(NSData *)data error:(NSError*)error;
- (void)alertWithMassage:(NSString *)massage;

@end

@interface WODInstagramAPIClient : NSObject

@property (nonatomic, retain) id<WODLoadCompletedDelegat>delegate;

+ (WODInstagramAPIClient *)sharedInstance;

- (void)setToken:(NSString *)token;
- (void)setTagForRequest:(NSString *)tag;
- (void)getInfFromInstagram;

@end

