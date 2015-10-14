//
//  WODDataManager.h
//  YalantisFirstTask
//
//  Created by Woddi on 13.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODInstagramAPIClient.h"

@class WODDatabase;

@interface WODDataManager : NSObject <WODLoadCompletedDelegat>

@property (nonatomic, strong) WODDatabase *wODDB;

- (void)fetchNextBatchPhotoWith:(NSURLResponse *)respone andData:(NSData *)data error:(NSError*)error;
- (void)sendRequest;

@end
