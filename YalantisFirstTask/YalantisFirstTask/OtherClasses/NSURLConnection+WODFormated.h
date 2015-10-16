//
//  NSURLRequest+WODFormated.h
//  YalantisFirstTask
//
//  Created by Woddi on 16.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (WODFormated)

- (NSURLConnection *)formatedURLConnectionAuthTokenString:(NSString *)authToken delegate:(id)delegate;

@end
