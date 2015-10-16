//
//  WODConst.m
//  YalantisFirstTask
//
//  Created by Woddi on 16.10.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODConst.h"

int     const kCellsIntervalToDownloadTableView = 2;
int     const kCellsIntervalToDownloadCollectionView = 4;
float   const kDurationAnimation = 0.1;
int     const kFetchBatchSize = 20;

NSString *const kInstagramRedirectURL = @"https://www.google.com.ua";
NSString *const kInstagramClientSecret = @"27cc791529904236a03dbaaa6b500e7a";
NSString *const kInstagramClientID = @"bc03d5c0fbf94750898b75920b94411a";
NSString *const kSegueIdentifierFromAuthVC = @"afterLogin";
NSString *const kAuthString = @"https://api.instagram.com/oauth/authorize/?client_id=%@&display=touch&redirect_uri=https://www.google.com.ua&response_type=code";
NSString *const kValueForRequest = @"application/x-www-form-urlencoded; charset=%@";
NSString *const kContentType = @"Content-Type";
NSString *const kAPIAccessToken = @"https://api.instagram.com/oauth/access_token";
NSString *const kCellIdentifier = @"WODCustomCell";
NSString *const kSignForRow = @"Full name";
NSString *const kReuseCollectionIdentifier = @"Cell";
NSString *const kNibName = @"WODCustomCollectionCell";
NSString *const kTableViewControllerIdentifier = @"Table";
NSString *const kCollectionViewControllerIdentifier = @"Collection";
NSString *const kSegueIdentifierFromContainerVC = @"pushSaveViewController";
NSString *const kPictureSignatureAttribute = @"pictureSignature";
NSString *const kPictureNameAttribute = @"pictureNamed";
NSString *const kPictureIdAttribute = @"pictureIdNamed";
NSString *const kPictureCreationDateAttribute = @"currentDate";
NSString * const kBaseURL = @"https://api.instagram.com/v1";
NSString * const kMediaRecent = @"%@/tags/%@/media/recent?access_token=%@";