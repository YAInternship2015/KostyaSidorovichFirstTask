//
//  WODInstagramAPIClient.m
//  YalantisFirstTask
//
//  Created by Woddi on 10.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODInstagramAPIClient.h"
#import "WODSaveModelViewController.h"
#import "WODDataManager.h"
#import "WODConst.h"

@interface WODInstagramAPIClient ()

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSOperationQueue *theQ;

@end

@implementation WODInstagramAPIClient

+ (WODInstagramAPIClient *)sharedInstance {

    static WODInstagramAPIClient *instaApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instaApi == nil) {
            instaApi = [[self alloc] init];
        }
    });
    return instaApi;
}

- (id)init {
    self = [super init];
    if (self) {
        self.theQ = [NSOperationQueue new];
    }
    return self;
}

#warning этот метод не нужен
-(void)setToken:(NSString *)token {
    _token = token;
}

- (void)setTagForRequest:(NSString *)tag {
    _tag = tag;
}

#warning loadInfoFromInstagram
- (void)loadInfFromInstagram {
    if(!self.token) {
        return ;
    }
    NSString *instagramBase = kBaseURL;
    NSString *popularURLString = [NSString stringWithFormat:kMediaRecent, instagramBase, self.tag, self.token];
    NSMutableURLRequest *request = [[NSMutableURLRequest
                                     alloc] initWithURL:[NSURL URLWithString:popularURLString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:self.theQ
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
#warning здесь надо использовать weakSelf вместо self
                               [self.delegate fetchNextBatchPhotoWith:response andData:data error:error];
                           }];
}

@end
