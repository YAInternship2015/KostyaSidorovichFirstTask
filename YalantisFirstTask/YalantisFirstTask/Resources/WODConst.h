//
//  WODConst.h
//  YalantisFirstTask
//
//  Created by Woddi on 16.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern int      const WODCellsIntervalToDownloadTableView;
extern int      const WODCellsIntervalToDownloadCollectionView;
extern float    const WODDurationAnimation;
extern int      const WODFetchBatchSize;

#pragma mark - WODInstagramAuthViewController
extern NSString *const WODInstagramRedirectURL;
extern NSString *const WODInstagramClientSecret;
extern NSString *const WODInstagramClientID;
extern NSString *const WODSegueIdentifierFromAuthVC;
extern NSString *const WODAuthString;
extern NSString *const WODValueForRequest;
extern NSString *const WODContentType;
extern NSString *const WODAPIAccessToken;

#pragma mark - WODTableViewController
extern NSString *const WODCellIdentifier;
extern NSString *const WODSignForRow;

#pragma mark - WODPicturesCollectionViewController
extern NSString *const WODReuseCollectionIdentifier;
extern NSString *const WODNibName;

#pragma mark - WODContainerViewController
extern NSString *const WODTableViewControllerIdentifier;
extern NSString *const WODCollectionViewControllerIdentifier;
extern NSString *const WODSegueIdentifierFromContainerVC;

#pragma mark - WODDatabase
extern NSString *const WODPictureSignatureAttribute;
extern NSString *const WODPictureNameAttribute;
extern NSString *const WODPictureIdAttribute;
extern NSString *const WODPictureCreationDateAttribute;

#pragma mark - WODInstagramAPIClient
extern NSString *const WODBaseURL;
extern NSString *const WODMediaRecent;