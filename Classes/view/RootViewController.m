//
//  RootViewController.m
//  IphoneFramework
//
//  Created by Tran Van Bang on 5/2/13.
//
//
//

#import "RootViewController.h"
#import "ActionEvent.h"
#import "AppController.h"
#import "SVProgressHUD.h"
#import "MainViewController.h"



@interface RootViewController ()
{
    NSUserDefaults *defaults;
    MainViewController *mainView;
    NSString *versionSoftware;
}

@end

@implementation RootViewController

@synthesize tf_username;
@synthesize tf_password;
@synthesize childView;
@synthesize webView;

#pragma mark - Init

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
    NSDictionary *dTmp=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    versionSoftware = [dTmp objectForKey:@"CFBundleShortVersionString"];
        //set focus
    [self initData];
    
    obj=[Language getInstance];
    obj.str = [defaults objectForKey:@"Language"];
    if ([StringUtil stringIsEmpty:obj.str] ) {
        obj.str = @"vi";
        [defaults setObject:@"vi" forKey:@"Language"];
    }
    LocalizationSetLanguage(obj.str);
    [self setUpLanguage];

    
    //Hien thi anh cua form
    for (UIView *viewTemp in self.childView.subviews) {


        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewTemp) setAlpha:1.0f];
        }

        for (UIView *subview in viewTemp.subviews) {

            if ([subview isKindOfClass:[UIImageView class]]) {

                [((UIImageView*) subview) setAlpha:1.0f];
            }

            for (UIView *subviewLev2 in subview.subviews) {

                if ([subviewLev2 isKindOfClass:[UIImageView class]]) {

                    [((UIImageView*) subviewLev2) setAlpha:1.0f];
                }
            }
        }
    }
    [self.navigationController setNavigationBarHidden:YES];
}


-(void) initData {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:versionSoftware forKey:@"versionSoftware"];
    
    NSString *userNameStr = [defaults objectForKey:@"userName"];
    if (userNameStr) {
        tf_username.text = userNameStr;
    }
    else
    {
        tf_username.text =@"";
    }
    
    self.lblVersion.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    
    
    NSString *strSiteUrl = NO_CONFIG_SITE_URL;
    NSString *strServiceUrl = NO_CONGIG_VOFFICE_PATH;
    NSString *strDepartmentConfigName = NO_CONFIG_TITLE_DEPARTMENT;
    NSMutableDictionary *userConfig = [defaults objectForKey:USER_CONFIG];
    if (!userConfig) {
        userConfig = [[NSMutableDictionary alloc]init];
        [userConfig setValue:strSiteUrl forKey:USER_CONFIG_SITEURL];
        [userConfig setValue:strServiceUrl forKey:USER_CONFIG_SERVICES_URL];
        [userConfig setValue:NO_CONFIG_TITLE_DEPARTMENT forKey:USER_CONFIG_DEPARTMENT_TITLE];
        [defaults setObject:userConfig forKey:USER_CONFIG];
    }
    strSiteUrl = [userConfig objectForKey:USER_CONFIG_SITEURL];
    strServiceUrl = [userConfig objectForKey:USER_CONFIG_SERVICES_URL];
    strDepartmentConfigName = [userConfig objectForKey:USER_CONFIG_DEPARTMENT_TITLE];
    
    
    GlobalVars *globals = [GlobalVars sharedInstance];
    globals.siteUrl = strSiteUrl;
    globals.serviceUrl = strServiceUrl;
    
    //tf_username.text = macAddress;
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor blackColor];
    //self.btnLogin.backgroundColor = BUTTON_ACTIVE_COLOR_1;
    self.lblVersion.textColor = TEXT_TOOLBAR_COLOR1;
    
    if (![strDepartmentConfigName isEqualToString:NO_CONFIG_TITLE_DEPARTMENT]) {
        
        if (userNameStr) {
            [tf_password becomeFirstResponder];
        }
        else
        {
            tf_username.text =@"";
            [tf_username becomeFirstResponder];
        }
    }
}


- (void) removeDataBaseWhenUpdate
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:DATABASE_NAME];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self resetUserDefault];
    //[FileManagerUtil removeFilesFromDocuments];
    
    NSString *interfaceOption = [defaults objectForKey:INTERFACE_OPTION];
    
    if (!interfaceOption || [interfaceOption isEqualToString:@"(null)"]) {
        [defaults setObject:@"1" forKey:INTERFACE_OPTION];
    }
}

- (void) viewDidAppear:(BOOL)animated
{
}

-(void) resetUserDefault
{
    //xoa cac gia tri cua nsdefault
    defaults = [NSUserDefaults standardUserDefaults];
    //[defaults removeObjectForKey:USER_LOGIN];
    [defaults setBool:NO forKey:@"firstload"];
    [defaults synchronize];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tf_password || textField == tf_username) {
        [textField resignFirstResponder];
        [self logIn];
        return NO;
    }
    return YES;
}
- (void) logIn
{
    
    FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
    MainViewController *viewController =   [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    //viewController.userData = modelEvent.modelData;
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:viewController];

    
    [navi setNavigationBarHidden:YES];
    
    MenuViewController *leftController = [[MenuViewController alloc] init];
    
    MMDrawerController *drawerControllerMainProgramHome = [[MMDrawerController alloc]
                                                           initWithCenterViewController:navi
                                                           leftDrawerViewController:leftController
                                                           rightDrawerViewController:NULL];
    [drawerControllerMainProgramHome setShouldStretchDrawer:FALSE];
    if(self.currentDeviceType == iPad){
        [drawerControllerMainProgramHome setMaximumLeftDrawerWidth:259];
    }else{
        [drawerControllerMainProgramHome setMaximumLeftDrawerWidth:210];
    }
    [drawerControllerMainProgramHome setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerControllerMainProgramHome setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [UIView transitionWithView:appDel.window
                      duration:0.8
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        [appDel.window setRootViewController:drawerControllerMainProgramHome];
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:nil];
    
    return;
    
    if ([self validate]) {
        
//        if ([[NetworkHelper sharedManager] isNetworkAvaiable] == NO )  {
//            [AlertViewUtils showAlertViewWithTitle:KEY_NOTIFICATION_TITLE message:VLD_01_005 delegate:self withTag:0 withTitleButtonCancel:nil withTitleButtonOther:KEY_NOTIFICATION_OTHER];
//        } else  {
            //[ListMeetingProcess deleteAllObject];
        NSString *username = [[StringUtil trimString:self.tf_username.text] lowercaseString];
        NSString *password = [StringUtil trimString:self.tf_password.text];
            /**
             *  Tam thoi kiem tra login success/fail bang cach nay
             */
            
            
                NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                [dic setObject: username forKey: @"loginName" ];
                [dic setObject: password forKey: @"password" ];
                ActionEvent* actionEvent = [[ActionEvent alloc] init];
                actionEvent.action = login;
                actionEvent.viewData = dic;
                actionEvent.sender = self;
                [[AppController getController] handleViewEvent:actionEvent];
                
                defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:tf_username.text forKey:POST_USERNAME];
                [defaults synchronize];
            
            
        //}
    }
}


/**
 *  Author: luongdv3
 *  - Validate login form
 *
 *  @return
 */
- (BOOL) validate {
    // Check username
    NSString *strUserName = [StringUtil trimString:self.tf_username.text];
    if (strUserName.length ==0) { //Chua nhap username
        self.tf_username.text =@"";
        [AlertViewUtils showAlertViewWithTitle:KEY_NOTIFICATION_TITLE message:VLD_01_001 delegate:self withTag:11 withTitleButtonCancel:nil withTitleButtonOther:KEY_NOTIFICATION_OTHER];
        return NO;
    }
    
    NSRange ranger = [strUserName rangeOfString:@" "];
    if (strUserName.length>100 || ranger.location < strUserName.length) {//username khong hop le khi >100 ky tu hoac co ky tu khoang trang
        [AlertViewUtils showAlertViewWithTitle:KEY_NOTIFICATION_TITLE message:VLD_01_002 delegate:self withTag:12 withTitleButtonCancel:nil withTitleButtonOther:KEY_NOTIFICATION_OTHER];
        return NO;
    }
    NSString *strPassword = [StringUtil trimString:self.tf_password.text];
    if (strPassword.length==0) { //Chua nhap password
        [AlertViewUtils showAlertViewWithTitle:KEY_NOTIFICATION_TITLE message:VLD_01_003 delegate:self withTag:13 withTitleButtonCancel:nil withTitleButtonOther:KEY_NOTIFICATION_OTHER];
        return NO;
    }
    NSRange rangerPassword = [strPassword rangeOfString:@" "];
    if (strPassword.length>100 || rangerPassword.location < strPassword.length) { //Password khong hop le
        [AlertViewUtils showAlertViewWithTitle:KEY_NOTIFICATION_TITLE message:VLD_01_002 delegate:self withTag:14 withTitleButtonCancel:nil withTitleButtonOther:KEY_NOTIFICATION_OTHER];
        return NO;
    }
    
    return YES;
}


/**
 *  Author: luongdv3
 *  @param alertView
 *  @param buttonIndex
 */
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 11: //Chua nhap username
            [self.tf_username becomeFirstResponder];
            break;
        case 12: //username khong hop le
            self.tf_password.text = @"";
            [self.tf_username becomeFirstResponder];
            break;
        case 13: //Chua nhap password
            [self.tf_password becomeFirstResponder];
            break;
        case 14: //Password khong hop le
            self.tf_password.text = @"";
            [self.tf_password becomeFirstResponder];
            break;
        case 15: //login failed
            self.tf_password.text = @"";
            [self.tf_username becomeFirstResponder];
            break;
        default:
            break;
    }
}

#pragma mark - Actions
- (IBAction) login_click: (id) sender {
    [self logIn];
    [tf_password resignFirstResponder];
    [tf_username resignFirstResponder];
}

#pragma mark - HTTP
- (void) receiveDataFromModel:(ModelEvent *)modelEvent {
    switch (modelEvent.actionEvent.action) {
        case login:
        {
            ActionEvent* action = [[ActionEvent alloc] init];
            action.action = showMainView;
            action.sender = self;
            action.userData = modelEvent.modelData;
            [self handleViewEvent:action];
        }
            break;
            
        default:
            break;
    }
    

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (void) handleViewEvent:(ActionEvent *)action {
    
    switch (action.action) {
        case showMainView:
        {
            mainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            action.sender = mainView;
            //mainView.userData = action.userData;
            mainView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:mainView animated:YES completion:nil];
        }
            break;
            
        default:
            break;
            
    }
}


#pragma mark - Methods
-(void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
    for (UIView* view in childView.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
            [view resignFirstResponder];
    }
}


#pragma mark - End

- (void)viewDidUnload
{
    [self setChildView:nil];
    [self setWebView:nil];
    
    self.tf_password = nil;
    self.tf_username = nil;
    self.webView = nil;
    [self setBtnLogin:nil];
    [self setImgLoginFrame:nil];
    [self setImgLoginBackGround:nil];
    versionSoftware = nil;
    defaults = nil;
    [super viewDidUnload];
    
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


- (IBAction)action_introduction:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Introduct_OfficeOne.pdf"];
    
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    NSFileManager *man = [NSFileManager defaultManager];
    NSDictionary *attrs = [man attributesOfItemAtPath: filePath error: NULL];
    long long result = [attrs fileSize];
    //btnDeleteDoc.hidden = YES;
    NSString* theFileName = [filePath lastPathComponent];
    
    
    if (result > 0) {
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
        
        if (document != nil)         {
            
            
            ReaderViewController *readerViewController= [[ReaderViewController alloc] initWithReaderDocument:document];
            
            
            //xem co ghi chu o day khong?
            readerViewController.delegate =(id<ReaderViewControllerDelegate>) self;
            
            readerViewController.isCommentEnable = YES;
            readerViewController.isViewComment = NO;
            
            
            
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
            
            [self.navigationController pushViewController:readerViewController animated:YES];
            
#else
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentModalViewController:readerViewController animated:YES];
            
#endif
            
        }
        
        
    }
    else
    {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:SYS_Notification_Warming message:SYS_Notification_FileNotExist delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles: nil];
        myAlert.tag =3;
        [myAlert show];
        [FileManagerUtil removeFileWithName:theFileName];
    }
}


- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	//NSLog(@"%s", __FUNCTION__);
#endif
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
#endif
}


#pragma mark language
- (IBAction)vietnamLanguageChoose:(id)sender {
    obj.str=@"vi";
    LocalizationSetLanguage(@"vi");
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj.str forKey:@"Language"];
    [self setUpLanguage];
    
}

- (IBAction)englishLanguageChoose:(id)sender {
    obj.str=@"en";
    LocalizationSetLanguage(@"en");
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj.str forKey:@"Language"];
    [self setUpLanguage];
}

-(void)setUpLanguage{
    [tf_username setPlaceholder:LocalizedString(@"KEY_ACCOUNT")];
    [tf_password setPlaceholder:LocalizedString(@"KEY_PASSWORD")];
    [self.btnLogin setTitle:LocalizedString(@"KEY_LOGIN") forState:UIControlStateNormal];
    [self.btnGioiThieu setTitle:LocalizedString(@"KEY_ABOUT") forState:UIControlStateNormal];
}



@end
