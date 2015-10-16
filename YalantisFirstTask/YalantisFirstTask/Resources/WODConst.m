//
//  WODConst.m
//  YalantisFirstTask
//
//  Created by Woddi on 16.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODConst.h"

int     const WODCellsIntervalToDownloadTableView = 2;
int     const WODCellsIntervalToDownloadCollectionView = 4;
float   const WODDurationAnimation = 0.1;
int     const WODFetchBatchSize = 20;

NSString *const WODInstagramRedirectURL = @"https://www.google.com.ua";
NSString *const WODInstagramClientSecret = @"27cc791529904236a03dbaaa6b500e7a";
NSString *const WODInstagramClientID = @"bc03d5c0fbf94750898b75920b94411a";
NSString *const WODSegueIdentifierFromAuthVC = @"afterLogin";
NSString *const WODAuthString = @"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&redirect_uri=https://www.google.com.ua&response_type=code";
NSString *const WODValueForRequest = @"application/x-www-form-urlencoded; charset=%@";
NSString *const WODContentType = @"Content-Type";
NSString *const WODAPIAccessToken = @"https://api.instagram.com/oauth/access_token";
NSString *const WODCellIdentifier = @"WODCustomCell";
NSString *const WODSignForRow = @"Full name";
NSString *const WODReuseCollectionIdentifier = @"Cell";
NSString *const WODNibName = @"WODCustomCollectionCell";
NSString *const WODTableViewControllerIdentifier = @"Table";
NSString *const WODCollectionViewControllerIdentifier = @"Collection";
NSString *const WODSegueIdentifierFromContainerVC = @"pushSaveViewController";
NSString *const WODPictureSignatureAttribute = @"pictureSignature";
NSString *const WODPictureNameAttribute = @"pictureNamed";
NSString *const WODPictureIdAttribute = @"pictureIdNamed";
NSString *const WODPictureCreationDateAttribute = @"currentDate";
NSString * const WODBaseURL = @"https://api.instagram.com/v1";
NSString * const WODMediaRecent = @"%@/tags/%@/media/recent?access_token=%@";