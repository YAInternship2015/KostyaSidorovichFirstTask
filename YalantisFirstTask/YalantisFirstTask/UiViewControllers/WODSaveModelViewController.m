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
#import "WODModel.h"
#import "WODFactoryModel.h"
@interface WODSaveModelViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *pictureNameTextField;

@end

@implementation WODSaveModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pictureNameTextField becomeFirstResponder];
}

- (void)validateEnteredtext{
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
        [self saveDataToPlist:self.pictureNameTextField.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)saveDataToPlist:(NSString *)data {
    WODModel *textForFuturePicture = [WODFactoryModel modelWithText:self.pictureNameTextField.text image:nil];
    WODDatabase *wDB = [WODDatabase new];
    [wDB saveModel:textForFuturePicture];
}

- (IBAction)saveButton:(id)sender {
    [self validateEnteredtext];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self validateEnteredtext];
    return NO;
}
@end
