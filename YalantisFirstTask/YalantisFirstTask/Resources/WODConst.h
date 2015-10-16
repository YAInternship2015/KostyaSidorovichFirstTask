//
//  WODConst.h
//  YalantisFirstTask
//
//  Created by Woddi on 16.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int      const kCellsIntervalToDownloadTableView;
extern int      const kCellsIntervalToDownloadCollectionView;
extern float    const kDurationAnimation;
extern int      const kFetchBatchSize;

#pragma mark - WODInstagramAuthViewController
extern NSString *const kInstagramRedirectURL;
extern NSString *const kInstagramClientSecret;
extern NSString *const kInstagramClientID;
extern NSString *const kSegueIdentifierFromAuthVC;
extern NSString *const kAuthString;
extern NSString *const kValueForRequest;
extern NSString *const kContentType;
extern NSString *const kAPIAccessToken;

#pragma mark - WODTableViewController
extern NSString *const kCellIdentifier;
extern NSString *const kSignForRow;

#pragma mark - WODPicturesCollectionViewController
extern NSString *const kReuseCollectionIdentifier;
extern NSString *const kNibName;

#pragma mark - WODContainerViewController
extern NSString *const kTableViewControllerIdentifier;
extern NSString *const kCollectionViewControllerIdentifier;
extern NSString *const kSegueIdentifierFromContainerVC;

#pragma mark - WODDatabase
extern NSString *const kPictureSignatureAttribute;
extern NSString *const kPictureNameAttribute;
extern NSString *const kPictureIdAttribute;
extern NSString *const kPictureCreationDateAttribute;

#pragma mark - WODInstagramAPIClient
extern NSString *const kBaseURL;
extern NSString *const kMediaRecent;