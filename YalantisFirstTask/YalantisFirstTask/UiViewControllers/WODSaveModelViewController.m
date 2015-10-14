//
//  WODSaveModelViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODSaveModelViewController.h"
#import "WODDatabase.h"
#import "WODInstagramAPIClient.h"
#import "WODDataManager.h"

@interface WODSaveModelViewController ()

@property (nonatomic, weak) IBOutlet UITextField *pictureNameTextField;

@end

@implementation WODSaveModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pictureNameTextField becomeFirstResponder];
}

- (IBAction)saveButton:(id)sender {
    WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
    [wodAPI setTagForRequest:self.pictureNameTextField.text];
    _manager = [WODDataManager new];
    self.manager.wODDB = self.wODDB;
    [self.manager sendRequest];
    [self.navigationController popViewControllerAnimated:YES];

}

@end
