//
//  BaseViewController.h
//  IphoneFramework
//
//  Created by Thanh Nguyen on 3/21/12.
//  Copyright (c) 2012 Viettel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ModelEvent.h"
#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import "Toast+UIView.h"
@interface BaseViewController : UIViewController {

    int numOfSmallWaiting;
}

//- (void) closeViewWithAnimation: (BOOL) animation;
//- (void) closeView;
//receive data from model
- (void) receiveDataFromModel: (ModelEvent*) modelEvent;
- (void) receiveErrorFromModel: (ModelEvent*) modelEvent;
- (void) receiveErrorInternetFromModel: (ModelEvent*) modelEvent;

- (void) presentSmallWaiting;
- (void) dismissSmallWaiting;
-(void) displayNotConnectInternet;
-(void) displayErrorData;
-(void) timeOutAction;

-(void) doException : (NSException *) ex withMessage : (NSString*) strMessage;
-(void) doException : (NSException *) ex;


/*set bottom line*/
-(void) setBottomLineDetail: (UIView*) scrollViewTemp;
-(void) addBottomLineWithBottomControl : (CGRect) bottomViewFrame withInControl : (UIView*) containView;



@end
