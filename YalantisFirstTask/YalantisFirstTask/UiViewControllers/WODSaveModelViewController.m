//
//  WODSaveModelViewController.m
//  YalantisFirstTask
//
//  Created by Woddi on 27.08.15.
//  Copyright (c) 2015 Woddi. All rights reserved.
//

#import "WODSaveModelViewController.h"
#import "WODValidateModel.h"
#import "WODDatabase.h"
#import "WODModel.h"
#import "WODFactoryModel.h"
@interface WODSaveModelViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameForPicture;
@property (nonatomic, strong) WODValidateModel *wValidate;

@end

@implementation WODSaveModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wValidate = [WODValidateModel new];
    [self.nameForPicture becomeFirstResponder];
    self.nameForPicture.delegate = self;
}
- (void)validateEnterText{
    NSError *error = nil;
    BOOL correctNameOrNot = [self.wValidate isValidModelTitle:self.nameForPicture.text error:&error];
    if (!correctNameOrNot) {
        UIAlertView *aller = [[UIAlertView alloc]initWithTitle:[error localizedDescription]
                                                       message:[error localizedFailureReason]
                                                      delegate:nil
                                             cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                             otherButtonTitles:nil];
        [aller show];
    } else {
        [self saveDataToPlist:self.nameForPicture.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)saveDataToPlist:(NSString *)data {
    WODModel *textForFuturePicture = [WODFactoryModel createObjectWithText:self.nameForPicture.text image:nil];
    WODDatabase *wDB = [WODDatabase new];
    [wDB saveModelToPlist:textForFuturePicture];
}

- (IBAction)saveButton:(id)sender {
    [self validateEnterText];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self validateEnterText];
    return NO;
}
@end
