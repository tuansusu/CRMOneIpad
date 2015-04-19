//
//  RootViewController.h
//  IphoneFramework
//
//  Created by Tran Van Bang on 5/2/13.
//
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "ReaderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CALayer.h>

//menu
#import "DDMenuController.h"
#import "MenuViewController.h"


@interface RootViewController : BaseViewController <ReaderViewControllerDelegate, UIAlertViewDelegate,UITextFieldDelegate>{
    IBOutlet UITextField* tf_username;
    IBOutlet UITextField* tf_password;
    __weak IBOutlet UILabel *lbAppTitle;
    
    Language *obj;

}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UITextField* tf_username;
@property (nonatomic, retain) IBOutlet UITextField* tf_password;

@property (weak, nonatomic) IBOutlet UIView *childView;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIImageView *imgLoginBackGround;
@property (weak, nonatomic) IBOutlet UIImageView *imgLoginFrame;

- (IBAction) login_click: (id) sender;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;

- (IBAction)action_introduction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnGioiThieu;

- (IBAction)vietnamLanguageChoose:(id)sender;
- (IBAction)englishLanguageChoose:(id)sender;


@end
