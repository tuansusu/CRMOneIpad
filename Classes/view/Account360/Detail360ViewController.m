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

#import "TaskCalendarCell.h"
#import "TaskCalTLineCell.h"
#import "TaskActionCell.h"

////remove
#import "StringUtil.h"

#define TITLE_APP @"KHÁCH HÀNG 360"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_NOTE 1
#define SELECT_INDEX_ADD_CALENDAR 2
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_OPPORTUNITY 4

#define WIDTH_HEADER_EXPAND_INFO 930

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
    [self.scrollViewHeaderExpandInfo setContentSize:CGSizeMake(WIDTH_HEADER_EXPAND_INFO, self.scrollViewHeaderExpandInfo.frame.size.height)];
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _scollviewDN.contentSize=CGSizeMake(0, self.view.frame.size.height);
    _scrollViewBodyLeft.contentSize=CGSizeMake(0, self.view.frame.size.height);
    //[self setLanguage];
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
    
    _fullNameLB.text=@"KHÁCH HÀNG 360";
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR, SELECT_TEXT_ADD_TASK, SELECT_TEXT_ADD_OPPORTUNITY, nil];
    
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
    
    if ([dicData isKindOfClass:[NSNull class]] || dicData==nil ) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    [self actionExpandInfo:self.btnExpandInfo];
    arrayData  = [NSArray new];
    [self loadDetailCustomerPersonalData];
    
}

/*
 *Load danh sach khach hang ca nhan
 */
-(void) loadDetailCustomerPersonalData {
    NSString*type=[dicData objectForKey:DTOACCOUNT_accountType];
    float fyCN=_lbCode.frame.origin.y;
    CGFloat heightLabelCN=0.0f;
    NSLog(@"type:%@",type);
    if([type isEqualToString:@"INDIV"]){
        NSLog(@"Khach hang ca nhan");
        _scollviewDN.hidden=YES;
        if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_code]]){
            _lbCode.text=[dicData objectForKey:DTOACCOUNT_code];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_code]];
            
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbCode];}
        }
        else{
            _lbCode.text=@"";
        }
        fyCN = _lbCode.frame.origin.y + _lbCode.frame.size.height + 10;
        _lbName.frame = CGRectMake(_lbName.frame.origin.x,fyCN, _lbName.frame.size.width, _lbName.frame.size.height);
        _tenkhachangCN.frame = CGRectMake(_tenkhachangCN.frame.origin.x,fyCN, _tenkhachangCN.frame.size.width, _tenkhachangCN.frame.size.height);
        
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_name]]) {
            _lbName.text=[dicData objectForKey:DTOACCOUNT_name];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_name]];
            
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbName];}
        }
        else{
            _lbName.text=@"";
        }
        fyCN = _lbName.frame.origin.y + _lbName.frame.size.height + 10;
        self.lbSex.frame = CGRectMake(self.lbSex.frame.origin.x,fyCN, _lbSex.frame.size.width, self.lbSex.frame.size.height);
         _gioitinhCN.frame = CGRectMake(_gioitinhCN.frame.origin.x,fyCN, _gioitinhCN.frame.size.width, _gioitinhCN.frame.size.height);
        if([[dicData objectForKey:DTOACCOUNT_sex] isEqualToString:@"1"] || [[dicData objectForKey:DTOACCOUNT_sex] isEqualToString:@"Nam"]){
            _lbSex.text=@"Nam";
        }
        else{
            _lbSex.text=@"Nữ";
        }
        fyCN = _lbSex.frame.origin.y + _lbSex.frame.size.height + 10;
        _lbMobile.frame = CGRectMake(_lbMobile.frame.origin.x,fyCN, _lbMobile.frame.size.width, _lbMobile.frame.size.height);
        _dienthoaiCN.frame = CGRectMake(_dienthoaiCN.frame.origin.x,fyCN, _dienthoaiCN.frame.size.width, _dienthoaiCN.frame.size.height);
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_mobile]]) {
            _lbMobile.text=[dicData objectForKey:DTOACCOUNT_mobile];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_mobile]];
            
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbMobile];}
        }
        else{
            _lbMobile.text=@"";
        }
        fyCN = _lbMobile.frame.origin.y + _lbMobile.frame.size.height + 10;
        _lbEmail.frame = CGRectMake(_lbEmail.frame.origin.x,fyCN, _lbEmail.frame.size.width, _lbEmail.frame.size.height);
        _emailCN.frame = CGRectMake(_emailCN.frame.origin.x,fyCN, _emailCN.frame.size.width, _emailCN.frame.size.height);

        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_email]]) {
            _lbEmail.text=[dicData objectForKey:DTOACCOUNT_email];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_email]];
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbEmail];}
        }
        else{
            _lbEmail.text=@"";
        }
        fyCN = _lbEmail.frame.origin.y + _lbEmail.frame.size.height + 10;
        _lbDiaChi.frame = CGRectMake(_lbDiaChi.frame.origin.x,fyCN, _lbDiaChi.frame.size.width, _lbDiaChi.frame.size.height);
        _diachiCN.frame = CGRectMake(_diachiCN.frame.origin.x,fyCN, _diachiCN.frame.size.width, _diachiCN.frame.size.height);
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
            _lbDiaChi.text=[dicData objectForKey:DTOACCOUNT_address];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_address]];
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbDiaChi];}
        }
        else{
            _lbDiaChi.text=@"";
        }
        fyCN = _lbDiaChi.frame.origin.y + _lbDiaChi.frame.size.height + 10;
        _lbSector.frame = CGRectMake(_lbSector.frame.origin.x,fyCN, _lbSector.frame.size.width, _lbSector.frame.size.height);
          _sectorCN.frame = CGRectMake(_sectorCN.frame.origin.x,fyCN, _sectorCN.frame.size.width, _sectorCN.frame.size.height);
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_sector]]) {
            _lbSector.text=[dicData objectForKey:DTOACCOUNT_sector];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_sector]];
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbSector];}
            
        }
        else{
            _lbSector.text=@"";
        }
        fyCN = _lbSector.frame.origin.y + _lbSector.frame.size.height + 10;
        _lbJob.frame = CGRectMake(_lbJob.frame.origin.x,fyCN, _lbJob.frame.size.width, _lbJob.frame.size.height);
       
         _nghenghiepCN.frame = CGRectMake(_nghenghiepCN.frame.origin.x,fyCN, _nghenghiepCN.frame.size.width, _nghenghiepCN.frame.size.height);
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_personalIndustry]]) {
            _lbJob.text=[dicData objectForKey:DTOACCOUNT_personalIndustry];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_personalIndustry]];
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbJob];}
        }
        else {
            _lbJob.text=@"";
        }
        
        fyCN = _lbJob.frame.origin.y + _lbJob.frame.size.height + 10;
        _lbCompany.frame = CGRectMake(_lbCompany.frame.origin.x,fyCN, _lbCompany.frame.size.width, _lbCompany.frame.size.height);
           _chinhanhquanlyCN.frame = CGRectMake(_chinhanhquanlyCN.frame.origin.x,fyCN, _chinhanhquanlyCN.frame.size.width, _chinhanhquanlyCN.frame.size.height);
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_branchCode]]) {
            _lbCompany.text=[dicData objectForKey:DTOACCOUNT_branchCode];
            heightLabelCN =  [self getHeightLabel:[dicData objectForKey:DTOACCOUNT_branchCode]];
            if (heightLabelCN>25) {
                [UILabel setMultiline:_lbCompany];}
            
        }
        else{
            _lbCompany.text=@"";
        }
        fyCN = _lbCompany.frame.origin.y + _lbCompany.frame.size.height + 10;
        _ldDateOpenCode.frame = CGRectMake(_ldDateOpenCode.frame.origin.x,fyCN, _ldDateOpenCode.frame.size.width, _ldDateOpenCode.frame.size.height);
          _ngamocodeCN.frame = CGRectMake(_ngamocodeCN.frame.origin.x,fyCN, _ngamocodeCN.frame.size.width, _ngamocodeCN.frame.size.height);
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_openCodeDate]]) {
            _ldDateOpenCode.text=[dicData objectForKey:DTOACCOUNT_openCodeDate];
        }
        else{
            _ldDateOpenCode.text=@"";
        }
        fyCN = _ldDateOpenCode.frame.origin.y + _ldDateOpenCode.frame.size.height + 10;
        _lbQuocGia.frame = CGRectMake(_lbQuocGia.frame.origin.x,fyCN, _lbQuocGia.frame.size.width, _lbQuocGia.frame.size.height);
         _quocgiaCN.frame = CGRectMake(_quocgiaCN.frame.origin.x,fyCN, _quocgiaCN.frame.size.width, _quocgiaCN.frame.size.height);
        _lbQuocGia.text=@"";
        fyCN = _lbQuocGia.frame.origin.y + _lbQuocGia.frame.size.height + 10;
        _lbThanhPho.frame = CGRectMake(_lbThanhPho.frame.origin.x,fyCN, _lbThanhPho.frame.size.width, _lbThanhPho.frame.size.height);
          _tinhthanhphoCN.frame = CGRectMake(_tinhthanhphoCN.frame.origin.x,fyCN, _tinhthanhphoCN.frame.size.width, _tinhthanhphoCN.frame.size.height);
        _lbThanhPho.text=@"";
        fyCN = _lbThanhPho.frame.origin.y + _lbThanhPho.frame.size.height + 10;
        _lbQuanHuyen.frame = CGRectMake(_lbQuanHuyen.frame.origin.x,fyCN, _lbQuanHuyen.frame.size.width, _lbQuanHuyen.frame.size.height);
         _quanhuyenCN.frame = CGRectMake(_quanhuyenCN.frame.origin.x,fyCN, _quanhuyenCN.frame.size.width, _quanhuyenCN.frame.size.height);
        _lbQuanHuyen.text=@"";
        fyCN = _lbQuanHuyen.frame.origin.y + _lbQuanHuyen.frame.size.height + 10;
        _lbPhuonXa.frame = CGRectMake(_lbPhuonXa.frame.origin.x,fyCN, _lbPhuonXa.frame.size.width, _lbPhuonXa.frame.size.height);
        _phuongxaCN.frame = CGRectMake(_phuongxaCN.frame.origin.x,fyCN, _phuongxaCN.frame.size.width, _phuongxaCN.frame.size.height);
        _lbPhuonXa.text=@"";
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
        fyCN = _lbPhuonXa.frame.origin.y + _lbPhuonXa.frame.size.height + 10;
        _lbKhongLienLacQua.frame = CGRectMake(_lbKhongLienLacQua.frame.origin.x,fyCN, _lbKhongLienLacQua.frame.size.width, _lbKhongLienLacQua.frame.size.height);
          _khonglienlacCN.frame = CGRectMake(_khonglienlacCN.frame.origin.x,fyCN, _khonglienlacCN.frame.size.width, _khonglienlacCN.frame.size.height);
        NSString *tmp=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
        _lbKhongLienLacQua.text=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
        heightLabelCN =  [self getHeightLabel:tmp];
        if (heightLabelCN>25) {
            [UILabel setMultiline:_lbKhongLienLacQua];}
        _scrollViewBodyLeft.contentSize=CGSizeMake(0, self.view.frame.size.height + fyCN);
    }
    else{
        float fyDN= self.lbnameDN.frame.origin.y;
        CGFloat heightLabelDN=0.0f;
        NSLog(@"Khach hang doanh nghiep");
        _scrollViewBodyLeft.hidden=YES;
        if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_code]]){
            _lbcodeDN.text=[dicData objectForKey:DTOACCOUNT_code];
        }
        else{
            _lbcodeDN.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_name]]) {
            _lbnameDN.text=[dicData objectForKey:DTOACCOUNT_name];
        }
        else{
            _lbnameDN.text=@"";
        }
        
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_accountType]]) {
            _lbloaiDN.text=[dicData objectForKey:DTOACCOUNT_accountType];
        }
        else{
            _lbloaiDN.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_registrationNumber]]) {
            _lbsoDKKD.text=[dicData objectForKey:DTOACCOUNT_registrationNumber];
        }
        else{
            _lbsoDKKD.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_registrationDate]]) {
            _lbngaycapDKKD.text=[dicData objectForKey:DTOACCOUNT_registrationDate];
        }
        else{
            _lbngaycapDKKD.text=@"";
        }
        
        
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_mobile]]) {
            _lbdienthoaiDN.text=[dicData objectForKey:DTOACCOUNT_mobile];
        }
        else{
            _lbdienthoaiDN.text=@"";
        }
        
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_fax]]) {
            _lbfaxDN.text=[dicData objectForKey:DTOACCOUNT_fax];
        }
        else{
            _lbfaxDN.text=@"";
        }
        
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
            _lbdiachiDN.text=[dicData objectForKey:DTOACCOUNT_address];
        }
        else{
            _lbdiachiDN.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_sector]]) {
            _lbsectorDN.text=[dicData objectForKey:DTOACCOUNT_sector];
        }
        else{
            _lbsectorDN.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_orgType]]) {
            _lbloaihinhDN.text=[dicData objectForKey:DTOACCOUNT_orgType];
        }
        else {
            _lbloaihinhDN.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_ownerEmployeeId]]) {
            _lbchinhanhquanlyDN.text=[dicData objectForKey:DTOACCOUNT_ownerEmployeeId];
        }
        else{
            _lbchinhanhquanlyDN.text=@"";
        }
        if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_openCodeDate]]) {
            _lbngaymocodeDN.text=[dicData objectForKey:DTOACCOUNT_openCodeDate];
        }
        else{
            _lbngaymocodeDN.text=@"";
        }
        _lbquocgiaDN.text=@"";
        _lbtinhthanhphoDN.text=@"";
        _lbquanhuyenDN.text=@"";
        _lbphuongxaDN.text=@"";
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
        _lbkhonglienlacDN.text=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
        
        
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
            self.viewBodyExpandInfo.hidden = NO;
            self.tbData.hidden  = YES;
            [viewProductsLead setHidden:YES];
            [viewComplain setHidden:NO];
            [viewComplain setDelegate:self];
            [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOACCOUNT_clientAccountId] description]];
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
            return 60.0f;
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
-(void)setLanguage{
    //    _codeDN.text=LocalizedString(@"KEY_360_CODE");
    //    _makhachhangCN.text=LocalizedString(@"KEY_360_CODE");
    //
    //    _nameDN.text=LocalizedString(@"KEY_360_NAME");
    //     _tenkhachangCN.text=LocalizedString(@"KEY_360_NAME");
    
};
- (IBAction)actionCallCN:(id)sender {
}

- (IBAction)actionSMSCN:(id)sender {
}

- (IBAction)actionAddressCN:(id)sender {
}

- (IBAction)actionEmailCN:(id)sender {
}
- (IBAction)actionAddressDN:(id)sender {
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
@end
