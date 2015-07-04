//
//  DetailLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/20/14.
//
//

#import "DetailLeadViewController.h"

#import <EventKit/EventKit.h>

#import "DTOACCOUNTLEADProcess.h"
#import "DTOCONTACTProcess.h"
#import "DTOTASKProcess.h"
#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"
#import "DTOOPPORTUNITYProcess.h"
#import "EnumClass.h"


#import "TaskCalendarCell.h"
#import "TaskCalTLineCell.h"
#import "TaskActionCell.h"
#import "ComplainsView.h"
#import "ComplainDetailViewController.h"
#import "ComplainModel.h"
////remove
#import "StringUtil.h"
#import "Validator.h"
#import "Globals.h"

#define TITLE_APP @"KHÁCH HÀNG TIỀM NĂNG"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_NOTE 1
#define SELECT_INDEX_ADD_CALENDAR 2
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_OPPORTUNITY 4
#define SELECT_INDEX_ADD_COMPLAIN 5

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_NOTE @"GHI CHÚ"
#define SELECT_TEXT_ADD_CALENDAR @"SỰ KIỆN"
#define SELECT_TEXT_ADD_TASK @"CÔNG VIỆC"
#define SELECT_TEXT_ADD_OPPORTUNITY @"CƠ HỘI"
#define SELECT_TEXT_ADD_COMPLAIN @"Ý KIẾN PHẢN HỒI"

#define DELETE_CONTAC 11
#define DELETE_NOTE 22
#define DELETE_CALENDAR 33
#define DELETE_TASK 44
#define DELETE_COHOI 55
#define DELETE_LEAD 66
#define WIDTH_HEADER_EXPAND_INFO 800

static NSString* const TaskCalendarNormalCellId   = @"TaskCalendarCellId";
static NSString* const TaskCalendarTimelineCellId = @"TaskCalTLineCellId";
static NSString* const TaskActionCellId           = @"TaskActionCellId";

@interface DetailLeadViewController () <TaskActionCellDelegate,ComplainDetailViewControllerDelegate,EditCalendarLeadViewControllerDelegate,ComplainsViewDelegate>
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOCONTACTProcess *dtoContactProcess; //lay danh sach du lieu theo clientLeadId
    DTOTASKProcess *dtoTaskProcess;
    DTONOTEProcess *dtoNoteProcess;
    DTOATTACHMENTProcess *dtoAttachProcess;
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    
    NSUserDefaults *defaults ;
    
    
    UIColor *textColorButtonNormal; //mau chu button binh thuong
    UIColor *textColorButtonSelected; //mau chu button select
    UIColor *backgrondButtonSelected; //mau nen button select
    UIColor *backgroundButtonNormal; //Mau nen button binh thuong
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    NSDictionary *dicData; //Data cua thang xem chi tiet
    NSString *leadType ; //
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    //delete note
    NSString *deleteNoteId;
    //delete file
    NSString *deleteFileClienWithClientNoteID;
    NSString *deleteItem;
    NSString *deleteContact;
    NSString *deleteCalenda;
    NSString *delTask;
    NSString*myDevice;
    
    //controll
    
    __weak IBOutlet UIButton *btnAdd;
    
    //calendar
    BOOL calendarIsTimeline;
    
    IBOutlet UIScrollView *scrollViewHeaderExpandInfo;
    IBOutlet  ComplainsView* viewComplain;
    Language *obj;
}
@end

@implementation DetailLeadViewController
@synthesize typeActionEvent;

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
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
        
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }
    
    /* set defaults cell for Task Calendar */
    [self.tbData registerNib:[TaskCalendarCell nib] forCellReuseIdentifier:TaskCalendarNormalCellId];
    [self.tbData registerNib:[TaskCalTLineCell nib] forCellReuseIdentifier:TaskCalendarTimelineCellId];
    [self.tbData registerNib:[TaskActionCell   nib] forCellReuseIdentifier:TaskActionCellId];
    
    // calendar
    calendarIsTimeline = YES;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj=[Language getInstance];
    obj.str=[defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionExpandInfo:self.btnExpandInfo];
    
    [scrollViewHeaderExpandInfo setContentSize:CGSizeMake(WIDTH_HEADER_EXPAND_INFO, scrollViewHeaderExpandInfo.frame.size.height)];
    [_scrollviewCN setContentSize:CGSizeMake(320, _scrollviewCN.frame.size.height+20)];
    [_scrollviewDN setContentSize:CGSizeMake(320, _scrollviewDN.frame.size.height +60)];
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setLanguage];
    myDevice=[UIDevice currentDevice].model;
    if([myDevice isEqualToString:@"iPhone"] || [myDevice isEqualToString:@"iPhone Simulator"]){
        [[_myTabbar.items objectAtIndex:0] setTitle:LocalizedString(@"KEY_DETAIL")];
        [[_myTabbar.items objectAtIndex:1] setTitle:LocalizedString(@"KEY_360_CONTACT")];
        [[_myTabbar.items objectAtIndex:2] setTitle:LocalizedString(@"KEY_360_NOTE")];
        [[_myTabbar.items objectAtIndex:3] setTitle:LocalizedString(@"KEY_360_CALENDAR")];
        [[_myTabbar.items objectAtIndex:4] setTitle:LocalizedString(@"KEY_360_YKIEN")];
        [_myTabbar setSelectedItem:0];
        [_scrollviewCN setContentSize:CGSizeMake(320, _scrollviewCN.frame.size.height+350)];
        [_scrollviewDN setContentSize:CGSizeMake(320, _scrollviewDN.frame.size.height +450)];
        self.myTabbar.barTintColor=[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        [self.myTabbar setSelectedItem:self.myTabbar.items[0]];
    }
}

-(void) viewWillAppear:(BOOL)animated{
    //cu quay lai la no load
    NSLog(@"quay lai form");
    [self loadDataWithTypeAction:typeActionEvent];
    [self initData];
    [self setButtonSelect];
    
}

-(void) setButtonSelect {
    self.mySearchBar.text=@"";
    switch (typeActionEvent) {
        case typeLeaderView_ExpandInfo:{
            
        }
            break;
        case typeLeaderView_Contact:
        {
            [self displayNormalButtonState:self.btnExpandInfo];
        }break;
        case typeLeaderView_Note:
        {
            
            [self displayNormalButtonState:self.btnNote];
        }break;
        case typeLeaderView_Opportunity:{
            [self displayNormalButtonState:self.btnOpportunity];
        }break;
        case typeLeaderView_Calendar:
        {
            [self displayNormalButtonState:self.btnCalendar];
        }
            break;
        case typeLeaderView_Task:
        {
            [self displayNormalButtonState:self.btnTask];
        }
            break;
            
        case typeLeaderView_Complains:
        {
            
        }
            break;
        case typeLeaderView_ProductsLead:
        {
            //[self displayNormalButtonState:];
        }
            break;
        default:
            break;
    }
}


//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR, SELECT_TEXT_ADD_TASK, SELECT_TEXT_ADD_OPPORTUNITY,SELECT_TEXT_ADD_COMPLAIN, nil];
    listArr  = [NSArray arrayWithObjects:LocalizedString(@"KEY_360_CONTACT"),LocalizedString(@"KEY_360_NOTE"), LocalizedString(@"KEY_360_CALENDAR")
                , LocalizedString(@"KEY_360_NHIEMVU"), LocalizedString(@"KEY_360_COHOI"), LocalizedString(@"KEY_360_YKIEN"), nil];
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    dtoTaskProcess= [DTOTASKProcess new];
    dtoNoteProcess = [DTONOTEProcess new];
    dtoAttachProcess=[DTOATTACHMENTProcess new];
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    NSLog(@"datasend detail lead = %@", self.dataSend);
    dicData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[self.dataSend objectForKey:DTOLEAD_id]];
    NSLog(@"Get detail = %@", dicData);
    //[self actionExpandInfo:self.btnExpandInfo];
    //[self loadDataWithTypeAction:typeActionEvent];
    if ([dicData isKindOfClass:[NSNull class]] || dicData==nil ) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    if ([dicData objectForKey:DTOLEAD_leadType]) {
        leadType = ObjectToStr([dicData objectForKey:DTOLEAD_leadType]);
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        self.lbName.text =[dicData objectForKey:DTOLEAD_name];
    }
    if ([leadType isEqualToString:FIX_LEADTYPE_BUSSINESS]) {
        if ([self currentDeviceType]==iPhone) {
            [_viewDetailIP addSubview:_scrollviewDN];
        }else{
            [self.viewlef addSubview:_scrollviewDN];
        }
        [self loadDetailCustomerBussinessData];
        
    }else{
        
        if ([self currentDeviceType]==iPhone) {
            [_viewDetailIP addSubview:_scrollviewCN];
        }else{
            [self.viewlef addSubview:_scrollviewCN];
        }
        [self loadDetailCustomerPersonalData];
    }
    
    
    
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    //[self actionExpandInfo:self.btnExpandInfo];
    //arrayData  = [NSArray new];
    [_tbData reloadData];
}

/*
 *Load danh sach khach hang ca nhan
 */
-(void) loadDetailCustomerPersonalData {
    _lbAddress.numberOfLines = 2;
    [_lbAddress sizeToFit];
    //code
    _lbCode.text=[NSString stringWithFormat:@"%@: %@",LocalizedString(@"KEY_LEAD_CODE"),[dicData objectForKey:DTOLEAD_clientLeadId]];
    //name
    _lbName.text=[dicData objectForKey:DTOLEAD_name];
    //cmt
    _lbAlias.text=[dicData objectForKey:DTOLEAD_identifiedNumber];
    //sex
    _lbSex.text=[dicData objectForKey:DTOLEAD_sex];
    //birth day
    _lbBirthDay.text=[dicData objectForKey:DTOLEAD_birthday];
    //staus
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_marialStatus]]) {
        
        if ([ObjectToStr([dicData objectForKey:DTOLEAD_marialStatus]) isEqualToString:@"0"]) {
            _lbMarialStatus.text=@"Chưa kết hôn";
        }else if ([ObjectToStr([dicData objectForKey:DTOLEAD_marialStatus]) isEqualToString:@"1"]){
            _lbMarialStatus.text=@"Đã kết hôn";
        }
        
    }
    //phone
    _lbPhone.text=[dicData objectForKey:DTOLEAD_mobile];
    //mail
    _lbEmail.text=[dicData objectForKey:DTOLEAD_email];
    //address
    _lbAddress.text=[dicData objectForKey:DTOLEAD_address];
    ///thu nhap ca nha
    _lbThuNhapCN.text=[dicData objectForKey:DTOLEAD_monthlyIncome];
    ///thu nhap ca nha
    _lbTongThuNhap.text=[dicData objectForKey:DTOLEAD_assetTotal];
    NSString *sms =@"";
    NSString *disableSms = [dicData objectForKey:DTOLEAD_disableSms];
    if([disableSms isEqualToString:@"0"])
    {
        sms=@"SMS";
    }
    NSString *phone=@"";
    NSString *disablePhone = [dicData objectForKey:DTOLEAD_disablePhone];
    if ([disablePhone isEqualToString:@"0"]) {
        phone=@"Phone";
    }
    NSString *email=@"";
    NSString *disableEmail= [dicData objectForKey:DTOLEAD_disableEmail];
    if([disableEmail isEqualToString:@"0"]){
        email=@"Email";
    }
    NSString *tmp=[NSString stringWithFormat:@"%@,%@,%@",sms,phone,email];
    //goi nho
    if (tmp.length>3) {
        _lbKhongLienLacQua.text=tmp;
    }
    else{
        _lbKhongLienLacQua.text=@"";
    }
}


/*
 *Load danh sach khach hang doanh nghiep
 */
-(void) loadDetailCustomerBussinessData {
    //code
    _lbBussinessCode.text=[NSString stringWithFormat:@"%@: %@",LocalizedString(@"KEY_LEAD_CODE"),[dicData objectForKey:DTOLEAD_clientLeadId]];
    //name
    _lbBussinessName.text=[dicData objectForKey:DTOLEAD_name];
    //tax code
    _lbBussinessTaxCode.text=[dicData objectForKey:DTOLEAD_taxCode];
    //phone
    _lbBussinessPhone.text=[dicData objectForKey:DTOLEAD_mobile];
    //email
    _lbBussinessEmail.text=[dicData objectForKey:DTOLEAD_email];
    //adđ
    _lbBussinessAddress.text=[dicData objectForKey:DTOLEAD_address];
    //ngày thành lập
    _lbBussinessNgayThanhLap.text=[dicData objectForKey:DTOLEAD_birthday];
    //so dang ky
    _lbBussinessDKKD.text=[dicData objectForKey:DTOLEAD_registrationNumber];
    //von dieu le
    _lbBussinessVonDieuLe.text=[dicData objectForKey:DTOLEAD_charter];
    //von chu so huu
    _lbBussinessVoChuSoHuu.text=[dicData objectForKey:DTOLEAD_equityOwner];
    //tong tai san
    _lbBussinessTongTaiSan.text=[dicData objectForKey:DTOLEAD_assetTotal];
    //doanh thu
    _lbBussinessDoanhThu.text=[dicData objectForKey:DTOLEAD_revenue];
    //loi nhuan
    _lbBussinessLoiNhuan.text=[dicData objectForKey:DTOLEAD_revenue];
    NSString *sms =@"";
    NSString *disableSms = [dicData objectForKey:DTOLEAD_disableSms];
    if([disableSms isEqualToString:@"0"])
    {
        sms=@"SMS";
    }
    NSString *phone=@"";
    NSString *disablePhone = [dicData objectForKey:DTOLEAD_disablePhone];
    if ([disablePhone isEqualToString:@"0"]) {
        phone=@"Phone";
    }
    NSString *email=@"";
    NSString *disableEmail= [dicData objectForKey:DTOLEAD_disableEmail];
    if([disableEmail isEqualToString:@"0"]){
        email=@"Email";
    }
    NSString *metting=@"";
    NSString *disableMetting = [dicData objectForKey:DTOLEAD_disableMeeting];
    if ([disableMetting isEqualToString:@"0"]) {
        metting=@"Metting";
    }
    NSString *tmp=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
    //goi nho
    if (tmp.length>3) {
        tmp=tmp;
    }
    else{
        tmp=@"";
    }
    _lbBussinessKhongLienLacQuaa.text=tmp;
}


-(void) loadDataWithTypeAction : (enum TypeLeaderView) inputTypeActionEvent{
    
    self.viewBodyExpandInfo.hidden = YES;
    self.tbData.hidden  = NO;
    
    typeActionEvent = inputTypeActionEvent;
    switch (typeActionEvent) {
        case typeLeaderView_ExpandInfo:{
            
        }
            break;
        case typeLeaderView_Contact:
        {
            arrayData = [dtoContactProcess filterWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"get detail data = %d", arrayData.count);
        }break;
        case typeLeaderView_Note:
        {
            //load data la ghi chu
            
            NSLog(@"DTOLEAD_ClientLeadID:%@", [dicData objectForKey:DTOLEAD_clientLeadId]);
            arrayData = [dtoNoteProcess filterWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"total: %i", arrayData.count);
            
        }break;
        case typeLeaderView_Opportunity:{
            arrayData = [dtoOpportunityProcess filterWithClienLeadId:[dicData objectForKey:DTOLEAD_clientLeadId]];
        }break;
        case typeLeaderView_Calendar:
        {
            arrayData = [dtoTaskProcess filterCalendarWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"calendar count = %ld", (unsigned long)arrayData.count);
        }
            break;
        case typeLeaderView_Task:
        {
            arrayData = [dtoTaskProcess filterTaskWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"task count = %ld", (unsigned long)arrayData.count);
        }
            break;
            
        case typeLeaderView_Complains:
        {
            self.viewBodyExpandInfo.hidden = NO;
            self.tbData.hidden  = YES;
            [viewComplain setHidden:NO];
            [viewComplain setDelegate:self];
            [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOLEAD_clientLeadId] description]];
            NSLog(@"complanins count = %ld", (unsigned long)arrayData.count);
        }
            break;
        default:
            break;
    }
    
    [self.tbData reloadData];
}


- (void) updateInterFaceWithOption : (int) option
{
    
    //set upper case
    self.lbLeftInfo.text = [self.lbLeftInfo.text uppercaseString];
    [self.viewHeaderLeft setBorderWithOption:smgSelect withBorderFlag:AUISelectiveBordersFlagBottom];
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    self.viewBodyMainInfo.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.viewBodyMainInfo.layer.borderWidth = BORDER_WITH;
    self.viewBodyMainInfo.layer.borderColor = [BORDER_COLOR CGColor];
    
    self.viewHeaderExpandInfo.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    [self.scrollViewPersonal setBackGroundNormalColorWithOption:smgSelect];
    [self.scrollViewBussiness setBackGroundNormalColorWithOption:smgSelect];
    
    
    
    [self.tbData setBorderWithOption:smgSelect];
    [self.viewBodyExpandInfo setBorderWithOption:smgSelect];
    
    
    // self.fullNameLB.text = TITLE_APP;
    
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    
    textColorButtonNormal = TEXT_BUTTON_COLOR_BLACK_1; //mau chu button binh thuong
    textColorButtonSelected = TEXT_BUTTON_COLOR1; //mau chu button select
    backgrondButtonSelected = BUTTON_ACTIVE_COLOR_1;
    backgroundButtonNormal = BUTTON_REPORT_MAIN_IN_ACTIVE_COLOR_1;
    
    for (UIView *viewTemp in self.viewBodyMainInfo.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    [self.viewHeaderExpandInfo setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
    
    //Thêm phần hiển thị chữ in hoa trong phần tab
    for (UIView *viewTemp in scrollViewHeaderExpandInfo.subviews) {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            
            
            [((UIButton*) viewTemp) setTitle:[((UIButton*) viewTemp).titleLabel.text  uppercaseString] forState:UIControlStateNormal];
            
        }
    }
    
    //cap nhat cho dong line phan chi tiet
}

#pragma mark set bottom
/*set bottom line*/
-(void) setBottomLineDetail: (UIScrollView*) scrollViewTemp {
    //NSArray *arrayLabelToSetBottomLine = [scrollViewTemp vi]
    
    for (UIView *viewSub in [scrollViewTemp subviews]) {
        if (viewSub.tag == TAG_CONTROL_LINE) {
            [self addBottomLineWithBottomControl:viewSub.frame withInControl:scrollViewTemp];
        }
    }
}

-(void) addBottomLineWithBottomControl : (CGRect) bottomViewFrame withInControl : (UIView*) containView {
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewFrame.origin.y + bottomViewFrame.size.height, containView.frame.size.width, BORDER_WITH)];
    viewLine.backgroundColor = BORDER_COLOR;
    [viewLine setBorderWithOption:smgSelect];
    [containView addSubview:viewLine];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    
    switch (index) {
        case SELECT_INDEX_ADD_CONTACT:
        {
            typeActionEvent = typeLeaderView_Contact;
            EditContactLeadViewController *viewController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_NOTE:
        {
            typeActionEvent = typeLeaderView_Note;
            NSLog(@"data send note %@", dicData);
            EditNoteLeadViewController *viewController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        case SELECT_INDEX_ADD_OPPORTUNITY:
        {
            EditOpportunityLeadViewController *viewController = [[EditOpportunityLeadViewController alloc]initWithNibName:@"EditOpportunityLeadViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            // calendar+task
        case SELECT_INDEX_ADD_CALENDAR:
        {
            typeActionEvent = typeLeaderView_Note;
            
            EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewController setDelegate:self];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_TASK:
        {
            EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            viewController.isKHDM = YES;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_COMPLAIN:
        {
            ComplainDetailViewController *viewController = [[ComplainDetailViewController alloc]initWithNibName:@"ComplainDetailViewController" bundle:nil];
            viewController.delegate= self;
            //            viewController.dataRoot = dicData;
            viewController.leadId = [[dicData objectForKey:DTOLEAD_clientLeadId] description];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
- (void)closeComplainDetailView:(ComplainDetailViewController*)complainDetailViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)updateComplainDetailViewWithComplainOB:(DTOComplainObject*)complainOB
{
    ComplainModel *complainModel = [[ComplainModel alloc] init];
    if ([complainModel updateComplainWithComplainOB:complainOB]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOLEAD_clientLeadId] description]];
    }
}

#pragma mark action button - normal
- (IBAction)homeBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionAdd:(id)sender{
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectIndex;
    
    detail.listData = listArr;
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = btnAdd.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, HEIGHT_SELECT_INDEX_ROW*listArr.count) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
#pragma mark action button - action tab


- (IBAction)actionExpandInfo:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Contact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionNote:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Note];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionCalendar:(UIButton *)sender {
    if (typeActionEvent == typeLeaderView_Calendar)
    {
        calendarIsTimeline = !calendarIsTimeline;
    }
    [self loadDataWithTypeAction:typeLeaderView_Calendar];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionTask:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Task];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionOpportunity:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Opportunity];
    [self displayNormalButtonState:sender];
}

- (IBAction)btnComplainsTaped:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Complains];
    [self displayNormalButtonState:sender];
}

- (IBAction)btnProductsTaped:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_ProductsLead];
    [self displayNormalButtonState:sender];
}


#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in scrollViewHeaderExpandInfo.subviews)
    {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            [((UIButton*) viewTemp) setBackgroundColor:[UIColor whiteColor]];
            [((UIButton*) viewTemp) setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
            [((UIButton*) viewTemp) setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
        }
    }
    [btnSelect setBackgroundColor:[UIColor whiteColor]];
    [btnSelect setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
    [btnSelect setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:5.0f withBorderFlag:AUISelectiveBordersFlagBottom];
}



#pragma mark - Table View Datasource


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(arrayData.count == 0) return tableView.frame.size.height;
    
    
    switch (typeActionEvent) {
        case typeLeaderView_Note:
            return 60.0f;
            break;
        case typeLeaderView_Calendar:
        {
            if (calendarIsTimeline)
            {
                return 225.0f;
            }
            else
            {
                return 66.0f;
            }
        }
            break;
        case typeLeaderView_Task:
            if([myDevice isEqualToString:@"iPhone"] || [myDevice isEqualToString:@"iPhone Simulator"]){
                return 50.0f;
            }else{
                return 60.0f;
            }
            break;
        case typeLeaderView_Contact:
            if([myDevice isEqualToString:@"iPhone"] || [myDevice isEqualToString:@"iPhone Simulator"]){
                return 50.0f;
            }
            break;
        default:
            break;
    }
    return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//thêm cái line đến tận left margin
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrayData.count == 0) {
        return  1;
    }else{
        return arrayData.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set empty cell
    if (arrayData.count == 0) {
        static NSString *cellId = @"EmptyCell";
        EmptyCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (!cell) {
            cell = [EmptyCell initNibCell];
        }
        
        [cell loadDataToCellWithData:@"" withOption:smgSelect];
        
        return cell;
    }
    
    
    
    switch (typeActionEvent) {
        case typeLeaderView_Contact:{
            static NSString *cellId = @"ContactLeadCell";
            ContactLeadCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ContactLeadCell initNibCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            cell.delegate=(id<ContactDelegate>)self;
            return cell;
        }
            break;
        case typeLeaderView_Note:
        {
            static NSString *cellId = @"NoteLeadCell";
            NoteLeadCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [NoteLeadCell initNibCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        case typeLeaderView_Opportunity:
        {
            static NSString *cellId = @"OpportunityLeadCell";
            OpportunityLeadCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [OpportunityLeadCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
            // calendar + task
        case typeLeaderView_Calendar:
        {
            if (calendarIsTimeline)
            {
                TaskCalTLineCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskCalendarTimelineCellId];
                
                if (indexPath.row < arrayData.count)
                {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                    if (indexPath.row == 0)
                    {
                        cell.tbv_position = TaskCalTLineCell_Top;
                    }
                    else if (indexPath.row == arrayData.count - 1)
                    {
                        cell.tbv_position = TaskCalTLineCell_Bottom;
                    }
                    else
                    {
                        cell.tbv_position = TaskCalTLineCell_Middle;
                    }
                }
                
                return cell;
            }
            else
            {
                TaskCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskCalendarNormalCellId];
                
                if (indexPath.row < arrayData.count)
                {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
        }
            break;
        case typeLeaderView_Task:
        {
            TaskActionCell *cell= [tableView dequeueReusableCellWithIdentifier:TaskActionCellId];
            
            if (cell !=nil)
            {
                cell.delegate = self;
                
                if (indexPath.row < arrayData.count)
                {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
        }
            break;
        default:
            break;
    }
    
    UITableViewCell *cellNull = [[UITableViewCell alloc] init];
    return cellNull;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
        
    }
    
    if (arrayData.count == 0) {
        
        switch (typeActionEvent) {
            case typeLeaderView_Task:{
                
                EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
                viewController.dataRoot = dicData;
                viewController.isKHDM = YES;
                [self presentViewController:viewController animated:YES completion:nil];
                
            }
                break;
            case typeLeaderView_Opportunity:
            {
                EditOpportunityLeadViewController *viewNoteController = [[EditOpportunityLeadViewController alloc]initWithNibName:@"EditOpportunityLeadViewController" bundle:nil];
                viewNoteController.dataRoot = dicData;
                [self presentViewController:viewNoteController animated:YES completion:nil];
            }
                break;
            case typeLeaderView_Note:{
                EditNoteLeadViewController *viewController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
                viewController.dataRoot = dicData;
                [self presentViewController:viewController animated:YES completion:nil];
            }
                break;
            case typeLeaderView_Contact:
            {
                EditContactLeadViewController *viewController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
                viewController.dataRoot = dicData;
                [self presentViewController:viewController animated:YES completion:nil];
                
            }
                break;
            case typeLeaderView_Calendar:{
                EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
                [viewController setDelegate:self];
                viewController.dataRoot = dicData;
                [self presentViewController:viewController animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
        
        return;
    }
    
    
    
    
    
    NSDictionary *dicTempData = [arrayData objectAtIndex:indexPath.row];
    switch (typeActionEvent) {
        case typeLeaderView_Task:{
            
            EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewNoteController.isKHDM = YES;
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Opportunity:
        {
            EditOpportunityLeadViewController *viewNoteController = [[EditOpportunityLeadViewController alloc]initWithNibName:@"EditOpportunityLeadViewController" bundle:nil];
            viewNoteController.dataRoot = dicTempData;
            //viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Note:{
            EditNoteLeadViewController *viewNoteController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Contact:
        {
            EditContactLeadViewController *viewNoteController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Calendar:{
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewCalendarController setDelegate:self];
            viewCalendarController.dataSend = dicTempData;
            [self presentViewController:viewCalendarController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - TaskActionCellDelegate
- (void)taskActionCell:(TaskActionCell *)taskActionCell changeStatusWithData:(NSMutableDictionary *)inputDicData
{
    //change status
    //dtoTaskProcess
    
    NSMutableDictionary *dicTaskUpdate = [[NSMutableDictionary alloc] init];
    
    [dicTaskUpdate setObject:[inputDicData objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    
    if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE)
    {
        [dicTaskUpdate setObject:IntToStr(FIX_TASK_STATUS_NOT_COMPLETE) forKey:DTOTASK_taskStatus];
    }
    else //if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE)
    {
        [dicTaskUpdate setObject:IntToStr(FIX_TASK_STATUS_COMPLETE) forKey:DTOTASK_taskStatus];
    }
    
    if ([dtoTaskProcess insertToDBWithEntity:dicTaskUpdate])
    {
        NSIndexPath *indexPathToReload = [self.tbData indexPathForCell:taskActionCell];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            arrayData = [dtoTaskProcess filterTaskWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"task count = %ld", (unsigned long)arrayData.count);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tbData reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToReload] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        });
    }
}

#pragma mark ComplainsView Delegate
- (void)selectedComplainOB:(DTOComplainObject*)complainOB{
    ComplainDetailViewController *complainDetailVC = [[ComplainDetailViewController alloc] init];
    complainDetailVC.delegate = self;
    complainDetailVC.leadId = [[dicData objectForKey:DTOLEAD_clientLeadId] description];
    [self presentViewController:complainDetailVC animated:YES completion:nil];
    [complainDetailVC loadDataWithComplainOB:complainOB];
}




//Thêm phần sửa, xoá hiển thị trên row của table

#pragma mark edit
/**
 *  Bat Swipe right de cho phep hien thi button xoa 1 row
 *  @return YES: If you want the specified item to be editable.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (arrayData.count == 0) {
        return NO;
    }
    NSString *deletePermission =@"1";
    if ([deletePermission isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

/**
 *  Delete 1 row tren TableView
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dicDataItem = [arrayData objectAtIndex:indexPath.row];
        
        switch (typeActionEvent) {
            case typeLeaderView_Task:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                delTask = [dicDataItem objectForKey:DTOTASK_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá công việc?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag =DELETE_TASK;
                [mylert show];
            }
                break;
            case typeLeaderView_Opportunity:{
                deleteNoteId = [dicData objectForKey:DTOOPPORTUNITY_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá cơ hội?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_COHOI;
                [mylert show];
            }
                break;
            case typeLeaderView_Note:{
                deleteNoteId =[dicDataItem objectForKey:DTONOTE_id];
                deleteFileClienWithClientNoteID=[dicDataItem objectForKey:DTONOTE_clientNoteId];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá ghi chú?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_NOTE;
                [mylert show];
            }
                break;
            case typeLeaderView_Contact:
            {
                deleteContact = [dicDataItem objectForKey:DTOCONTACT_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá liên hệ?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_CONTAC;
                [mylert show];
            }
                break;
            case typeLeaderView_Calendar:{
                // deleteCalenda = [dicData objectForKey:DToCa];
                delTask = [dicDataItem objectForKey:DTOTASK_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá lịch?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_CALENDAR;
                [mylert show];
            }
                break;
            default:
                break;
        }
        
    }
}

/**
 *  Xu ly khi click Button Accessory (tren ios6, xem trong cellForRow co code set AccessoryType cho cell neu khong phai la Header)
 *  TRUONG HOP NAY HIEN TAI KHONG DUNG DEN MA SU DUNG 1 CUSTOM BUTTON VOI ACTION "customButtonAccessoryTapped"
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SYS_KEY_DELETE;
}

/**
 *  Them 1 button "Sua" ben canh button "Xoa" (tren ios7, ios6 su dung accessoryType)
 */
-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  Neu khong phai la Header thi la item level 2
     */
    return SYS_KEY_EDIT;
    //return nil;
}

/**
 *  Xu ly khi chon button "Sua"
 */
-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"o day");
    NSDictionary *dicTempData = [arrayData objectAtIndex:indexPath.row];
    switch (typeActionEvent) {
        case typeLeaderView_Task:{
            EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            viewNoteController.isKHDM = YES;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Opportunity:{
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            viewCalendarController.dataSend = dicTempData;
            [viewCalendarController setDelegate:self];
            [self presentViewController:viewCalendarController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Note:{
            EditNoteLeadViewController *viewNoteController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Contact:
        {
            EditContactLeadViewController *viewNoteController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Calendar:{
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewCalendarController setDelegate:self];
            viewCalendarController.dataSend = dicTempData;
            [self presentViewController:viewCalendarController animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
    
    
}



#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}

#pragma mark Edit Calendar Lead ViewController Delegate
- (void)reloadListCalendarTask{
    [self loadDataWithTypeAction:typeLeaderView_Calendar];
    [_tbData reloadData];
}

#pragma -mark xử lý thông báo
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    BOOL item;
    
    if (alertView.tag==DELETE_NOTE) {
        if(buttonIndex==0){
            NSLog(@"chọn xoá ghi chú");
            NSLog(@"deleteItem:%@",deleteNoteId);
            item=[dtoNoteProcess deleteEntity:deleteNoteId];
            if(item){
                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:typeLeaderView_Note];
                // [self displayNormalButtonState:sender];
            }
            else{
                NSLog(@"Xoa that bai");
            }
        }
        else if(buttonIndex==1){
            
            NSLog(@"Khong  xoa file");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }else if(alertView.tag==DELETE_TASK){
        if(buttonIndex==0){
            NSLog(@"Delete task");
            item=[dtoTaskProcess deleteEntity:delTask];
            if(item){
                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:typeLeaderView_Task];
            }
            else{
                NSLog(@"Loi");
            }
        }
        else if(buttonIndex==1){
            NSLog(@"No del task");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }else if(alertView.tag==DELETE_LEAD){
        
        if(buttonIndex==0){
            NSLog(@"Xoa khach hang dau moi");
            BOOL result =    [dtoLeadProcess deleteEntity:[dicData objectForKey:DTOLEAD_id]];
            if(result){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        else{
            NSLog(@"Khong xoa khach hang dau moi");
        }
    }else if(alertView.tag==DELETE_CONTAC){
        if(buttonIndex==0){
            NSLog(@"Xoa lien he");
            item=[dtoContactProcess deleteEntity:deleteContact];
            if (item) {
                [self loadDataWithTypeAction:typeLeaderView_Contact];
            }
            else{
                NSLog(@"Loi");
            }
        }
        else{
            NSLog(@"Khong xoa lien he");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }else if(alertView.tag==DELETE_COHOI){
        if(buttonIndex==0){
            NSLog(@"xoa co hoi");
        }
        else{
            NSLog(@"Khong xoa co hoi");
        }
    }else if(alertView.tag==DELETE_CALENDAR){
        if(buttonIndex==0){
            item=[dtoTaskProcess deleteEntity:delTask];
            if(item){
                NSString* eventIden = [Validator getSafeString:[[NSUserDefaults standardUserDefaults]  valueForKey:delTask]];
                
                EKEventStore *eventStore = [[EKEventStore alloc] init];
                [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    if(granted)
                    {
                        EKEvent *event = [eventStore eventWithIdentifier:eventIden];
                        [eventStore removeEvent:event span:EKSpanFutureEvents error:&error];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:delTask];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }];
                
                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:typeLeaderView_Calendar];
            }
            else{
                NSLog(@"Loi");
            }
            NSLog(@"xoa lich");
        }
        else{
            NSLog(@"khong xoa lich");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }
    
}

- (IBAction)actionEdit:(id)sender {
    
    
    if([[self.dataSend objectForKey:DTOLEAD_leadType] isEqualToString:@"0"]){
        
        EditAccountLeadViewController *viewController = [[EditAccountLeadViewController alloc]initWithNibName:@"EditAccountLeadViewController" bundle:nil];
        viewController.dataSend=dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else{
        EditBussinessLeadViewController *viewController = [[EditBussinessLeadViewController alloc]initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
        viewController.dataSend=dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
}

- (IBAction)actionDel:(id)sender {
    deleteItem=[self.dataSend objectForKey:DTOLEAD_id];
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá khách hàng?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
    mylert.tag = DELETE_LEAD;
    [mylert show];
    
}
#pragma set height lable
-(void) setFrameLabelTitle : (UILabel*) labelTitle withLabelValue : (UILabel*) lableValue withFY : (float) fY {
    
    CGRect frame = labelTitle.frame;
    labelTitle.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
    frame =lableValue.frame;
    lableValue.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
}


-(float) setFrameLabelTitle : (UILabel*) labelTitle withLabelValue : (UILabel*) lableValue withFY : (float) fY : (NSString*) strValue {
    
    CGRect frame = labelTitle.frame;
    labelTitle.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
    frame =lableValue.frame;
    lableValue.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
    
    float heightLabelCN = 25.0f;
    
    if (![StringUtil stringIsEmpty:strValue]) {
        lableValue.text=strValue;
        heightLabelCN =  [self getHeightLabel:strValue];
        
        if (heightLabelCN>20) {
            [UILabel setMultiline:lableValue];}
    }
    else{
        lableValue.text=@"";
    }
    return  lableValue.frame.origin.y + lableValue.frame.size.height + 10;
}
-(CGFloat) getHeightLabel : (NSString*) strMessage{
    
    CGSize maximumSize =CGSizeMake(480, 9999);
    
    CGFloat heightLabel = 0;
    
    UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:16];
    CGSize myStringSize = [strMessage sizeWithFont:myFont
                                 constrainedToSize:maximumSize
                                     lineBreakMode:UILineBreakModeWordWrap];
    
    if( myStringSize.height>25){
        heightLabel = myStringSize.height;
    }
    else
        heightLabel =  25;
    
    
    return heightLabel;
}
- (IBAction)actionCallCN:(id)sender {
    if(![StringUtil stringIsEmpty:_lbPhone.text]){
        [self delegate_callContact:_lbPhone.text];}
}
- (IBAction)actionSMSCN:(id)sender {
    if(![StringUtil stringIsEmpty:_lbPhone.text]){
        [self delegate_sendSMSContact:_lbPhone.text];
    }
}
- (IBAction)actionEmailCN:(id)sender {
    if(![StringUtil stringIsEmpty:_lbEmail.text]){
        [self delegate_sendMailContact:_lbEmail.text];
    }
}
- (IBAction)actionAddCN:(id)sender {
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_lat]]) {
        float fLon = [[dicData objectForKey:DTOLEAD_lon] floatValue];
        float fLan =[[dicData objectForKey:DTOLEAD_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
            viewController.address = [dicData objectForKey:DTOLEAD_address];
        }else{
            viewController.address = @"";
        }
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
}
- (IBAction)actionCallDN:(id)sender {
}
- (IBAction)actionAddDN:(id)sender {
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_lat]]) {
        float fLon = [[dicData objectForKey:DTOLEAD_lon] floatValue];
        float fLan =[[dicData objectForKey:DTOLEAD_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
            viewController.address = [dicData objectForKey:DTOLEAD_address];
        }else{
            viewController.address = @"";
        }
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    
}

- (IBAction)actionSMSDN:(id)sender {
}
- (IBAction)actionEmailDN:(id)sender {
}
#pragma mark sendmail

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Saved");
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"Gửi email thành công!"];
            [alert setMessage:nil];
            [alert setDelegate:self];
            [alert addButtonWithTitle:@"Thoát"];
            
            [alert show];
            
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"Không gửi được email!"];
            [alert setMessage:nil];
            [alert setDelegate:self];
            [alert addButtonWithTitle:@"Thoát"];
            
            [alert show];
            
        }
            break;
            
            //NSLog(@"Not send");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void) delegate_sendMailContact:(NSString *)email{
    [Util sendMail:self withEmail:email];
}
- (void)delegate_callContact:(NSString *)mobile {
    if(![StringUtil stringIsEmpty:mobile]){
        NSString *callnumber=[NSString stringWithFormat:@"telprompt://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callnumber]];
    }
}

- (void)delegate_sendSMSContact:(NSString *)mobile {
    if(![StringUtil stringIsEmpty:mobile]){
        NSString *sendSMS=[NSString stringWithFormat:@"sms://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sendSMS]];
    }
}
-(void)setLanguage{
    
    [_btnExpandInfo setTitle:LocalizedString(@"KEY_360_CONTACT") forState:UIControlStateNormal];
    [_btnNote setTitle: LocalizedString(@"KEY_360_NOTE") forState:UIControlStateNormal];
    [_btnCalendar setTitle:LocalizedString(@"KEY_360_CALENDAR") forState:UIControlStateNormal];
    [_btnTask setTitle:LocalizedString(@"KEY_360_NHIEMVU") forState:UIControlStateNormal];
    [_btnOpportunity setTitle:LocalizedString(@"KEY_360_COHOI") forState:UIControlStateNormal];
    [_btnComplains setTitle:LocalizedString(@"KEY_360_YKIEN") forState:UIControlStateNormal];
    //[_btnProductService setTitle:LocalizedString(@"KEY_360_SPDV") forState:UIControlStateNormal];
    [_fullNameLB setText:LocalizedString(@"KEY_LEAD_TITLE")];
    _lbLeftInfo.text=LocalizedString(@"KEY_LEAD_INFO_BASSIC");
    if ([leadType isEqualToString:FIX_LEADTYPE_BUSSINESS]) {
        _lbLabelBussinessCode.text=LocalizedString(@"KEY_LEAD_CODE");
        _lbLabelBussinessName.text=LocalizedString(@"KEY_LEAD_NAME");
        _lbLabelBussinessTaxCode.text=LocalizedString(@"KEY_LEAD_SOTHUE");
        _lbLabelBussinessPhone.text=LocalizedString(@"KEY_LEAD_PHONE");
        _lbLabelBussinessAddress.text=LocalizedString(@"KEY_LEAD_ADDRESS");
        _lbLableBussinessNgayThanhLap.text=LocalizedString(@"KEY_LEAD_NGAY_TL");
        _lbLableBussinessDKKD.text=LocalizedString(@"KEY_LEAD_SO_DK");
        _lbLableBussinessVonDieuLe.text=LocalizedString(@"KEY_LEAD_VON_DL");
        _lbLabelBussinessVoChuSoHuu.text=LocalizedString(@"KEY_LEAD_VON_CHU_SH");
        _lbLableBussinessTongTaiSan.text=LocalizedString(@"KEY_LEAD_TONG_TS");
        _lbLabelBussinessDoanhThu.text=LocalizedString(@"KEY_LEAD_DOANH_THU");
        _lbLableBussniessLoiNhuan.text=LocalizedString(@"KEY_LEAD_LOI_NHUAN");
        _lbLableBussinessKhongLienLacQua.text=LocalizedString(@"KEY_LEAD_KLLQ");
    }
    else{
        _lbLabelCode.text=LocalizedString(@"KEY_LEAD_CODE");
        _lbLabelName.text=LocalizedString(@"KEY_LEAD_NAME");
        _lbLabelAlias.text=LocalizedString(@"KEY_LEAD_SO_CMT");
        _lbLabelSex.text=LocalizedString(@"KEY_LEAD_GT");
        _lbLabelBirthDay.text=LocalizedString(@"KEY_LEAD_BIRTH_DAY");
        _lbLabelMarialStatus.text=LocalizedString(@"KEY_LEAD_TINH_TRANG_HN");
        _lbLabelPhone.text=LocalizedString(@"KEY_LEAD_PHONE");
        _lbLabelAddress.text=LocalizedString(@"KEY_LEAD_ADDRESS");
        _lbLabelThuNhapCN.text=LocalizedString(@"KEY_LEAD_THU_NHAP_CN");
        _lbLableTongThuNhap.text=LocalizedString(@"KEY_LEAD_TONG_THU_NHAP");
        _lbLableKhongLienLacQua.text=LocalizedString(@"KEY_LEAD_KLLQ");
    }
    
}
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSUInteger indexOfTab = [[tabBar items] indexOfObject:item];
    NSLog(@"Tab index = %i", indexOfTab);
    NSLog(@"Tab bar: did select tab %@", item.title);
    //chi tiết khách hàng
    if(indexOfTab==0){
        _viewDetailIP.hidden=NO;
        if ([leadType isEqualToString:FIX_LEADTYPE_BUSSINESS]) {
            _viewData.hidden=YES;
            _scrollviewDN.hidden=NO;
            _scrollviewCN.hidden=YES;
            [_viewDetailIP addSubview:_scrollviewDN];
        }else{
            _scrollviewCN.hidden=NO;
            _scrollviewDN.hidden=YES;
            _viewData.hidden=YES;
            [_viewDetailIP addSubview:_scrollviewCN];
        }
        _fullNameLB.text=LocalizedString(@"KEY_LEAD_TITLE");
    }
    else if(indexOfTab==1){
        _scrollviewCN.hidden=YES;
        _scrollviewDN.hidden=YES;
        _viewDetailIP.hidden=YES;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_CONTACT");
        [self loadDataWithTypeAction:typeLeaderView_Contact];
    }
    else if(indexOfTab==2){
        _scrollviewCN.hidden=YES;
        _scrollviewDN.hidden=YES;
        _viewDetailIP.hidden=YES;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_NOTE");
        [self loadDataWithTypeAction:typeLeaderView_Note];
    }
    else if(indexOfTab==3){
        _scrollviewCN.hidden=YES;
        _scrollviewDN.hidden=YES;
        _viewDetailIP.hidden=YES;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_CALENDAR");
        if (typeActionEvent == typeLeaderView_Calendar)
        {
            calendarIsTimeline = !calendarIsTimeline;
        }
        [self loadDataWithTypeAction:typeLeaderView_Calendar];
    }
    else if(indexOfTab==4){
        _scrollviewCN.hidden=YES;
        _scrollviewDN.hidden=YES;
        _viewDetailIP.hidden=YES;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_YKIEN");
        [self loadDataWithTypeAction:typeLeaderView_Complains];
    }
    else if(indexOfTab==5){
        
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"Menu" delegate:self cancelButtonTitle:LocalizedString(@"KEY_CANCEL") destructiveButtonTitle:nil otherButtonTitles:LocalizedString(@"KEY_360_NHIEMVU"),LocalizedString(@"KEY_360_COHOI"),LocalizedString(@"KEY_360_SPDV"), nil];
        actionSheet.tag=11;
        [actionSheet showInView:self.view];
    }
}
- (IBAction)myactionAdd:(id)sender {
    
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Menu" delegate:self cancelButtonTitle:LocalizedString(@"KEY_CANCEL") destructiveButtonTitle:nil otherButtonTitles:LocalizedString(@"KEY_360_CONTACT"),LocalizedString(@"KEY_360_NOTE"), LocalizedString(@"KEY_360_CALENDAR")
                           , LocalizedString(@"KEY_360_NHIEMVU"), LocalizedString(@"KEY_360_COHOI"), LocalizedString(@"KEY_360_YKIEN"), nil];
    action.tag=22;
    [action showInView:self.view];
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==11){
        if(buttonIndex==0){
            
            _scrollViewBussiness.hidden=YES;
            _scrollViewPersonal.hidden=YES;
            _mySearchBar.hidden=NO;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_NHIEMVU");
            [self loadDataWithTypeAction:typeLeaderView_Task];
            
        }
        else if (buttonIndex ==1){
            _scrollViewBussiness.hidden=YES;
            _scrollViewPersonal.hidden=YES;
            _mySearchBar.hidden=NO;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_COHOI");
            [self loadDataWithTypeAction:typeLeaderView_Opportunity];
        }
        else if (buttonIndex == 2){
            _scrollViewBussiness.hidden=YES;
            _scrollViewPersonal.hidden=YES;
            _mySearchBar.hidden=NO;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_SPDV");
            [self loadDataWithTypeAction:typeLeaderView_ProductsLead];
        }
    }
    else if(actionSheet.tag==22){
        if(buttonIndex==0){
            EditContactLeadViewController *edit=[[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            edit.dataRoot=dicData;
            [self presentViewController:edit animated:YES completion:nil];
        }
        else if (buttonIndex==1){
            EditNoteLeadViewController *edit=[[EditNoteLeadViewController alloc] initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            [self presentViewController:edit animated:YES completion:nil];
        }
        else if (buttonIndex == 2){
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewCalendarController setDelegate:self];
            viewCalendarController.dataRoot = dicData;
            [self presentViewController:viewCalendarController animated:YES completion:nil];
        }
        else if(buttonIndex == 4){
            EditOpportunityLeadViewController *edit=[[EditOpportunityLeadViewController alloc] initWithNibName:@"EditOpportunityLeadViewController" bundle:nil];
            edit.dataSend = dicData;
            [self presentViewController:edit animated:YES completion:nil];
        }
        else if (buttonIndex == 3){
            EditTaskLeadViewController *edit=[[EditTaskLeadViewController alloc] initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            [self presentViewController:edit animated:YES completion:nil];
        }
        else if(buttonIndex == 5){
            
            ComplainDetailViewController *viewController = [[ComplainDetailViewController alloc]initWithNibName:@"ComplainDetailViewController" bundle:nil];
            viewController.delegate= self;
            //            viewController.dataRoot = dicData;
            viewController.leadId = [[dicData objectForKey:DTOLEAD_clientLeadId] description];
            [self presentViewController:viewController animated:YES completion:nil];
        }
    }
}
///search cac thong tin lien quan toi khach hang
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"%@",searchText);
    switch (typeActionEvent) {
        case typeLeaderView_ExpandInfo:{
            
        }
            break;
        case typeLeaderView_Contact:{
            NSLog(@"lien he");
            arrayData = [dtoContactProcess filterWithArrayCondition:searchText :[dicData objectForKey:DTOLEAD_clientLeadId]];
            [self.tbData reloadData];
            
        }break;
        case typeLeaderView_Note:{
            NSLog(@"ghi chu");
            arrayData = [dtoNoteProcess filterContainWithClientLeaderId:searchText : [dicData objectForKey:DTOLEAD_clientLeadId]];
            [self.tbData reloadData];
        }break;
        case typeLeaderView_Opportunity:{
            NSLog(@"San pham");
        }break;
        case typeLeaderView_Calendar:{
        }break;
        case typeLeaderView_Task:{
        }break;
        case typeLeaderView_Complains:{
        }break;
        case typeLeaderView_ProductsLead:{
        }break;
        default:
            break;
    }
}
@end
