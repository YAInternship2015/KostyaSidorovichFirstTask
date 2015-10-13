//
//  WODInstagramAuthenticatorWebView.h
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WODInstagramAuthViewController.h"

#warning Наделение UI объекта такой серьезной логикой, как логин - неправильный подход. Делать авторизацию нужно во вью контроллере и, если необходимо, в каких-нибудь вспомогательных хелперах и дата менеджерах

@interface WODInstagramAuthenticatorWebView : UIWebView <UIWebViewDelegate>

@property(nonatomic, weak) id<InstagramAuthCompletedDelegate> authDelegate;

@end
