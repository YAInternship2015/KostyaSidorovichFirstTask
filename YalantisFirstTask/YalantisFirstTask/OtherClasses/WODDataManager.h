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

- (id)initWithDatabase:(WODDatabase *)wODDB;
#warning следующий метод можно здесь не писать, он уже объявлен в протоколе
- (void)mappingFetchPhotoWith:(NSURLResponse *)respone andData:(NSData *)data error:(NSError*)error;
- (BOOL)sendRequestForLoadPicture;

@end
