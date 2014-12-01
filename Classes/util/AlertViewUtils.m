//
//  AlertViewUtils.m
//  ViettelPI
//
//  Created by Trinh Duy Nhan on 3/27/14.
//  Copyright (c) 2014 viettel. All rights reserved.
//

#import "AlertViewUtils.h"

@implementation AlertViewUtils


+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:titleButtonCancel otherButtonTitles:otherButtontitle, nil];
    alertView.tag = tag;
    [alertView setNeedsDisplay];
    [alertView show];
    alertView = nil;
}


+ (void)showAlertViewTextInputWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:titleButtonCancel otherButtonTitles:otherButtontitle, nil];
    alertView.tag = tag;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView setNeedsDisplay];
    [alertView show];
    alertView = nil;
}


+ (void)showAlertViewTextInputWithTitle:(NSString *)title inputText:(NSString *)inputText message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:titleButtonCancel otherButtonTitles:otherButtontitle, nil];
    alertView.tag = tag;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *tf = [alertView textFieldAtIndex:0];
    [tf setText:inputText];
    [alertView setNeedsDisplay];
    [alertView show];
    alertView = nil;
}


+ (void)showAlertViewPasswordInputWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:titleButtonCancel otherButtonTitles:otherButtontitle, nil];
    alertView.tag = tag;
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView setNeedsDisplay];
    [alertView show];
    alertView = nil;
}


+ (void)showAlertViewUserPasswordWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:titleButtonCancel otherButtonTitles:otherButtontitle, nil];
    alertView.tag = tag;
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alertView setNeedsDisplay];
    [alertView show];
    alertView = nil;
}

@end
