//
//  MeunViewController.h
//  OfficeOneVNA
//
//  Created by Ho Ngoc Thang on 8/27/14.
//
//

#import <UIKit/UIKit.h>
#import "DDMenuController.h"
#import "FrameworkAppDelegate.h"
#import "MainViewController.h"
#import "HelpViewController.h"
#import "EnumClass.h"
#import "SelectIndexViewController.h"

@interface MenuViewController : BaseViewController<UIActionSheetDelegate,SelectIndexDelegate>

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *menuView2;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIView *DashboardView;

@property (weak, nonatomic) IBOutlet UIView *CongViecView;
@property (weak, nonatomic) IBOutlet UIView *LichHopView;
@property (weak, nonatomic) IBOutlet UIView *TienIchView;
@property (weak, nonatomic) IBOutlet UIView *HeThongView;

@property (weak, nonatomic) IBOutlet UILabel *lbDashboard;
@property (weak, nonatomic) IBOutlet UILabel *lbTask;
@property (weak, nonatomic) IBOutlet UILabel *lbMeetingSchedule;
@property (weak, nonatomic) IBOutlet UILabel *lbUtility;
//@property (weak, nonatomic) IBOutlet UILabel *lbSystem;
@property (weak, nonatomic) IBOutlet UIButton *btnLogOut;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////
@end
