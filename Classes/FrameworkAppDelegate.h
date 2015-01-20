//
//  IphoneFrameworkAppDelegate.h
//  IphoneFramework
//
//  Created by HieuNQ on 3/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface FrameworkAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
    NSString* userToken;
    NSString* sessionId;
    id services_;
}

typedef void (^AlertViewCompletionBlock)(NSInteger buttonIndex);
@property (strong,nonatomic) AlertViewCompletionBlock callback;

+ (void)showAlertView:(UIAlertView *)alertView withCallback:(AlertViewCompletionBlock)callback;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, copy) NSString* userToken;
@property (nonatomic, copy) NSString* sessionId;

//-(void) synchronizeDBWithTableName : (NSString*) tableName; hghghgh

- (void)setSample:(UIViewController *)sample ;

- (void)showRootView;

@end

