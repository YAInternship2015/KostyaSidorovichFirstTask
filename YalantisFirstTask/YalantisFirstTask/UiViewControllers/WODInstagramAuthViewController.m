//
//  WODInstagramAuthViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 06.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODInstagramAuthViewController.h"
#import "NSDictionary+UrlEncoding.h"
#import "WODInstagramAPIClient.h"

static NSString *const kInstagramRedirectURL = @"https://www.google.com.ua";
static NSString *const kInstagramClientSecret = @"27cc791529904236a03dbaaa6b500e7a";
static NSString *const kInstagramClientID = @"bc03d5c0fbf94750898b75920b94411a";
static NSString *const kSegueIdentifier = @"afterLogin";

@interface WODInstagramAuthViewController () 

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
    [self performSegueWithIdentifier:kSegueIdentifier sender:self];
}

-(void)authorize {
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&redirect_uri=https://www.google.com.ua&response_type=code", kInstagramClientID];
    [_authWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.authWebView stopLoading];
    if([error code] == -1009) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Cannot open the page because it is not connected to the Internet."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *responseURL = [request.URL absoluteString];
    NSString *urlCallbackPrefix = [NSString stringWithFormat:@"%@/?code=", kInstagramRedirectURL];
    
    if([responseURL hasPrefix:urlCallbackPrefix]) {
#warning было бы неплохо эту логику вынести в отдельный дата менеджер и апи клиент
        NSString *authToken = [responseURL substringFromIndex:[urlCallbackPrefix length]];
        NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   authToken, @"code",
                                   kInstagramRedirectURL, @"redirect_uri",
                                   @"authorization_code", @"grant_type",
                                   kInstagramClientID, @"client_id",
                                   kInstagramClientSecret, @"client_secret", nil];
        
        NSString *paramString = [paramDict urlEncodedString];
        NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        [request setHTTPMethod:@"POST"];
        [request addValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset] forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
        
        self.tokenRequestConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
            [wodAPI setToken:accesstoken];
            [self pushToContainerVC];
            return;
        }
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse {
    return request;
}

@end
