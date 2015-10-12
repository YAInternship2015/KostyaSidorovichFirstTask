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
//#import "WODSaveModelViewController.h"

@interface WODSaveModelViewController ()

@property (nonatomic, weak) IBOutlet UITextField *pictureNameTextField;

@end

@implementation WODSaveModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pictureNameTextField becomeFirstResponder];
}

- (void)saveData:(NSString *)data {
    
}

- (void)save {
    WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
    for (int a = 0; a < [[wodAPI valueForKey:@"imagesURL"] count]; a++) {
            [self.wODDB insertNewObjectWithPictureName:[[wodAPI valueForKey:@"imagesURL"] objectAtIndex:a] pictureIdName:[[wodAPI valueForKey:@"idNamed"] objectAtIndex:a]forSignature:[[wodAPI valueForKey:@"captionText"] objectAtIndex:a]];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)saveButton:(id)sender {
    WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
    [wodAPI setTagForRequest:self.pictureNameTextField.text];
    wodAPI.wodSave = self;
}


@end
