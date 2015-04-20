//
//  MeunViewController.m
//  OfficeOneVNA
//
//  Created by Ho Ngoc Thang on 8/27/14.
//
//

#import "MenuViewController.h"
#import "Language.h"
#import "LocalizeHelper.h"

#import "FFCalendarViewController.h"
#import "ListComplainsViewController.h"
#import "ProfileViewController.h"
#import "DashboardTaskViewController.h"
#import "UIImageView+ForScrollView.h"

@interface MenuViewController ()
{
    
    __weak IBOutlet UILabel *lbGroupCustomer;
    
    __weak IBOutlet UIButton *btnCustomer;
    
    __weak IBOutlet UIButton *btnAccount360;
    
    __weak IBOutlet UIButton *btnOpportunity;
    
    __weak IBOutlet UIButton *btnMap;
    
    __weak IBOutlet UILabel *lbGroupAction;
    
    __weak IBOutlet UIButton *btnTask;
    
    __weak IBOutlet UIButton *btnCalendar;
    
    __weak IBOutlet UILabel *lbGroupUtility;
    
    __weak IBOutlet UIButton *btnReport;
    
    __weak IBOutlet UIButton *btnSetting;
    
    __weak IBOutlet UIButton *btnOptionReply;
    
    __weak IBOutlet UIButton *btnHelp;
    
    __weak IBOutlet UILabel *lbSystem;
    
    __weak IBOutlet UIButton *btnSync;
    
    __weak IBOutlet UIButton *btnCancel;
    
    
    __weak IBOutlet UIScrollView *menuScrolview;
    
    Language *obj;
}
@end

@implementation MenuViewController


@synthesize CongViecView,LichHopView,TienIchView,HeThongView;


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

    // Do any additional setup after loading the view from its nib.
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
//    [self.lbDashboard setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    if(self.currentDeviceType == iPad){
        [self.lbTask setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
        [self.lbMeetingSchedule setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
        [self.lbUtility setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
        [lbSystem setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    }
   NSString *interfaceOption = [defaults objectForKey:INTERFACE_OPTION];
    
    if (!interfaceOption || [interfaceOption isEqualToString:@"(null)"]) {
        [defaults setObject:@"1" forKey:INTERFACE_OPTION];
        interfaceOption = @"1";
    }
    if(self.currentDeviceType == iPad){
        [self.menuView2 setBackgroundColor:TOOLBAR_VIEW_COLOR];
    }
    
    obj=[Language getInstance];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj=[Language getInstance];
    obj.str = [defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    [self setupLanguage];
    
    //set content size
    menuScrolview.contentSize = CGSizeMake(menuScrolview.frame.size.width,726 );
    
    
    [self updateInterFaceWithOption: [interfaceOption intValue]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect frame = self.view.frame;
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        if(self.currentDeviceType == iPad){
            frame.origin.y = 20;
            self.view.frame = frame;
        }
    }
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    sublayer.frame = CGRectMake(frame.size.width - 1.f, 0, .5f, frame.size.height);
    [self.view.layer addSublayer:sublayer];
    
    
    //lbSystem.backgroundColor =[UIColor colorWithRed:57.0f/255.0f green:60.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
}

-(void)setupLanguage{
    
    [self.btnLogOut setTitle:LocalizedString(@"MENU_FUNCTION_CANCEL") forState:UIControlStateNormal];
    [lbGroupCustomer setText:LocalizedString(@"MENU_GROUP_CUSTOMER")];
    [btnCustomer setTitle:LocalizedString(@"MENU_FUNCTION_ACCOUNTLEAD") forState:UIControlStateNormal];
    [btnAccount360 setTitle:LocalizedString(@"MENU_FUNCTION_ACCOUNT360") forState:UIControlStateNormal];
    [btnOpportunity setTitle:LocalizedString(@"MENU_FUNCTION_OPPORTUNITY") forState:UIControlStateNormal];
    [btnMap setTitle:LocalizedString(@"MENU_FUNCTION_MAP") forState:UIControlStateNormal];
    
    [lbGroupAction setText:LocalizedString(@"MENU_GROUP_ACTION_SALE")];
    [btnTask setTitle:LocalizedString(@"MENU_FUNCTION_TASK") forState:UIControlStateNormal];
    [btnCalendar setTitle:LocalizedString(@"MENU_FUNCTION_CALENDAR") forState:UIControlStateNormal];
    [lbGroupUtility setText:LocalizedString(@"MENU_GROUP_UTILITY")];
    
    [btnReport setTitle:LocalizedString(@"MENU_FUNCTION_REPORT") forState:UIControlStateNormal];
    
    [btnSetting setTitle:LocalizedString(@"MENU_FUNCTION_SETTING") forState:UIControlStateNormal];
    
    [btnOptionReply setTitle:LocalizedString(@"MENU_FUNCTION_OPTION_REPLY") forState:UIControlStateNormal];
    
    [btnHelp setTitle:LocalizedString(@"MENU_FUNCTION_HELP") forState:UIControlStateNormal];
    
    [lbSystem setText:LocalizedString(@"MENU_GROUP_SYSTEM")];
    [btnSync setTitle:LocalizedString(@"MENU_FUNCTION_SYNC") forState:UIControlStateNormal];
    
    [btnCancel setTitle:LocalizedString(@"MENU_FUNCTION_CANCEL") forState:UIControlStateNormal];
    
    if(self.currentDeviceType == iPhone){
     [lbGroupCustomer setText: [NSString stringWithFormat:@"  %@",[StringUtil trimString:LocalizedString(@"MENU_GROUP_CUSTOMER") ]]];
     [lbGroupAction setText: [NSString stringWithFormat:@"  %@",[StringUtil trimString:LocalizedString(@"MENU_GROUP_ACTION_SALE") ]]];
     [lbGroupUtility setText: [NSString stringWithFormat:@"  %@",[StringUtil trimString:LocalizedString(@"MENU_GROUP_UTILITY") ]]];
     [lbSystem setText: [NSString stringWithFormat:@"  %@",[StringUtil trimString:LocalizedString(@"MENU_GROUP_SYSTEM") ]]];
    }
}

- (void) updateInterFaceWithOption : (int) option
{
    
    
    for (UIView *viewTemp in self.menuView2.subviews) {
        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewTemp) setAlpha:1.0f];
        }
        
    }
    
    if(self.currentDeviceType == iPad){
        self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
        self.CongViecView.backgroundColor = [UIColor whiteColor];
        
        for (UIView *viewTemp in self.DashboardView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]]) {
                [viewTemp setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagTop];
                [((UIButton*) viewTemp) setTitleColor:TEXT_COLOR_MENU_SUB forState:UIControlStateNormal];
            }
            if ([viewTemp isKindOfClass:[UILabel class]]) {
                
                [((UILabel*) viewTemp) setTextColor:TEXT_COLOR_HOME];
            }
            
        }
        
        for (UIView *viewTemp in self.CongViecView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]]) {
                [viewTemp setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagTop];
                [((UIButton*) viewTemp) setTitleColor:TEXT_COLOR_MENU_SUB forState:UIControlStateNormal];
            }
            if ([viewTemp isKindOfClass:[UILabel class]]) {
                
                [((UILabel*) viewTemp) setTextColor:TEXT_COLOR_HOME];
            }
            
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
            
            
        }
        
        self.LichHopView.backgroundColor = [UIColor whiteColor];
        
        for (UIView *viewTemp in self.LichHopView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]]) {
                [viewTemp setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagTop];
                [((UIButton*) viewTemp) setTitleColor:TEXT_COLOR_MENU_SUB forState:UIControlStateNormal];
            }
            if ([viewTemp isKindOfClass:[UILabel class]]) {
                
                [((UILabel*) viewTemp) setTextColor:TEXT_COLOR_HOME];
            }
            
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
            
        }
        
        self.TienIchView.backgroundColor = [UIColor whiteColor];
        
        for (UIView *viewTemp in self.TienIchView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]]) {
                [viewTemp setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagTop];
                [((UIButton*) viewTemp) setTitleColor:TEXT_COLOR_MENU_SUB forState:UIControlStateNormal];
            }
            if ([viewTemp isKindOfClass:[UILabel class]]) {
                
                [((UILabel*) viewTemp) setTextColor:TEXT_COLOR_HOME];
            }
            
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
            
        }
        
        self.HeThongView.backgroundColor = [UIColor whiteColor];
        
        for (UIView *viewTemp in self.HeThongView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]]) {
                [viewTemp setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagTop];
                [((UIButton*) viewTemp) setTitleColor:TEXT_COLOR_MENU_SUB forState:UIControlStateNormal];
            }
            if ([viewTemp isKindOfClass:[UILabel class]]) {
                
                [((UILabel*) viewTemp) setTextColor:TEXT_COLOR_HOME];
            }
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
        }
        
        
        
        
        [self.lbDashboard setTextColor:TEXT_COLOR_HOMEPAGE];
        [self.lbTask setTextColor:TEXT_COLOR_HOMEPAGE];
        [self.lbMeetingSchedule setTextColor:TEXT_COLOR_HOMEPAGE];
        [self.lbUtility setTextColor:TEXT_COLOR_HOMEPAGE];
        [lbSystem setTextColor:TEXT_COLOR_HOMEPAGE];
    }else{
        
        [self.menuView setBackgroundColor:[UIColor colorWithRed:62.0f/255.0f green:64.0f/255.0f blue:70.0f/255.0f alpha:1.0f]];
        
        //self.lbDashboard.backgroundColor =[UIColor colorWithRed:57.0f/255.0f green:60.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        
        lbGroupCustomer.backgroundColor =[UIColor colorWithRed:57.0f/255.0f green:60.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        for (UIView *viewTemp in self.CongViecView.subviews) {
           if ([viewTemp isKindOfClass:[UIButton class]] && viewTemp.tag != 520) {
            [self addBottomLineWithBottomControl:viewTemp.frame withInControl:CongViecView];
          
           }
            
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
        }
        
        
        lbGroupAction.backgroundColor =[UIColor colorWithRed:57.0f/255.0f green:60.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        for (UIView *viewTemp in self.LichHopView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]] && viewTemp.tag != 520) {
                [self addBottomLineWithBottomControl:viewTemp.frame withInControl:LichHopView];
                
            }
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
        }
        
        
        lbGroupUtility.backgroundColor =[UIColor colorWithRed:57.0f/255.0f green:60.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        for (UIView *viewTemp in self.TienIchView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]] && viewTemp.tag != 520) {
                [self addBottomLineWithBottomControl:viewTemp.frame withInControl:TienIchView];
                
            }
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
            }
        }


        lbSystem.backgroundColor =[UIColor colorWithRed:57.0f/255.0f green:60.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        for (UIView *viewTemp in self.HeThongView.subviews) {
            if ([viewTemp isKindOfClass:[UIButton class]] && viewTemp.tag != 520) {
                [self addBottomLineWithBottomControl:viewTemp.frame withInControl:HeThongView];
                
            }
            if ([viewTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewTemp) setAlpha:1.0f];
               // ((UIImageView*) viewTemp)
            }
        }
        
    }
}

-(void) addBottomLineWithBottomControl : (CGRect) bottomViewFrame withInControl : (UIView*) containView {
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(45, bottomViewFrame.origin.y + bottomViewFrame.size.height + 2, containView.frame.size.width - 48 - 10, 0.3f)];
    viewLine.backgroundColor = [UIColor grayColor];
    [viewLine setBorderWithOption:0];
    [containView addSubview:viewLine];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex ==1 && alertView.tag==3)
    {
        FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDel showRootView];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action_menu_home:(id)sender {
    MainViewController *targetViewController = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
     UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
}

- (IBAction)action_menu_Logout:(id)sender {
    NSString *alertStr = LocalizedString(@"KEY_ALERT_SUMMARY");
    NSString *yesStr = LocalizedString(@"KEY_ALERT_YES");
    NSString *noStr = LocalizedString(@"KEY_ALERT_NO");
    NSString *titleStr = LocalizedString(@"KEY_ALERT_TITLE");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:alertStr delegate:self cancelButtonTitle:noStr otherButtonTitles:yesStr, nil];
    alert.tag = 3;
    [alert show];
}



-(void)menuLeft
{
    return;
}


//action menu

//Khach hang dau moi = khach hang tiem nang
- (IBAction)actionDashboard:(id)sender {

    MainViewController *targetViewController = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];

    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];

}

//Khach hang dau moi = khach hang tiem nang
- (IBAction)actionPotentialCustomer:(id)sender {
    
    ListAccountLeadViewController *targetViewController = [[ListAccountLeadViewController alloc]initWithNibName:@"ListAccountLeadViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
    
}

- (IBAction)actionAccount360:(id)sender {
    
    ListAccountViewController *targetViewController = [[ListAccountViewController alloc]initWithNibName:@"ListAccountViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
    
//    ListAccountViewController *viewController = [[ListAccountViewController alloc]initWithNibName:@"ListAccountViewController" bundle:nil];
//    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)actionOpportunity:(UIButton *)sender {
    
    ListOpportunityViewController *targetViewController = [[ListOpportunityViewController alloc]initWithNibName:@"ListOpportunityViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
    
    
//    ListOpportunityViewController *viewController = [[ListOpportunityViewController alloc]initWithNibName:@"ListOpportunityViewController" bundle:nil];
//    [self presentViewController:viewController animated:YES completion:nil];
    
    
}

- (IBAction)actionCalendar:(id)sender {
    
    FFCalendarViewController *targetViewController =[FFCalendarViewController new];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
    
//    FFCalendarViewController *calendarVC = [FFCalendarViewController new];
//    [self presentViewController:calendarVC animated:YES completion:nil];
    
}

- (IBAction)actionTask:(id)sender {

    DashboardTaskViewController *targetViewController =[[DashboardTaskViewController alloc] initWithNibName:@"DashboardTaskViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];

    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];

    //    FFCalendarViewController *calendarVC = [FFCalendarViewController new];
    //    [self presentViewController:calendarVC animated:YES completion:nil];
    
}


- (IBAction)actionMapView:(id)sender {
    
    TestMapViewController *targetViewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
    targetViewController.typeMapView = typeMapView_Manager;
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
    
//    TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
//    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (IBAction)actionComplain:(id)sender {

    ListComplainsViewController *targetViewController = [[ListComplainsViewController alloc]initWithNibName:@"ListComplainsViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];

    
}

- (IBAction)actionHelp:(id)sender {
    

    
    HelpViewController *targetViewController =  [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
    
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:targetViewController];
    [navi setNavigationBarHidden:YES];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:NULL];
    [self.mm_drawerController setCenterViewController:navi withCloseAnimation:YES completion:nil];
    
}

- (IBAction)btnProfileAction:(id)sender {
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    [profileVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self presentViewController:profileVC animated:YES completion:nil];
    
}



@end
