//
//  WODSaveModelViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODSaveModelViewController.h"
#import "WODModelValidator.h"
#import "WODDatabase.h"
#import "WODInstagramAPIClient.h"
//#import "WODSaveModelViewController.h"

@interface WODSaveModelViewController ()

@property (nonatomic, weak) IBOutlet UITextField *pictureNameTextField;
@property (nonatomic, weak) NSString *curentTag;
@end

@implementation WODSaveModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pictureNameTextField becomeFirstResponder];
}

- (void)validateEnteredtext {
    NSError *error = nil;
    WODModelValidator *wValidate = [WODModelValidator new];
    BOOL isValidName = [wValidate isValidModelTitle:self.pictureNameTextField.text error:&error];
    if (!isValidName) {
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:[error localizedDescription]
                                                       message:[error localizedFailureReason]
                                                      delegate:nil
                                             cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                             otherButtonTitles:nil];
        [aller show];
    } else {
        [self saveData:self.pictureNameTextField.text];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TagDidReceived" object:self.pictureNameTextField.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)saveData:(NSString *)data {
    WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
    [wodAPI setTagForRequest:self.curentTag];
    wodAPI.wodSave = self;
}

- (void)save {
    WODInstagramAPIClient *wodAPI = [WODInstagramAPIClient sharedInstance];
    for (int a = 0; a < [[wodAPI valueForKey:@"imagesURL"] count]; a++) {
//        if (![self.wODDB existenceIdName:[[wodAPI valueForKey:@"idNamed"] objectAtIndex:a]]) {
            [self.wODDB insertNewObjectWithPictureName:[[wodAPI valueForKey:@"imagesURL"] objectAtIndex:a] pictureIdName:[[wodAPI valueForKey:@"idNamed"] objectAtIndex:a]forSignature:[[wodAPI valueForKey:@"captionText"] objectAtIndex:a]];
//        } else {
//            [self.wODDB replaceParametrsSignature:[[wodAPI valueForKey:@"captionText"] objectAtIndex:a] pictureName:[[wodAPI valueForKey:@"imagesURL"] objectAtIndex:a] forIdName:[[wodAPI valueForKey:@"idNamed"] objectAtIndex:a]];
//        }
        

    }
    
//    NSLog(@"0 = %@",[[wodAPI valueForKey:@"imagesURL"]objectAtIndex:0]);
//    NSLog(@"1 =  %lu",(unsigned long)[[wodAPI valueForKey:@"imagesURL"] count]);
}
- (IBAction)saveButton:(id)sender {
    _curentTag = self.pictureNameTextField.text;
    [self validateEnteredtext];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self validateEnteredtext];
    return NO;
}


@end
