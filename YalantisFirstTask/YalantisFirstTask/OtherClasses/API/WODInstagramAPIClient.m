//
//  WODInstagramAPIClient.m
//  YalantisFirstTask
//
//  Created by Woddi on 10.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODInstagramAPIClient.h"
#import "WODGetterInstagramInfo.h"
#import "WODSaveModelViewController.h"

@interface WODInstagramAPIClient ()

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSMutableArray *idNamed;
@property (nonatomic, strong) NSMutableArray *captionText;
@property (nonatomic, strong) NSMutableArray *imagesURL;

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

-(void)setTagForRequest:(NSString *)tag {
    self.imagesURL = [NSMutableArray new];
    self.captionText = [NSMutableArray new];
    self.idNamed = [NSMutableArray new];
    
    if (tag) {
        _tag = tag;
    } if (self.tag) {
        WODGetterInstagramInfo *wodInfos = [WODGetterInstagramInfo new];
        [wodInfos didAuthWithToken:self.token forTagNmaed:self.tag];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Pictures finished" message:@"Enter name for search" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)setToken:(NSString *)token {
    _token = token;
}

- (void)getInfFromInstagram {
    [self.wodSave save];
}

@end
