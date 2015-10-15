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

#warning достаточно метода sharedInstance, в котором вызовется просто new, следующие три метода не нужны
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

#warning такой сеттер можно удалить
- (void)setToken:(NSString *)token {
    _token = token;
}

#warning этот метод нужно переименовать + вместо get лучше писать load или request, потому что операция не мгновенная
- (void)getInfFromInstagram {
    if(!self.token) {
        return ;
    } if (!self.tag) {
#warning в api клиенте должен только отправляться запрос. Все проверки токенов и инициирование алертов должны происходить в том коде, который обращается к api клиенту
        [self.delegate alertWithMassage:@"Enter tag please"];
        return;
    }
    NSString *instagramBase = @"https://api.instagram.com/v1";
    NSString *popularURLString = [NSString stringWithFormat:@"%@/tags/%@/media/recent?access_token=%@", instagramBase, self.tag, self.token];
    NSMutableURLRequest *request = [[NSMutableURLRequest
                                     alloc] initWithURL:[NSURL URLWithString:popularURLString]];
#warning нет стоит создавать отдельную очередь для каждого запроса. Можно очередь добавить как проперти у api клиента и создавать ее в init'е
    NSOperationQueue *theQ = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:theQ
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
#warning здесь нужна
                               [self.delegate fetchNextBatchPhotoWith:response andData:data error:error];
                           }];
}

@end
