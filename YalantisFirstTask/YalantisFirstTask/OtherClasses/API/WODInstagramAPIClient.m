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

@interface WODInstagramAPIClient ()

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *tag;

@end

@implementation WODInstagramAPIClient

+ (WODInstagramAPIClient *)sharedInstance {
    
    static WODInstagramAPIClient *instaApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instaApi == nil) {
            instaApi = [[super allocWithZone:NULL] init];
        }
    });
    return instaApi;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

+ (instancetype)alloc {
    return [self sharedInstance];
}

- (instancetype)init {
    return self;
}

- (void)setTagForRequest:(NSString *)tag {
        _tag = tag;
}

- (void)setToken:(NSString *)token {
    _token = token;
}

- (void)getInfFromInstagram {
    if(!self.token) {
        return ;
    } if (!self.tag) {
        [self.delegate alertWithMassage:@"Enter tag please"];
        return;
    }
    NSString *instagramBase = @"https://api.instagram.com/v1";
    NSString *popularURLString = [NSString stringWithFormat:@"%@/tags/%@/media/recent?access_token=%@", instagramBase, self.tag, self.token];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:popularURLString]];
    NSOperationQueue *theQ = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:theQ
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               [self.delegate fetchNextBatchPhotoWith:response andData:data error:error];
                           }];
}

@end
