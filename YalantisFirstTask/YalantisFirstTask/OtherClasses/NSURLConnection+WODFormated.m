//
//  NSURLRequest+WODFormated.m
//  YalantisFirstTask
//
//  Created by Woddi on 16.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "NSURLConnection+WODFormated.h"
#import "WODConst.h"
#import "NSDictionary+UrlEncoding.h"

@implementation NSURLConnection (WODFormated)

- (NSURLConnection *)formatedURLConnectionAuthTokenString:(NSString *)authToken delegate:(id)delegate {
    NSURL *url = [NSURL URLWithString:WODAPIAccessToken];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSDictionary *paramDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               authToken,               @"code",
                               WODInstagramRedirectURL,   @"redirect_uri",
                               @"authorization_code",   @"grant_type",
                               WODInstagramClientID,      @"client_id",
                               WODInstagramClientSecret,  @"client_secret", nil];
    
    NSString *paramString = [paramDict urlEncodedString];
    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    [request setHTTPMethod:@"POST"];
    [request addValue:[NSString stringWithFormat:WODValueForRequest,charset] forHTTPHeaderField:WODContentType];
    [request setHTTPBody:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
    return [[NSURLConnection alloc] initWithRequest:request delegate:delegate];
}

@end
