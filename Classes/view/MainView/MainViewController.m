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
#import "DTOWidgetTypeProcess.h"
#import "Items.h"

@interface MainViewController ()<EditWidgetViewControllerDelegate,MainViewListCellDelegate,MainViewCellDelegate>
{
    NSString *interfaceOption;
    NSUserDefaults *defaults;
    int smgSelect ; //option layout

    NSMutableArray *arrayData;
    DTOWidgetProcess *dtoWidgetProcess;
    NSMutableArray *arrayWidgetDashboard;
    IBOutlet UIButton *btnAddWidget;
    NSInteger selectIndex;

    NSMutableArray *listWidgetTypeNotUse;
    NSMutableArray *listWidgetTypeNotUseStr;
    NSMutableArray *listWidgetTypeUsed;
    DTOWidgetTypeProcess *dtoWidgetTypeProcess;
    IBOutlet UILabel *lblMessageWidget;
    
    Language *obj;
}

@property (nonatomic, retain) UIPopoverController *listPopover;

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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    //
    dtoWidgetTypeProcess = [DTOWidgetTypeProcess new];
    listWidgetTypeNotUse = [[NSMutableArray alloc] init];
    listWidgetTypeNotUseStr = [[NSMutableArray alloc] init];
    
    
    obj=[Language getInstance];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj=[Language getInstance];
    obj.str = [defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    [self setupLanguage];

    //[self.btnHome setImage:[UIImage imageNamed:@"menu_calendar"] forState:UIControlStateNormal];
    
    //[self.btnHome.]
    //[self.btnHome.imageView setAlpha:1.0f];

    [self initData];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    //load data from db
    [arrayData removeAllObjects];

    NSMutableArray *resultArr = [dtoWidgetProcess filterWithKey:DTOWIDGET_accountName withValue:@"demo"];

    for (NSDictionary *widgetDic in resultArr) {
        [arrayData addObject:[widgetDic dtoWidgetObject]];
    }
    if (arrayData.count>0) {
        [lblMessageWidget setHidden:YES];
    }else{
        [lblMessageWidget setHidden:NO];
    }

    [_tbData reloadData];


    [listWidgetTypeNotUse removeAllObjects];
    [listWidgetTypeNotUseStr removeAllObjects];
    listWidgetTypeUsed = [[NSMutableArray alloc] init];

    for (NSDictionary *widgetDic in resultArr) {
        DTOWidgetTypeObject *widgetTypeOB =[widgetDic dtoWidgetTypeObject];
        [listWidgetTypeUsed addObject:widgetTypeOB.widgetId];
    }

    NSMutableArray *listWidgetTypeDic = [dtoWidgetTypeProcess filter];
    for (NSDictionary *widgetTypeDic in listWidgetTypeDic) {
        DTOWidgetTypeObject *widgetTypeOB =[widgetTypeDic dtoWidgetTypeObject];
        if (![listWidgetTypeUsed containsObject:widgetTypeOB.widgetId]) {
            [listWidgetTypeNotUse addObject:widgetTypeOB];
            [listWidgetTypeNotUseStr addObject:widgetTypeOB.widgetName];
        }
    }
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
    
    self.fullNameLB.text = TITLE_DASHBOARD;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;

    [self.headerViewBar setBackGroundHeaderView:option];
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;


    for (UIView *viewTemp in self.view.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }

//        if ([viewTemp isKindOfClass:[UIButton class]]) {
//            ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
//            [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
//        }
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
    
    //them phan hien thi anh tren ipad air
    for (UIView *viewTemp in self.view.subviews) {
        if ([viewTemp isKindOfClass:[UIView class]]) {
            for (UIView *viewSubTemp in viewTemp.subviews) {
                
                if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                    
                    [((UIImageView*) viewSubTemp) setAlpha:1.0f];
                }
                
            }
        }
        
    }
    
    
    
    
    
}

-(void) viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}


//Home button
- (IBAction)homeBack:(id)sender {
    
    //[self.btnHome setImage:[UIImage imageNamed:@"icon_menu-1"] forState:UIControlStateNormal];
    
    [Util backToHome:self];
}

#pragma mark LANGUAGE
-(void) setupLanguage{
    
}

#pragma mark EditWidgetViewController Delegate

- (void)closeEditWidgetViewController:(EditWidgetViewController*)editWidgetViewController{
    [self initData];
}

#pragma mark Event
- (void)didFinish {

    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DTOWidgetObject *widgetOB = [arrayData objectAtIndex:indexPath.row];
    if ([widgetOB.widgetType integerValue]==0) {
        return 500;
    }
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
            [cell setDelegate:self];
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
        [cell setDelegate:self];
        [cell loadDataCellWithWidgetObject:widgetOB];
        return cell;

    }
    return nil;
}

#pragma mark Main View Cell Delegate

- (void)deleteWidgetObject:(DTOWidgetObject*)widgetOB{
    if ([dtoWidgetProcess deleteEntityWithConfId:widgetOB.confId]) {
        [arrayWidgetDashboard removeAllObjects];
        [self initData];
    }
}

- (void)updateWidgetObject:(DTOWidgetObject*)widgetOB{
    Items *items = [widgetOB itemObject];
    NSMutableDictionary * widgetDic = [items itemDictionary];

    if ([dtoWidgetProcess insertToDBWithEntity:widgetDic]) {
        [arrayWidgetDashboard removeAllObjects];
        [self initData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Sảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
}


#pragma mark Action


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

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{

    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    if (listWidgetTypeNotUse.count>0) {
        DTOWidgetTypeObject *widgetTypeOB = [listWidgetTypeNotUse objectAtIndex:index];
        [self addWidgetWithWidgetTypeOB:widgetTypeOB];

    }

}

-(void)addWidgetWithWidgetTypeOB:(DTOWidgetTypeObject*)dtoWidgetTypeOB{

    DTOWidgetObject *widgetOB = [[DTOWidgetObject alloc] init];
    widgetOB.accountName = @"demo";
    widgetOB.colorDisplay1 = @"0, 105, 178";
    widgetOB.createDate= [[NSDate date] description];
    widgetOB.isShowData = @"1";
    if ([dtoWidgetTypeOB.widgetId intValue]==WIDGET_TYPE_HUY_DONG_VON) {
        widgetOB.typeGraphically = [NSString stringWithFormat:@"%d",1];

        widgetOB.colorDisplay2 = @"242, 0, 0";
    }
    else if ([dtoWidgetTypeOB.widgetId intValue]==WIDGET_TYPE_TIN_DUNG)
    {
        widgetOB.typeGraphically = [NSString stringWithFormat:@"%d",1];

        widgetOB.colorDisplay2 = @"242, 0, 0";
    }else{
        widgetOB.typeGraphically = [NSString stringWithFormat:@"%d",0];
        widgetOB.colorDisplay2 = @"13, 35, 58";
    }
    widgetOB.widgetId = dtoWidgetTypeOB.widgetId;
    widgetOB.widgetName = dtoWidgetTypeOB.widgetName;
    widgetOB.widgetType = dtoWidgetTypeOB.widgetType;
    Items *items = [widgetOB itemObject];
    NSMutableDictionary * widgetDic = [items itemDictionary];

    if ([dtoWidgetProcess insertToDBWithEntity:widgetDic]) {
        [self initData];
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_UpdateDbFail delegate:self cancelButtonTitle:SYS_Notification_OKButton otherButtonTitles:nil];
        [alert show];
    }
}


#pragma mark Button action

-(IBAction)actionAddWidget:(id)sender
{
    if (listWidgetTypeNotUse.count>0) {
        SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];

        detail.selectIndex = selectIndex;

        detail.listData = listWidgetTypeNotUseStr;

        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = btnAddWidget.frame;

        detail.delegate =(id<SelectIndexDelegate>) self;
        self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320, HEIGHT_SELECT_INDEX_ROW*listWidgetTypeNotUseStr.count) animated:NO];
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_NoWidget delegate:self cancelButtonTitle:SYS_Notification_OKButton otherButtonTitles:nil];
        [alert show];
    }
}


@end
