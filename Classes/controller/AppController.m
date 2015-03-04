//
//  AppController.m
//  IphoneFramework
//
//  Created by Tran Van Bang on 5/2/13.
//
//
//  
//

#import "AppController.h"
#import "AppService.h"
#import "BaseViewController.h"
#import "MainViewController.h"
#import "SVProgressHUD.h"


@implementation AppController
{
    int count;
}

static AppController *appController = nil;

+ (AppController*) getController {
    if (appController == nil) {
        appController = [[AppController alloc] init];
    }
    return appController;
}

- (void) handleViewEvent:(ActionEvent *)action {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults synchronize];
    action.timeSend = [NSDate date];
    switch (action.action) {
        case none:
            [defaults setObject:[NSDate date] forKey:CONFIG_KEY_TIMEOUT];
            break;
            case login:
            [defaults setObject:[NSDate date] forKey:CONFIG_KEY_TIMEOUT];
            break;
            case getConfigByKey:
            [defaults setObject:[NSDate date] forKey:CONFIG_KEY_TIMEOUT];
            break;
            
        default:
        {
            NSDate *dateLastRequest = [defaults valueForKey:CONFIG_KEY_TIMEOUT];
                [defaults setObject:[NSDate date] forKey:CONFIG_KEY_TIMEOUT];
                int numberSeconds = [[NSDate date] timeIntervalSinceDate:dateLastRequest];
            if (numberSeconds>CONFIG_TIMEOUT) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:Title_TimeOut_Exception delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
                
                RootViewController *rootView = [[RootViewController alloc] init];
                
                [appDel.window setRootViewController:rootView];
                
//                [dateLastRequest release];
//                [rootView release];
                
                return;
            }
            
            
        }
            break;
    }
    
    switch (action.action) {

        case login: {
            //handle strane view.
            BaseViewController* view = (BaseViewController*) action.sender;
            [view presentSmallWaiting];
            [[AppService getService] sentModelRequest:action];
        }
            break;

        default:
            [[AppService getService] sentModelRequest:action];
            break;
    }
    
}

- (void) handleModelEvent:(ModelEvent*) modelEvent {
    
            BaseViewController* view = (BaseViewController*)modelEvent.actionEvent.sender;
            [view receiveDataFromModel:modelEvent];
        
}

- (void) handleErrorEvent:(ModelEvent*) modelEvent {
    switch (modelEvent.actionEvent.action) {
            
        case none:
            break;
        case login: {
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đồng chí nhập sai tài khoản" delegate:self cancelButtonTitle:@"Nhập lại" otherButtonTitles: nil];
            [mylert show];
            [mylert release];
            BaseViewController* view = (BaseViewController*)modelEvent.actionEvent.sender;
            [view receiveErrorFromModel:modelEvent];
            [view dismissSmallWaiting];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            
            
        }
            break;
        
        default:
        {
            if (modelEvent.modelCode==Code_TimeOut && modelEvent.actionEvent.action != getListNotice && modelEvent.actionEvent.action != getListDocumentInUserNoRead && modelEvent.actionEvent.action != countHomeData) {
                
                //xoa nhung cai alert di
                for (UIWindow* window in [UIApplication sharedApplication].windows) {
                    NSArray* subviews = window.subviews;
                    if ([subviews count] > 0)
                        if ([[subviews objectAtIndex:0] isKindOfClass:[UIAlertView class]])
                            [(UIAlertView *)[subviews objectAtIndex:0] dismissWithClickedButtonIndex:[(UIAlertView *)[subviews objectAtIndex:0] cancelButtonIndex] animated:NO];
                }
                
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thông báo" message:SYS_TimeOut delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
                
                RootViewController *rootView = [[RootViewController alloc] init];
                
                
                    [rootView.view makeToast:SYS_Notification_InputConfigKey
                                duration:5.0
                                position:@"bottom"
                                   title:SYS_Notification_Title];
                
                
                [appDel.window setRootViewController:rootView];

            }else{
            BaseViewController* view = (BaseViewController*)modelEvent.actionEvent.sender;
            [view receiveErrorFromModel:modelEvent];
            [view dismissSmallWaiting];
            [view displayErrorData];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            }
        }
            break;

    }
}

//////tuannv them ham nay//////
-(void) handleModelEvent:(ModelEvent *)modelEvent :(NSInteger)userId{
    switch (modelEvent.actionEvent.action) {
       
        default:
            break;
            
    }
}

- (void) handleInternetErrorEvent:(ModelEvent*) modelEvent
{
    switch (modelEvent.actionEvent.action) {
            
        default:
        {
            BaseViewController* view = (BaseViewController*)modelEvent.actionEvent.sender;
            [view receiveErrorInternetFromModel:modelEvent];
        }
            break;
            
    }

}

-(void) dealloc
{
    [super dealloc];

}

@end
