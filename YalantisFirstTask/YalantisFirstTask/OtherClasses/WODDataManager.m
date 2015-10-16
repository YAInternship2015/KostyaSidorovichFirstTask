//
//  WODDataManager.m
//  YalantisFirstTask
//
//  Created by Woddi on 13.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODDataManager.h"
#import "WODInstagramAPIClient.h"
#import "WODDatabase.h"
#import "WODSaveModelViewController.h"

@interface WODDataManager ()

@property(nonatomic, strong)  WODInstagramAPIClient *wInstagramAPIClient;

@end

@implementation WODDataManager

- (id)init {
    self = [super init];
    if (self) {
        _wInstagramAPIClient = [WODInstagramAPIClient sharedInstance];
    }
    return self;
}

- (BOOL)sendRequestForLoadPicture {
    if ([[WODInstagramAPIClient sharedInstance]valueForKey:@"tag"]) {
        [self.wInstagramAPIClient loadInfFromInstagram];
        self.wInstagramAPIClient.delegate = self;
        return YES;
    }
    return NO;
}

- (void)fetchNextBatchPhotoWith:(NSURLResponse *)respone andData:(NSData *)data error:(NSError*)error {
    NSError *err;
    id val = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if(!err && !error && val && [NSJSONSerialization isValidJSONObject:val]) {
        NSArray *data = [val objectForKey:@"data"];
        dispatch_sync(dispatch_get_main_queue(),^{
            if(data) {
                for (NSDictionary *dict in data) {
                    [self.wODDB insertNewObjectWithPictureName:[[[dict valueForKey:@"images"] valueForKey:@"standard_resolution"] valueForKey:@"url"] pictureIdName:[dict valueForKey:@"id"] forSignature:[[dict valueForKey:@"caption"]valueForKey:@"text"]];
                }
            }
        });
    }
}

@end
