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

static NSString * const kAlertTitle = @"Attention please";


@interface WODDataManager ()

#warning wInstagramAPIClient
@property(nonatomic, strong)  WODInstagramAPIClient *wInstagramAPIclient;

@end

@implementation WODDataManager

- (id)init {
    self = [super init];
    if (self) {
        _wInstagramAPIclient = [WODInstagramAPIClient sharedInstance];
    }
    return self;
}

- (void)sendRequest {
    [self.wInstagramAPIclient getInfFromInstagram];
    self.wInstagramAPIclient.delegate = self;
}
- (void)alertWithMassage:(NSString *)massage {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:kAlertTitle message:massage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
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
