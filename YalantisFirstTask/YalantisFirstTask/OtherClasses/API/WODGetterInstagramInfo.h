//
//  WODGetterInstagramInfo.h
//  YalantisFirstTask
//
//  Created by Woddi on 07.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol WODDataFromInstagramDelegate <NSObject>
//
//- (void)getDataFromAPIforTag:(NSString *)tag;
//
//@end

@interface WODGetterInstagramInfo : NSObject

//- (void)getInfoFromInstagram;
- (void)didAuthWithToken:(NSString*)token forTagNmaed:(NSString *)tag;

//@property (nonatomic, assign)id <WODDataFromInstagramDelegate> delegate;

@end