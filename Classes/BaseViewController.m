//
//  BaseViewController.m
//  IphoneFramework
//
//  Created by Tran Van Bang on 6/3/13.
//  Copyright (c) 2012 Viettel. All rights reserved.
//

#import "BaseViewController.h"
#import "FrameworkAppDelegate.h"
#import "AppController.h"
#import "RootViewController.h"
#import "FrameworkAppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    numOfSmallWaiting = 0;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor blackColor];

}

-(void) timeOutAction{

    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:Title_TimeOut_Exception delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    RootViewController *rootView = [[RootViewController alloc] init];
    
    [appDel.window setRootViewController:rootView];
    
    
}


//- (void) closeViewWithAnimation: (BOOL) animation {
//    FrameworkAppDelegate* iphoneDelegate = [FrameworkAppDelegate getInstance];
//    [iphoneDelegate.navigationController popViewControllerAnimated:animation];
//}
//
//- (void) closeView {
//    FrameworkAppDelegate* iphoneDelegate = [FrameworkAppDelegate getInstance];
//    [iphoneDelegate.navigationController popViewControllerAnimated:YES];
//}

- (void) receiveDataFromModel: (ModelEvent*) modelEvent {

}
- (void) receiveErrorFromModel: (ModelEvent*) modelEvent {
    
}

- (void) receiveErrorInternetFromModel: (ModelEvent*) modelEvent
{
    
}


//waiting network
- (void) presentSmallWaiting {
	numOfSmallWaiting ++;
    [SVProgressHUD show];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) dismissSmallWaiting {
	numOfSmallWaiting --;
	if (numOfSmallWaiting < 0) {
		numOfSmallWaiting = 0;
	}
	if (numOfSmallWaiting > 0) {
        [SVProgressHUD show];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	} else {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
	}
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}


-(void) displayNotConnectInternet{

    // Make toast with a title
    [self.view makeToast:@"Mất kết nối internet hoặc không tìm thấy máy chủ"
                duration:3.0
                position:@"bottom"
                   title:@"Cảnh báo !"];
//    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
//    [dic setObject: @"start" forKey: @"username"];
//    [dic setObject: @"start" forKey: @"password"];
//    ActionEvent* actionEvent = [[ActionEvent alloc] init];
//    actionEvent.action = none;
//    actionEvent.viewData = dic;
//    actionEvent.sender = self;
//    [[AppController getController] handleViewEvent:actionEvent];

}

-(void) displayErrorData{
    
    // Make toast with a title
    [self.view makeToast:@"Có lỗi dữ liệu trả về từ máy chủ"
                duration:3.0
                position:@"bottom"
                   title:@"Cảnh báo !"];
    
}


//
-(void) doException : (NSException *) ex{
    //ghi loi cho nguoi dung va thong bao
    [LogUtil writeLogWithException:ex];
    //thong bao loi chung chung
    [self.view makeToast:@"Có lỗi xảy ra."
                duration:3.0
                position:@"bottom"
                   title:@"Cảnh báo !"];
}

-(void) doException : (NSException *) ex withMessage : (NSString*) strMessage{
    //ghi loi cho nguoi dung va thong bao
    [LogUtil writeLogWithException:ex];
    //
    [self.view makeToast:strMessage
                duration:3.0
                position:@"bottom"
                   title:@"Cảnh báo !"];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        return YES;
    }
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        return YES;
    }
    
    else
        return NO;
    
}

@end
