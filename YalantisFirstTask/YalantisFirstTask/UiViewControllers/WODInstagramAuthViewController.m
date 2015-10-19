//
//  WODInstagramAuthViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODInstagramAuthViewController.h"
#import "WODInstagramAPIClient.h"
#import "WODConst.h"
#import "NSURLConnection+WODFormated.h"

@interface WODInstagramAuthViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *tokenRequestConnection;
@property (nonatomic, weak) IBOutlet UIWebView *authWebView;

@end

@implementation WODInstagramAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.authWebView.delegate = self;
    self.data = [NSMutableData data];
    [self authorize];
}

- (void)pushToContainerVC {
    [self performSegueWithIdentifier:WODSegueIdentifierFromAuthVC sender:self];
}

-(void)authorize {
    NSString *url = [NSString stringWithFormat:WODAuthString, WODInstagramClientID];
    [_authWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.authWebView stopLoading];
    if([error code] == -1009) {
#warning @"Error" также нужно локализировать
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:NSLocalizedString(@"Cannot open", nil)
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *responseURL = [request.URL absoluteString];
    NSString *urlCallbackPrefix = [NSString stringWithFormat:@"%@/?code=", WODInstagramRedirectURL];
    
    if([responseURL hasPrefix:urlCallbackPrefix]) {
        NSString *authToken = [responseURL substringFromIndex:[urlCallbackPrefix length]];
        
        self.tokenRequestConnection = [[NSURLConnection alloc] formatedURLConnectionAuthTokenString:authToken delegate:self];
        [self.tokenRequestConnection start];
        return NO;
    }
    return YES;
}

#pragma Mark NSURLConnection delegates

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)kData {
    [self.data appendData:kData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.data setLength:0];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *jsonError = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
    if(jsonData && [NSJSONSerialization isValidJSONObject:jsonData]) {
        NSString *accesstoken = [jsonData objectForKey:@"access_token"];
        if (accesstoken) {
            WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
#warning лучше в интерфейс WODInstagramAPIClient добавить метод setToken:, реализовывать его не нужно, потому что есть свойство token. KVC это конечно хорошо, но если имя свойства изменится, то этот код будет крешить приложение
            [wodAPI setValue:accesstoken forKey:@"token"];
            [self pushToContainerVC];
            return;
        }
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
    return request;
}

@end
