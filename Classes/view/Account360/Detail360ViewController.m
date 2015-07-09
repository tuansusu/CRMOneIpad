//
//  Detail360ViewController.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import "Detail360ViewController.h"

#import "DTOACCOUNTProcess.h"
#import "DTOCONTACTProcess.h"
#import "DTOTASKProcess.h"
#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"
#import "DTOOPPORTUNITYProcess.h"
#import "ProductsLeadView.h"
#import "ComplainsView.h"
#import "ComplainDetailViewController.h"
#import "ComplainModel.h"
#import "Globals.h"
#import "EditCalendarLeadViewController.h"
#import "EditTask360ViewController.h"

#import "TaskCalendarCell.h"
#import "TaskCalTLineCell.h"
#import "TaskActionCell.h"
#import "MJDetailViewController.h"
#import "TestMapViewController.h"
#import "EnumClass.h"

////remove
#import "StringUtil.h"

#define TITLE_APP @"KHÁCH HÀNG 360"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_NOTE 1
#define SELECT_INDEX_ADD_CALENDAR 2
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_OPPORTUNITY 4

#define WIDTH_HEADER_EXPAND_INFO 950

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_NOTE @"GHI CHÚ"
#define SELECT_TEXT_ADD_CALENDAR @"LỊCH"
#define SELECT_TEXT_ADD_TASK @"NHIỆM VỤ"
#define SELECT_TEXT_ADD_OPPORTUNITY @"CƠ HỘI"


#define DELETE_CONTAC 11
#define DELETE_NOTE 22
#define DELETE_CALENDAR 33
#define DELETE_TASK 44
#define DELETE_COHOI 55
#define DELETE_LEAD 66

#define TAG_ACTIONSHEET_MOREINFO 123
#define TAG_ACTIONSHEET_ADD 22

#define TAG_ACTIONSHEET_MOREINFO_INDEX_TASK 0
#define TAG_ACTIONSHEET_MOREINFO_INDEX_OPPORTUNITY 1
#define TAG_ACTIONSHEET_MOREINFO_INDEX_PRODUCT 2
#define TAG_ACTIONSHEET_MOREINFO_INDEX_CANCEL 3




static NSString* const TaskCalendarNormalCellId   = @"TaskCalendarCellId";
static NSString* const TaskCalendarTimelineCellId = @"TaskCalTLineCellId";
static NSString* const TaskActionCellId           = @"TaskActionCellId";

@interface Detail360ViewController ()<ComplainsViewDelegate,ProductsLeadViewDelegate,EditCalendarLeadViewControllerDelegate>
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOCONTACTProcess *dtoContactProcess; //lay danh sach du lieu theo clientLeadId
    DTOTASKProcess *dtoTaskProcess;
    DTONOTEProcess *dtoNoteProcess;
    DTOATTACHMENTProcess *dtoAttachProcess;
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    NSUserDefaults *defaults ;
    NSString *type;
    
    UIColor *textColorButtonNormal; //mau chu button binh thuong
    UIColor *textColorButtonSelected; //mau chu button select
    UIColor *backgrondButtonSelected; //mau nen button select
    UIColor *backgroundButtonNormal; //Mau nen button binh thuong
    
    DTOACCOUNTProcess *dtoAccoutProcess;
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
    Language *obj;
    NSString*myDevice;
    //controll
    
    __weak IBOutlet UIButton *btnAdd;
    IBOutlet  ProductsLeadView* viewProductsLead;
    IBOutlet  ComplainsView* viewComplain;
    
    ProTindungDetailViewController *proTindungDetailVC;
    ProTaiKhoanThanhToanDetailViewController *proTaiKhoanThanhToanDetailVC;
    ProTaiKhoanTietKiemDetailViewController *proTaiKhoanTietKiemDetailVC;
    ProBaoLanhDetailViewController *proBaoLanhDetailVC;
    ProThanhToanQuocTeDetailViewController *proThanhToanQuocTeDetailVC;
    ProTheDetailViewController *proTheDetailVC;
    ProEMBDetailViewController *proEMBDetailVC;
    ProBankPlusDetailViewController *proBankPlusDetailVC;
    
    //calendar
    BOOL calendarIsTimeline;
}
@end

@implementation Detail360ViewController
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
    myDevice=[UIDevice currentDevice].model;
    // calendar
    calendarIsTimeline = YES;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj=[Language getInstance];
    obj.str=[defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    
    [self initData];
    [self actionExpandInfo:self.btnExpandInfo];
    [self.scrollViewHeaderExpandInfo setContentSize:CGSizeMake(WIDTH_HEADER_EXPAND_INFO, self.scrollViewHeaderExpandInfo.frame.size.height)];
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self updateInterFaceWithOption:smgSelect];
    [self.scrollviewCN setContentSize:CGSizeMake(320, _scrollviewCN.frame.size.height + 300)];
    [self.scrollviewDN setContentSize:CGSizeMake(320, _scrollviewDN.frame.size.height + 300)];
    
    
    
    if([self currentDeviceType]==iPhone)
    {
        [[_myTabbar.items objectAtIndex:0] setTitle:LocalizedString(@"KEY_DETAIL")];
        [[_myTabbar.items objectAtIndex:1] setTitle:LocalizedString(@"KEY_360_CONTACT")];
        [[_myTabbar.items objectAtIndex:2] setTitle:LocalizedString(@"KEY_360_NOTE")];
        [[_myTabbar.items objectAtIndex:3] setTitle:LocalizedString(@"KEY_360_CALENDAR")];
        [[_myTabbar.items objectAtIndex:4] setTitle:LocalizedString(@"KEY_360_YKIEN")];
        [_myTabbar setSelectedItem:0];
        //self.mySearch.barTintColor = HEADER_VIEW_COLOR1;
        self.myTabbar.barTintColor=[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        [self.myTabbar setSelectedItem:self.myTabbar.items[0]];
        [self.scrollviewCN setContentSize:CGSizeMake(320, _scrollviewCN.frame.size.height + 500)];
        [self.scrollviewDN setContentSize:CGSizeMake(320, _scrollviewDN.frame.size.height + 500)];
        
    }
}

-(void) viewWillAppear:(BOOL)animated{
    //cu quay lai la no load
    [self loadDataWithTypeAction:typeActionEvent];
    [self setButtonSelect];
    //cu quay lai la no load
}

//set lai trang thai cho
-(void) setButtonSelect {
    switch (typeActionEvent) {
        case type360View_Contact:{
            [self displayNormalButtonState:self.btnExpandInfo];
        }
            break;
        case type360View_Note:
        {
            [self displayNormalButtonState:self.btnNote];
        }break;
        case type360View_Calendar:
        {
            
            [self displayNormalButtonState:self.btnCalendar];
        }break;
        case type360View_Task:{
            [self displayNormalButtonState:self.btnTask];
        }break;
        case type360View_Opportunity:
        {
            [self displayNormalButtonState:self.btnOpportunity];
        }
            break;
        case type360View_Complains:
        {
            [self displayNormalButtonState:self.btnComplains];
        }
            break;
            
        case type360View_ProductsLead:
        {
            [self displayNormalButtonState:self.btnProductService];
        }
            break;
        default:
            break;
    }
}



//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    // _fullNameLB.text=@"KHÁCH HÀNG 360 100";
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:LocalizedString(@"KEY_360_CONTACT"),LocalizedString(@"KEY_360_NOTE"), LocalizedString(@"KEY_360_CALENDAR")
                , LocalizedString(@"KEY_360_NHIEMVU"), LocalizedString(@"KEY_360_COHOI"), nil];
    dtoAccoutProcess = [DTOACCOUNTProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    dtoTaskProcess= [DTOTASKProcess new];
    dtoNoteProcess = [DTONOTEProcess new];
    dtoAttachProcess=[DTOATTACHMENTProcess new];
    dtoOpportunityProcess =[DTOOPPORTUNITYProcess new];
    NSLog(@"datasend detail lead = %@", self.dataSend);
    dicData = [dtoAccoutProcess getDataWithKey:DTOACCOUNT_id withValue:[_dataSend objectForKey:DTOACCOUNT_id]];
    //dicData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[self.dataSend objectForKey:DTOLEAD_id]];
    NSLog(@"Get detail = %@", dicData);
    type=[dicData objectForKey:DTOACCOUNT_accountType];
    if ([dicData isKindOfClass:[NSNull class]] || dicData==nil ) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    [self actionExpandInfo:self.btnExpandInfo];
    arrayData  = [NSArray new];
    [self loadDetailCustomerPersonalData];
    [self setLanguage];
    
}


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
    if([myDevice isEqualToString:@"iPhone"] || [myDevice isEqualToString:@"iPhone Simulator"]){
        heightLabelCN=21.0f;
    }
    
    if (![StringUtil stringIsEmpty:strValue]) {
        lableValue.text=strValue;
        heightLabelCN =  [self getHeightLabel:strValue];
        
        if (heightLabelCN>25 || heightLabelCN>21) {
            [UILabel setMultiline:lableValue];}
    }
    else{
        lableValue.text=@"";
    }    return  lableValue.frame.origin.y + lableValue.frame.size.height + 10;
}


/*
 *Load danh sach khach hang ca nhan
 */
-(void) loadDetailCustomerPersonalData {
    
    
    
    float fyCN=_lbCode.frame.origin.y;
    NSLog(@"type:%@",type);
    if([type isEqualToString:@"INDIV"]){
        NSLog(@"Khach hang ca nhan");
        if ([self currentDeviceType]==iPhone) {
            [_viewDetailIP addSubview:_scrollviewCN];
        }
        else{
            [self.viewleft addSubview:self.scrollviewCN];
        }
        //code
        _lbCode.text=[NSString stringWithFormat:@"%@: %@",LocalizedString(@"KEY_360_CODE"),[dicData objectForKey:DTOACCOUNT_code]];
        //name
        _lbName.text=[dicData objectForKey:DTOACCOUNT_name];
        //gioi tinh
        if([[dicData objectForKey:DTOACCOUNT_sex] isEqualToString:@"1"] || [[dicData objectForKey:DTOACCOUNT_sex] isEqualToString:@"Nam"]){
            _lbSex.text=@"Nam";
        }
        else{
            _lbSex.text=@"Nữ";
        }
        //dien thoai
        _lbMobile.text=[dicData objectForKey:DTOACCOUNT_mobile];
        //email
        _lbEmail.text=[dicData objectForKey:DTOACCOUNT_email];
        //dia chi
        _lbDiaChi.text=[dicData objectForKey:DTOACCOUNT_address];
        //sector
        _lbSector.text=[dicData objectForKey:DTOACCOUNT_sector];
        //nghe nghiep
        _lbJob.text=[dicData objectForKey:DTOACCOUNT_personalIndustry];
        //chi nhanh quan ly
        _lbCompany.text =[dicData objectForKey:DTOACCOUNT_branchCode];
        //ngay mo code
        _ldDateOpenCode.text =[dicData objectForKey:DTOACCOUNT_openCodeDate];
        //tinh thanh
        _lbQuocGia.text=@"";
        _lbQuanHuyen.text=@"";
        _lbThanhPho.text=@"";
        _lbPhuonXa.text=@"";
        //kllq
        NSString *sms =@"";
        NSString *disableSms = [dicData objectForKey:DTOACCOUNT_disableSms];
        if([disableSms isEqualToString:@"0"])
        {
            sms=@"SMS";
        }
        NSString *phone=@"";
        NSString *disablePhone = [dicData objectForKey:DTOACCOUNT_disablePhone];
        if ([disablePhone isEqualToString:@"0"]) {
            phone=@"Phone";
        }
        NSString *email=@"";
        NSString *disableEmail= [dicData objectForKey:DTOACCOUNT_disableEmail];
        if([disableEmail isEqualToString:@"0"]){
            email=@"Email";
        }
        NSString *metting=@"";
        NSString *disableMetting = [dicData objectForKey:DTOACCOUNT_disableMeeting];
        if ([disableMetting isEqualToString:@"0"]) {
            metting=@"Metting";
        }
        NSString *tmp=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
        if(tmp.length <= 3)
        {
            tmp=@"";
        }
        _lbKhongLienLacQua.text=tmp;
    }
    else{
        if ([self currentDeviceType]==iPhone) {
            [_viewDetailIP addSubview:_scrollviewDN];
        }
        else{
            [self.viewleft addSubview:self.scrollviewDN];
        }
        //        //code
        _lbcodeDN.text=[NSString stringWithFormat:@"%@: %@",LocalizedString(@"KEY_360_CODE"), [dicData objectForKey:DTOACCOUNT_clientAccountId]];
        //ten khach hang
        _lbnameDN.text=[dicData objectForKey:DTOACCOUNT_name];
        //        //loai khach hang
        _lbloaiDN.text =[dicData objectForKey:DTOACCOUNT_accountType];
        //        //so dkkd
        _lbsoDKKD.text =[dicData objectForKey:DTOACCOUNT_registrationNumber];
        //        //so dkkd
        _lbngaycapDKKD.text=[dicData objectForKey:DTOACCOUNT_registrationDate];
        //        //so dt
        _lbdienthoaiDN.text=[dicData objectForKey:DTOACCOUNT_mobile];
        //
        //        //faxx
        _lbfaxDN.text=[dicData objectForKey:DTOACCOUNT_fax];
        //        //dia chi
        
        _lbdiachiDN.text=[dicData objectForKey:DTOACCOUNT_address];
        //        //goi nho
        _lbsectorDN.text=[dicData objectForKey:DTOACCOUNT_sector];
        //
        //        //goi nho
        _lbloaihinhDN.text=[dicData objectForKey:DTOACCOUNT_orgType];
        //
        //
        //        //goi nho
        _lbchinhanhquanlyDN.text=[dicData objectForKey:DTOACCOUNT_ownerEmployeeId];
        //
        //        //goi nho
        _lbngaymocodeDN.text=[dicData objectForKey:DTOACCOUNT_openCodeDate];
        //
        //
        //        //
        _lbquocgiaDN.text=@"";
        //
        _lbtinhthanhphoDN.text=@"";
        //
        //
        _lbquanhuyenDN.text=@"";
        //
        //
        _lbphuongxaDN.text=@"";
        //
        NSString *sms =@"";
        NSString *disableSms = [dicData objectForKey:DTOACCOUNT_disableSms];
        if([disableSms isEqualToString:@"0"])
        {
            sms=@"SMS";
        }
        NSString *phone=@"";
        NSString *disablePhone = [dicData objectForKey:DTOACCOUNT_disablePhone];
        if ([disablePhone isEqualToString:@"0"]) {
            phone=@"Phone";
        }
        NSString *email=@"";
        NSString *disableEmail= [dicData objectForKey:DTOACCOUNT_disableEmail];
        if([disableEmail isEqualToString:@"0"]){
            email=@"Email";
        }
        NSString *metting=@"";
        NSString *disableMetting = [dicData objectForKey:DTOACCOUNT_disableMeeting];
        if ([disableMetting isEqualToString:@"0"]) {
            metting=@"Metting";
        }
        NSString *tmp=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
        //goi nho
        if (tmp.length<=3) {
            tmp=@"";
        }
        _lbkhonglienlacDN.text=tmp;
    }
    
}


/*
 *Load danh sach khach hang doanh nghiep
 */
-(void) loadDetailCustomerBussinessData {
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        _lbBussinessName.text =[dicData objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
        _lbBussinessAddress.text =[dicData objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_mobile]]) {
        _lbBussinessPhone.text =[dicData objectForKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_email]]) {
        _lbBussinessEmail.text =[dicData objectForKey:DTOLEAD_email];
    }
    
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_taxCode]]) {
        _lbBussinessTaxCode.text =[dicData objectForKey:DTOLEAD_taxCode];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_code]]) {
        _lbBussinessCode.text =[dicData objectForKey:DTOLEAD_code];
    }
    
    
}


-(void) loadDataWithTypeAction : (enum Type360View) inputTypeActionEvent{
    
    self.viewBodyExpandInfo.hidden = YES;
    self.tbData.hidden  = NO;
    
    typeActionEvent = inputTypeActionEvent;
    switch (typeActionEvent) {
        case type360View_ExpandInfo:{
            
        }
            break;
        case type360View_Calendar:
        {
            arrayData = [dtoTaskProcess filterCalendarWithAccountId:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            
        }
            break;
        case type360View_Contact:
        {
            arrayData = [dtoContactProcess filterWithClientLeaderId:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            //  NSLog(@"get detail data = %d", );
        }break;
        case type360View_Note:
        {
            arrayData = [dtoNoteProcess filterWithClient360Id:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            
        }break;
        case type360View_Opportunity:{
            arrayData = [dtoOpportunityProcess filterWith360Id:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
        }break;
        case type360View_Task:{
            arrayData = [dtoTaskProcess filterTaskWithAccountId:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            
        }break;
            
        case type360View_Complains:
        {
            //            self.viewBodyExpandInfo.hidden = NO;
            //            self.tbData.hidden  = YES;
            //            [viewProductsLead setHidden:YES];
            //            [viewComplain setHidden:NO];
            //            [viewComplain setDelegate:self];
            //            [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOACCOUNT_clientAccountId] description]];
            if ([self currentDeviceType]==iPhone) {
                self.viewData.hidden = YES;
            }else{
                self.viewBodyExpandInfo.hidden = NO;
                self.tbData.hidden  = YES;
            }
            [viewComplain setHidden:NO];
            [viewComplain setDelegate:self];
            [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOLEAD_clientLeadId] description]];
            NSLog(@"complanins count = %ld", (unsigned long)arrayData.count);
        }
            break;
        case type360View_ProductsLead:
        {
            self.viewBodyExpandInfo.hidden = NO;
            self.tbData.hidden  = YES;
            [viewComplain setHidden:YES];
            [viewProductsLead setHidden:NO];
            [viewProductsLead setDelegate:self];
            [viewProductsLead initDataWithLeaderId:[[dicData objectForKey:DTOACCOUNT_clientAccountId] description]];
        }
            
            
        default:
            break;
    }
    
    [self.tbData reloadData];
}


- (void) updateInterFaceWithOption : (int) option
{
    
    
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    self.viewBodyMainInfo.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.viewBodyMainInfo.layer.borderWidth = BORDER_WITH;
    self.viewBodyMainInfo.layer.borderColor = [BORDER_COLOR CGColor];
    
    
    [self.scrollViewBodyLeft setBackGroundNormalColorWithOption:smgSelect];
    [self.scollviewDN setBackGroundNormalColorWithOption:smgSelect];
    
    self.viewHeaderExpandInfo.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    [self.tbData setBorderWithOption:smgSelect];
    [self.viewBodyExpandInfo setBorderWithOption:smgSelect];
    
    self.fullNameLB.text = TITLE_APP;
    
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
    
    
    for (UIView *viewTemp in [self.scrollViewHeaderRight subviews]) {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            [((UIButton*)viewTemp) setTitle:[((UIButton*)viewTemp).titleLabel.text uppercaseString] forState:UIControlStateNormal];
        }
    }
    
    [self.viewHeaderExpandInfo setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
    
    
    
    for (UIView *viewTemp in self.scrollViewBodyLeft.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            continue;
        }
        
        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            [((UIImageView*) viewTemp) setAlpha:1.0f];
            continue;
        }
        
    }
    for (UIView *viewTemp in self.scollviewDN.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            continue;
        }
        
        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            [((UIImageView*) viewTemp) setAlpha:1.0f];
            continue;
        }
        
    }
    
    
    /////
    [self setBottomLineDetail:self.scrollViewBodyLeft];
    [self setBottomLineDetail:self.scollviewDN];
    
    
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
        case SELECT_INDEX_ADD_CALENDAR:
        {
            EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewController setDelegate:self];
            viewController.dataRoot = dicData;
            viewController.isKH360 = YES;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_CONTACT:
        {
            EditContact360ViewController *viewController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_NOTE:
        {
            NSLog(@"data send note %@", dicData);
            EditNote360ViewController *viewController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        case SELECT_INDEX_ADD_OPPORTUNITY:
        {
            EditOpportunity360ViewController *viewController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
            
        }
            break;
            
        case SELECT_INDEX_ADD_TASK:
        {
            EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark action button - normal
- (IBAction)homeBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionAdd:(id)sender{
    if([self currentDeviceType]==iPhone){
        
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Menu" delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:nil otherButtonTitles:LocalizedString(@"KEY_360_CONTACT"),LocalizedString(@"KEY_360_NOTE"), LocalizedString(@"KEY_360_CALENDAR")
                               , LocalizedString(@"KEY_360_NHIEMVU"), LocalizedString(@"KEY_360_COHOI"),nil];
        action.tag=TAG_ACTIONSHEET_ADD;
        [action showInView:self.view];
    }
    else{
        SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
        
        detail.selectIndex = selectIndex;
        
        detail.listData = listArr;
        
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = _btnAdd.frame;
        
        detail.delegate =(id<SelectIndexDelegate>) self;
        self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320, HEIGHT_SELECT_INDEX_ROW*listArr.count) animated:NO];
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}
#pragma mark action button - action tab


- (IBAction)actionExpandInfo:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Contact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionNote:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Note];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionCalendar:(UIButton *)sender {
    if (typeActionEvent == type360View_Calendar)
    {
        calendarIsTimeline = !calendarIsTimeline;
    }
    [self loadDataWithTypeAction:type360View_Calendar];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionTask:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Task];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionOpportunity:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Opportunity];
    [self displayNormalButtonState:sender];
}

- (IBAction)btnComplainsTaped:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Complains];
    [self displayNormalButtonState:sender];
}

- (IBAction)btnProductsTaped:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_ProductsLead];
    [self displayNormalButtonState:sender];
}

#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in self.scrollViewHeaderExpandInfo.subviews) {
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
#pragma mark Edit Calendar Lead ViewController Delegate
- (void)reloadListCalendarTask{
    [self loadDataWithTypeAction:type360View_Calendar];
    [_tbData reloadData];
}

#pragma mark Products Lead View Delegate

- (void)selectedProductDetailWithProductDetailObject:(DTOProductDetailObject*)productDetailObject{
    int typeProduct = [productDetailObject.type intValue];
    if (typeProduct==PRODUCT_TYPE_TIN_DUNG)
    {
        proTindungDetailVC = [[ProTindungDetailViewController alloc] init];
        proTindungDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proTindungDetailVC animated:YES completion:nil];
    }
    else if (typeProduct==PRODUCT_TYPE_THANH_TOAN)
    {
        proTaiKhoanThanhToanDetailVC = [[ProTaiKhoanThanhToanDetailViewController alloc] init];
        proTaiKhoanThanhToanDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proTaiKhoanThanhToanDetailVC animated:YES completion:nil];
    }
    else if (typeProduct==PRODUCT_TYPE_TIET_KIEM)
    {
        proTaiKhoanTietKiemDetailVC = [[ProTaiKhoanTietKiemDetailViewController alloc] init];
        proTaiKhoanTietKiemDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proTaiKhoanTietKiemDetailVC animated:YES completion:nil];
    }
    else if (typeProduct==PRODUCT_TYPE_BAO_LANH)
    {
        proBaoLanhDetailVC = [[ProBaoLanhDetailViewController alloc] init];
        proBaoLanhDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proBaoLanhDetailVC animated:YES completion:nil];
    }
    else if (typeProduct==PRODUCT_TYPE_THANH_TOAN_QUOC_TE)
    {
        proThanhToanQuocTeDetailVC = [[ProThanhToanQuocTeDetailViewController alloc] init];
        proThanhToanQuocTeDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proThanhToanQuocTeDetailVC animated:YES completion:nil];
        
    }
    else if (typeProduct==PRODUCT_TYPE_THE)
    {
        proTheDetailVC = [[ProTheDetailViewController alloc] init];
        proTheDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proTheDetailVC animated:YES completion:nil];
    }
    else if (typeProduct==PRODUCT_TYPE_NGAN_HANG_DIEN_TU)
    {
        proEMBDetailVC = [[ProEMBDetailViewController alloc] init];
        proEMBDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proEMBDetailVC animated:YES completion:nil];
        
    }
    else if (typeProduct==PRODUCT_TYPE_BANK_PLUS)
    {
        proBankPlusDetailVC = [[ProBankPlusDetailViewController alloc] init];
        proBankPlusDetailVC.dtoProductDetailObject = productDetailObject;
        [self presentViewController:proBankPlusDetailVC animated:YES completion:nil];
    }
}

#pragma mark - Table View


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(arrayData.count == 0) return tableView.frame.size.height;
    
    switch (typeActionEvent) {
        case type360View_Calendar:
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
        case type360View_Task:
            return 60.0f;
            break;
        case type360View_Note:
            if ([self currentDeviceType]==iPhone) {
                return  50.0f;
            }
            else{
                return 60.0f;
            }
            break;
        case type360View_Contact:
            if ([self currentDeviceType]==iPhone) {
                return 50.0f;
            }
            else{
                return  100.0f;
            }
            break;
        case type360View_ProductsLead:
            if ([self currentDeviceType]==iPhone) {
                return  40.0f;
            }
            else{
                return  100.0f;
            }
        default:
            break;
    }
    return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([arrayData isKindOfClass:[NSNull class]] || arrayData.count==0) {
        return 1;
    }
    
    return  arrayData.count;
    
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
    
    
    
    if (self.tbData) {
        switch (typeActionEvent) {
            case type360View_Calendar:
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
            case type360View_Contact:{
                static NSString *cellId = @"Contact360Cell";
                Contact360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Contact360Cell initNibCell];
                }
                
                if (arrayData.count>0) {
                    cell.delegate=(id<ContactDelegate>)self;
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
                break;
            case type360View_Note:
            {
                static NSString *cellId = @"Note360Cell";
                Note360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Note360Cell initNibCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
                break;
            case type360View_Opportunity:
            {
                static NSString *cellId = @"Opportunity360Cell";
                Opportunity360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Opportunity360Cell getNewCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
                
            }
                break;
                
            case type360View_Task:
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
            case type360View_Task:{
                
                EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
                viewNoteController.dataRoot = dicData;
                [self presentViewController:viewNoteController animated:YES completion:nil];
                
            }
                break;
            case type360View_Opportunity:
            {
                EditOpportunity360ViewController *viewNoteController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
                viewNoteController.dataRoot = dicData;
                [self presentViewController:viewNoteController animated:YES completion:nil];
            }
                break;
            case type360View_Note:{
                EditNote360ViewController *viewNoteController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
                viewNoteController.dataRoot = dicData;
                [self presentViewController:viewNoteController animated:YES completion:nil];
            }
                break;
            case type360View_Contact:
            {
                EditContact360ViewController *viewNoteController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
                viewNoteController.dataRoot = dicData;
                [self presentViewController:viewNoteController animated:YES completion:nil];
                
            }
                break;
            case type360View_Calendar:{
                
                EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
                [viewController setDelegate:self];
                viewController.dataRoot = dicData;
                viewController.isKH360 = YES;
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
        case type360View_Task:{
            
            EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Opportunity:
        {
            EditOpportunity360ViewController *viewNoteController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
            viewNoteController.dataRoot = dicTempData;
            viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Note:{
            EditNote360ViewController *viewNoteController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Contact:
        {
            EditContact360ViewController *viewNoteController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            viewNoteController.dataRoot = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Calendar:{
            EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewController setDelegate:self];
            viewController.dataSend = dicTempData;
            viewController.dataRoot = dicData;
            viewController.isKH360 = YES;
            [self presentViewController:viewController animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark taskaction Cell
- (void) AccountLeadCellDelegate_ActionChangeTaskStatusWithData : (NSMutableDictionary*) inputDicData {
    //change status
    //dtoTaskProcess
    
    NSMutableDictionary *dicTaskUpdate = [[NSMutableDictionary alloc] init];
    
    [dicTaskUpdate setObject:[inputDicData objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    
    if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE) {
        [dicTaskUpdate setObject:ObjectToStr(FIX_TASK_STATUS_NOT_COMPLETE) forKey:DTOTASK_taskStatus];
        
    }else if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE){
        [dicTaskUpdate setObject:ObjectToStr(FIX_TASK_STATUS_COMPLETE) forKey:DTOTASK_taskStatus];
    }else{
        //qua han
        //chua mau do
        
    }
    [dtoTaskProcess insertToDBWithEntity:dicTaskUpdate];
    [inputDicData setObject:[dicTaskUpdate objectForKey:DTOTASK_taskStatus] forKey:DTOTASK_taskStatus];
    
    [self.tbData reloadData];
    
    
    
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
            case type360View_Task:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                delTask = [dicDataItem objectForKey:DTOTASK_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá công việc?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag =DELETE_TASK;
                [mylert show];
            }
                break;
            case type360View_Opportunity:{
                deleteNoteId = [dicData objectForKey:DTOOPPORTUNITY_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá cơ hội?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_COHOI;
                [mylert show];
            }
                break;
            case type360View_Note:{
                deleteNoteId =[dicDataItem objectForKey:DTONOTE_id];
                deleteFileClienWithClientNoteID=[dicDataItem objectForKey:DTONOTE_clientNoteId];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá ghi chú?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_NOTE;
                [mylert show];
            }
                break;
            case type360View_Contact:
            {
                deleteContact = [dicDataItem objectForKey:DTOCONTACT_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá liên hệ?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_CONTAC;
                [mylert show];
            }
                break;
            case type360View_Calendar:{
                // deleteCalenda = [dicData objectForKey:DToCa];
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
        case type360View_Task:{
            EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Opportunity:{
            
            EditOpportunity360ViewController *viewNoteController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
            viewNoteController.dataRoot = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Note:{
            EditNote360ViewController *viewNoteController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Contact:
        {
            EditContact360ViewController *viewNoteController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Calendar:{
            EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewController setDelegate:self];
            viewController.dataSend = dicTempData;
            viewController.isKH360 = YES;
            [self presentViewController:viewController animated:YES completion:nil];
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
                [self loadDataWithTypeAction:type360View_Note];
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
                [self loadDataWithTypeAction:type360View_Task];
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
        }
        else{
            NSLog(@"Khong xoa khach hang dau moi");
        }
    }else if(alertView.tag==DELETE_CONTAC){
        if(buttonIndex==0){
            NSLog(@"Xoa lien he");
            item=[dtoContactProcess deleteEntity:deleteContact];
            if (item) {
                [self loadDataWithTypeAction:type360View_Contact];
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
            NSLog(@"xoa lich");
        }
        else{
            NSLog(@"khong xoa lich");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }
    
}

- (IBAction)actionEdit:(id)sender {
    
    EditAccount360ViewController *viewController = [[EditAccount360ViewController alloc]initWithNibName:@"EditAccount360ViewController" bundle:nil];
    viewController.dataSend=dicData;
    [self presentViewController:viewController animated:YES completion:nil];
    
    
}

- (IBAction)actionDel:(id)sender {
    deleteItem=[self.dataSend objectForKey:DTOLEAD_id];
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá khách hàng?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
    mylert.tag = DELETE_LEAD;
    [mylert show];
    
}
- (IBAction)actionCallCN:(id)sender {
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_mobile]]){
        NSString *callnumber=[NSString stringWithFormat:@"telprompt://%@",[dicData objectForKey:DTOACCOUNT_mobile]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callnumber]];
    }
}

- (IBAction)actionSMSCN:(id)sender {
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_mobile]]){
        NSString *sendSMS=[NSString stringWithFormat:@"sms://%@",[dicData objectForKey:DTOACCOUNT_mobile]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sendSMS]];
    }
}

- (IBAction)actionAddressCN:(id)sender {
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_lat]]) {
        float fLon = [[dicData objectForKey:DTOACCOUNT_lat] floatValue];
        float fLan =[[dicData objectForKey:DTOACCOUNT_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
            viewController.address = [dicData objectForKey:DTOACCOUNT_address];
        }else{
            viewController.address = @"";
        }
        
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
}

- (IBAction)actionEmailCN:(id)sender {
    [Util sendMail:self withEmail:[dicData objectForKey:DTOACCOUNT_email]];
}
- (IBAction)actionAddressDN:(id)sender {
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_lat]]) {
        float fLon = [[dicData objectForKey:DTOACCOUNT_lat] floatValue];
        float fLan =[[dicData objectForKey:DTOACCOUNT_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
            viewController.address = [dicData objectForKey:DTOACCOUNT_address];
        }else{
            viewController.address = @"";
        }
        
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
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
#pragma mark sendmail

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Saved");LocalizedString(@"KEY_DETAIL")
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:LocalizedString(@"KEY_SENDMAIL_SUCCESS")];
            [alert setMessage:nil];
            [alert setDelegate:self];
            [alert addButtonWithTitle:LocalizedString(@"KEY_ALERT_EXIT")]; //
            
            [alert show];
            
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:LocalizedString(@"KEY_SENDMAIL_ERROR")];
            [alert setMessage:nil];
            [alert setDelegate:self];
            [alert addButtonWithTitle:LocalizedString(@"KEY_ALERT_EXIT")];
            
            [alert show];
            
        }
            break;
            
            //NSLog(@"Not send");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void) delegateSendEmail:(NSString *)email{
    [Util sendMail:self withEmail:email];
}
-(IBAction)email :(id)sender{
    
    NSString *email = [dicData objectForKey:DTOACCOUNT_email];
    if (![StringUtil stringIsEmpty:email]) {
        [Util sendMail:self withEmail:email];
    }
}
- (void)delegateCall:(NSString *)mobile {
    if(![StringUtil stringIsEmpty:mobile]){
        NSString *callnumber=[NSString stringWithFormat:@"telprompt://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callnumber]];
    }
}
-(IBAction)call:(id)sender{
    
    NSString *mobile = [dicData objectForKey:DTOACCOUNT_mobile];
    if ([StringUtil stringIsEmpty:mobile]) {
        NSString *callnumber=[NSString stringWithFormat:@"telprompt://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callnumber]];
    }
}
- (void)delegateSMS:(NSString *)mobile {
    if(![StringUtil stringIsEmpty:mobile]){
        NSString *sendSMS=[NSString stringWithFormat:@"sms://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sendSMS]];
    }
}
-(IBAction)sms:(id)sender{
    
    NSString *mobile = [dicData objectForKey:DTOACCOUNT_mobile];
    if ([StringUtil stringIsEmpty:mobile]) {
        NSString *sendSMS=[NSString stringWithFormat:@"sms://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sendSMS]];
    }
}
-(void) setLanguage{
    [_btnExpandInfo setTitle:LocalizedString(@"KEY_360_CONTACT") forState:UIControlStateNormal];
    [_btnNote setTitle: LocalizedString(@"KEY_360_NOTE") forState:UIControlStateNormal];
    [_btnCalendar setTitle:LocalizedString(@"KEY_360_CALENDAR") forState:UIControlStateNormal];
    [_btnTask setTitle:LocalizedString(@"KEY_360_NHIEMVU") forState:UIControlStateNormal];
    [_btnOpportunity setTitle:LocalizedString(@"KEY_360_COHOI") forState:UIControlStateNormal];
    [_btnComplains setTitle:LocalizedString(@"KEY_360_YKIEN") forState:UIControlStateNormal];
    [_btnProductService setTitle:LocalizedString(@"KEY_360_SPDV") forState:UIControlStateNormal];
    [_fullNameLB setText:LocalizedString(@"KEY_LIST_360_TITLE")];
    _leftInfomenu.text=LocalizedString(@"KEY_INFO_360");
    if([type isEqualToString:@"INDIV"]){
        _makhachhangCN.text=LocalizedString(@"KEY_360_CODE");
        _tenkhachangCN.text=LocalizedString(@"KEY_360_NAME");
        _gioitinhCN.text=LocalizedString(@"KEY_360_GIOI_TINH");
        _dienthoaiCN.text=LocalizedString(@"KEY_360_MOBILE");
        _diachiCN.text=LocalizedString(@"KEY_360_ADDRESS");
        _sectorCN.text=LocalizedString(@"KEY_360_SECTOR");
        _nghenghiepCN.text=LocalizedString(@"KEY_360_JOB");
        _chinhanhquanlyCN.text=LocalizedString(@"KEY_360_CHI_NHANH_QL");
        _ngamocodeCN.text=LocalizedString(@"KEY_360_NGAY_MO_CODE");
        _quocgiaCN.text=LocalizedString(@"KEY_360_QUOCGIA");
        _tinhthanhphoCN.text=LocalizedString(@"KEY_360_TINH_THANHPHO");
        _quanhuyenCN.text=LocalizedString(@"KEY_360_QUAN_HUYEN");
        _phuongxaCN.text=LocalizedString(@"KEY_360_PHUONG_XA");
        _khonglienlacCN.text=LocalizedString(@"KEY_360_KHONG_LIEN_LAC");
    }
    else{
        _codeDN.text=LocalizedString(@"KEY_360_CODE");
        _nameDN.text=LocalizedString(@"KEY_360_NAME");
        _loaihinhDN.text=LocalizedString(@"KEY_360_LOAI_DN");
        _soDKKD.text=LocalizedString(@"KEY_360_SO_DKKD");
        _ngaycapDKKD.text=LocalizedString(@"KEY_360_NGAY_DKKD");
        _dienthoaiDN.text=LocalizedString(@"KEY_360_MOBILE");
        _diachiDN.text=LocalizedString(@"KEY_360_ADDRESS");
        _sectorDN.text=LocalizedString(@"KEY_360_SECTOR");
        _loaiDN.text=LocalizedString(@"KEY_360_LOAI_KH");
        _chinhanhquanlyDN.text=LocalizedString(@"KEY_360_CHI_NHANH_QL");
        _ngaymocodeDN.text=LocalizedString(@"KEY_360_NGAY_MO_CODE");
        _quocgiaDN.text=LocalizedString(@"KEY_360_QUOCGIA");
        _tinhthanhphoDN.text=LocalizedString(@"KEY_360_TINH_THANHPHO");
        _quanhuyenDN.text=LocalizedString(@"KEY_360_QUAN_HUYEN");
        _phuongxaDN.text=LocalizedString(@"KEY_360_PHUONG_XA");
        _khonglienlacDN.text=LocalizedString(@"KEY_360_KHONG_LIEN_LAC");
        
    }
}
//delegate tabbar
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSUInteger indexOfTab = [[tabBar items] indexOfObject:item];
    [self showTabbar:indexOfTab];
}
-(void)showTabbar: (NSInteger)index{
    switch (index) {
        case 0:
        {
            if ([leadType isEqualToString:FIX_LEADTYPE_BUSSINESS]) {
                _viewData.hidden=YES;
                _scrollviewCN.hidden=YES;
                _scrollviewDN.hidden=NO;
                [_viewDetailIP addSubview:_scrollviewDN];
                
            }else{
                _viewData.hidden=YES;
                _scrollviewCN.hidden=NO;
                _scrollviewDN.hidden=YES;
                [_viewDetailIP addSubview:_scrollviewCN];
                
            }
            _viewData.hidden=YES;
            _fullNameLB.text=LocalizedString(@"KEY_LIST_360_TITLE");
        }
            break;
        case 1:
        {
            _scrollviewCN.hidden=YES;
            _scrollviewDN.hidden=YES;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_CONTACT");
            [self loadDataWithTypeAction:typeLeaderView_Contact];
        }
            break;
        case 2:
        {
            _scrollviewCN.hidden=YES;
            _scrollviewDN.hidden=YES;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_NOTE");
            [self loadDataWithTypeAction:typeLeaderView_Note];
        }
            break;
        case 3:
        {
            _scrollviewCN.hidden=YES;
            _scrollviewDN.hidden=YES;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_CALENDAR");
            if (typeActionEvent == typeLeaderView_Calendar)
            {
                calendarIsTimeline = !calendarIsTimeline;
            }
            [self loadDataWithTypeAction:typeLeaderView_Calendar];
        }
            break;
        case 4:
        {
            _scrollviewCN.hidden=YES;
            _scrollviewDN.hidden=YES;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_YKIEN");
            [self loadDataWithTypeAction:typeLeaderView_Complains];
        }
            break;
        case 5:
        {
            UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:LocalizedString(@"KEY_FUNCTION") delegate:self cancelButtonTitle:LocalizedString(@"KEY_CANCEL") destructiveButtonTitle:nil otherButtonTitles:LocalizedString(@"KEY_360_NHIEMVU"),LocalizedString(@"KEY_360_COHOI"),LocalizedString(@"KEY_360_SPDV"), nil];
            action.tag=TAG_ACTIONSHEET_MOREINFO;
            [action showInView:self.view];
        }
            break;
        default:
            break;
    }
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    switch (actionSheet.tag) {
        case 11:
            [self loadDataActionSheetWithButtonIndex: buttonIndex];
            break;
        case TAG_ACTIONSHEET_ADD:
            [self loadFormActionSheetWithButtonIndex:buttonIndex];
            break;
        case TAG_ACTIONSHEET_MOREINFO:{
            [self loadFormActionSheetMoreInfoWithButtonIndex: buttonIndex];
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void) loadFormActionSheetMoreInfoWithButtonIndex :(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case TAG_ACTIONSHEET_MOREINFO_INDEX_TASK:
            _scollviewDN.hidden=YES;
            _scrollViewBodyLeft.hidden=YES;
            _mySearch.hidden=NO;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_NHIEMVU");
            [self loadDataWithTypeAction:typeLeaderView_Task];
            break;
        case TAG_ACTIONSHEET_MOREINFO_INDEX_OPPORTUNITY:
            _scollviewDN.hidden=YES;
            _scrollViewBodyLeft.hidden=YES;
            _mySearch.hidden=NO;
            _viewData.hidden=NO;
            _fullNameLB.text=LocalizedString(@"KEY_360_COHOI");
            [self loadDataWithTypeAction:typeLeaderView_Opportunity];
            break;
        case TAG_ACTIONSHEET_MOREINFO_INDEX_PRODUCT:{
            _fullNameLB.text=LocalizedString(@"KEY_360_SPDV");
            [self loadDataWithTypeAction:typeLeaderView_ProductsLead];
        }
            break;
        default:
            break;
    }
}


//Ham load du lieu du theo buttonIndex
-(void) loadDataActionSheetWithButtonIndex :(NSInteger)buttonIndex{
    
    if(buttonIndex==0){
        
        _scollviewDN.hidden=YES;
        _scrollViewBodyLeft.hidden=YES;
        _mySearch.hidden=NO;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_NHIEMVU");
        [self loadDataWithTypeAction:typeLeaderView_Task];
        
    }
    else if (buttonIndex ==1){
        _scollviewDN.hidden=YES;
        _scrollViewBodyLeft.hidden=YES;
        _mySearch.hidden=NO;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_COHOI");
        [self loadDataWithTypeAction:typeLeaderView_Opportunity];
    }
    else if (buttonIndex == 2){
        _scollviewDN.hidden=YES;
        _scrollViewBodyLeft.hidden=YES;
        _mySearch.hidden=NO;
        _viewData.hidden=NO;
        _fullNameLB.text=LocalizedString(@"KEY_360_SPDV");
        [self loadDataWithTypeAction:typeLeaderView_ProductsLead];
    }
    
}


-(void) loadFormActionSheetWithButtonIndex :(NSInteger)buttonIndex{
    if(buttonIndex==0){
        EditContact360ViewController *edit=[[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
        edit.dataRoot=dicData;
        [self presentViewController:edit animated:YES completion:nil];
    }
    else if (buttonIndex==1){
        EditNote360ViewController *edit=[[EditNote360ViewController alloc] initWithNibName:@"EditNote360ViewController" bundle:nil];
        [self presentViewController:edit animated:YES completion:nil];
    }
    else if (buttonIndex == 2){
        EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
        [viewController setDelegate:self];
        viewController.dataRoot = dicData;
        viewController.isKH360 = YES;
        [self presentViewController:viewController animated:YES completion:nil];        }
    else if(buttonIndex == 4){
        EditOpportunity360ViewController *edit=[[EditOpportunity360ViewController alloc] initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
        edit.dataSend=dicData;
        [self presentViewController:edit animated:YES completion:nil];
    }
    else if (buttonIndex == 3){
        EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
        viewController.dataRoot = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
}

///search cac thong tin lien quan toi khach hang
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *safeSearchString = [[searchText componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]] componentsJoinedByString:@""];
    searchBar.text=safeSearchString;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    switch (typeActionEvent) {
        case typeLeaderView_ExpandInfo:{
            
        }
            break;
        case typeLeaderView_Contact:{
            NSLog(@"lien he");
            arrayData = [dtoContactProcess filterWithArrayCondition:searchBar.text :[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            [self.tbData reloadData];
            
        }break;
        case typeLeaderView_Note:{
            NSLog(@"ghi chu");
            arrayData = [dtoNoteProcess filterContainWithClient360Id:searchBar.text : [dicData objectForKey:DTOACCOUNT_clientAccountId]];
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
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    switch (typeActionEvent) {
        case typeLeaderView_ExpandInfo:{
            
        }
            break;
        case typeLeaderView_Contact:{
            arrayData = [dtoContactProcess filterWithClientLeaderId :[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            [self.tbData reloadData];
            
        }break;
        case typeLeaderView_Note:{
            arrayData = [dtoNoteProcess filterWithClientLeaderId : [dicData objectForKey:DTOACCOUNT_clientAccountId]];
            [self.tbData reloadData];
        }break;
        case typeLeaderView_Opportunity:{
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
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton=YES;
}
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton =NO;
    [searchBar resignFirstResponder];
}
@end
