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

@interface WODSaveModelViewController ()

@property (nonatomic, weak) IBOutlet UITextField *pictureNameTextField;

@end

@implementation WODSaveModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pictureNameTextField becomeFirstResponder];
}

- (void)saveTag {
        WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
        [wodAPI setTagForRequest:self.pictureNameTextField.text];
        wodAPI.wodSave = self;
}

- (void)save {
    WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
    for (int a = 0; a < [[wodAPI valueForKey:@"imagesURL"] count]; a++) {

        [self.wODDB insertNewObjectWithPictureName:[[wodAPI valueForKey:@"imagesURL"] objectAtIndex:a] pictureIdName:[[wodAPI valueForKey:@"idNamed"] objectAtIndex:a]forSignature:[[wodAPI valueForKey:@"captionText"] objectAtIndex:a]];
   }
}

- (IBAction)saveButton:(id)sender {
    [self saveTag];
    [self.navigationController popViewControllerAnimated:YES];

}

@end
