//
//  MainViewController.m
//  VofficeIpad2
//
//  Created by Tran Van Bang on 6/19/13.
//
//

#import "MainViewController.h"
#import "UIView+AUISelectiveBorder.h"
#import "MainViewCell.h"
#import "MainViewListCell.h"
#import "ListComplainsViewController.h"
#import "ProfileViewController.h"
#import "FFEvent.h"
#import "FFImportantFilesForCalendar.h"

#import "FFEvent.h"
#import "FFImportantFilesForCalendar.h"

#import "FFCalendarViewController.h"
#import "DTOWidgetProcess.h"

#import "DTOWidgetObject.h"
#import "NSDictionary+QS.h"

#import "EditWidgetViewController.h"

@interface MainViewController ()
{
    NSString *interfaceOption;
    NSUserDefaults *defaults;
    int smgSelect ; //option layout

    NSMutableArray *arrayData;
    DTOWidgetProcess *dtoWidgetProcess;
    NSMutableArray *arrayWidgetDashboard;
}
@end

@implementation MainViewController

NSString* emptyText = @"";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}


#pragma mark Appear
//Ham nay chay lan dau khi view duoc hien thi
- (void)viewDidLoad
{
    [super viewDidLoad];

    dtoWidgetProcess = [DTOWidgetProcess new];
    arrayData = [[NSMutableArray alloc] init];
    arrayWidgetDashboard = [[NSMutableArray alloc] init];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //[SVProgressHUD show];
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];

    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];

    //

}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    //load data from db
    NSMutableArray *resultArr = [dtoWidgetProcess filterWithKey:DTOWIDGET_accountName withValue:@"demo"];

    for (NSDictionary *widgetDic in resultArr) {
        [arrayData addObject:[widgetDic dtoWidgetObject]];
    }
    [_tbData reloadData];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    interfaceOption = [defaults objectForKey:INTERFACE_OPTION];

    if (!interfaceOption || [interfaceOption isEqualToString:@"(null)"]) {
        [defaults setObject:@"1" forKey:INTERFACE_OPTION];
    }
    [self updateInterFaceWithOption:[interfaceOption intValue]];
}


- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;

    [self.headerViewBar setBackGroundHeaderView:option];
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;


    for (UIView *viewTemp in self.view.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }

        if ([viewTemp isKindOfClass:[UIButton class]]) {
            ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
            [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
        }
        if ([viewTemp isKindOfClass:[UITextView class]]) {
            ((UITextView*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextView*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewTemp isKindOfClass:[UITextField class]]) {
            ((UITextField*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextField*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextField*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextField*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
    }
}

-(void) viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

#pragma mark Event
- (void)didFinish {

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTOWidgetObject *widgetOB = [arrayData objectAtIndex:indexPath.row];

    if ([widgetOB.widgetType intValue]==0) {
        static NSString *cellId = @"MainViewCell";
        MainViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
        if ([arrayWidgetDashboard containsObject:cell]) {
            return cell;
        }else{
            if (!cell) {
                [self.tbData registerNib:[UINib nibWithNibName:@"MainViewCell" bundle:nil] forCellReuseIdentifier:@"MainViewCell"];
                cell = [[MainViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId WithType:[widgetOB.typeGraphically intValue]];
            }
            [cell loadDataCellWithWidgetObject:widgetOB];
            [arrayWidgetDashboard addObject:cell];
            return cell;
        }
    } else if ([widgetOB.widgetType intValue]==1) {

        static NSString *cellId = @"MainViewListCell";

        MainViewListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            [self.tbData registerNib:[UINib nibWithNibName:@"MainViewListCell" bundle:nil] forCellReuseIdentifier:@"MainViewListCell"];
            cell = [[MainViewListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];

        }

        [cell loadDataCellWithWidgetObject:widgetOB];
        return cell;

    }
    return nil;
}

#pragma mark Action

- (IBAction)logOut:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đồng chí có muốn đăng xuất không ?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
    alert.tag = 3;
    [alert show];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex ==1 && alertView.tag==3)
    {
        FrameworkAppDelegate *appDel = (FrameworkAppDelegate*)[[UIApplication sharedApplication] delegate];
        RootViewController *rootView = [[RootViewController alloc] init];
        [appDel.window setRootViewController:rootView];
    }

}

#pragma mark end

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




- (void)viewDidUnload {

    [super viewDidUnload];
}

#pragma mark Button action

-(IBAction)actionAddWidget:(id)sender
{
    EditWidgetViewController *editWidgetVC = [[EditWidgetViewController alloc] init];

    [self presentViewController:editWidgetVC animated:YES completion:nil];
}

- (IBAction)actionDashBoard:(id)sender {
}
//Khach hang dau moi = khach hang tiem nang
- (IBAction)actionPotentialCustomer:(id)sender {
    ListAccountLeadViewController *viewController = [[ListAccountLeadViewController alloc]initWithNibName:@"ListAccountLeadViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];

}

- (IBAction)actionAccount360:(id)sender {
    ListAccountViewController *viewController = [[ListAccountViewController alloc]initWithNibName:@"ListAccountViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)actionOpportunity:(UIButton *)sender {

    ListOpportunityViewController *viewController = [[ListOpportunityViewController alloc]initWithNibName:@"ListOpportunityViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];


}

- (IBAction)actionCalendar:(id)sender {

    FFCalendarViewController *calendarVC = [FFCalendarViewController new];
    [self presentViewController:calendarVC animated:YES completion:nil];

}

- (IBAction)actionMapView:(id)sender {

    TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];

}

- (IBAction)actionComplain:(id)sender {

    ListComplainsViewController *viewController = [[ListComplainsViewController alloc]initWithNibName:@"ListComplainsViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];

}

- (IBAction)actionHelp:(id)sender {

    TestEditViewController *viewController = [[TestEditViewController alloc]initWithNibName:@"TestEditViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];

}

- (IBAction)btnProfileAction:(id)sender {
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    [profileVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self presentViewController:profileVC animated:YES completion:nil];
    
}

@end
