//
//  EditAccountLeadViewController.m
//  OfficeOneMB
//
//  Created by viettel on 11/15/14.
//
//

#import "EditAccountLeadViewController.h"
#import "DTOACCOUNTLEADProcess.h"
#import "DTOSYSCATProcess.h"
#import "DataField.h"
#import "FlowLeadViewController.h"
#import "SelectAddInMapsViewController.h"
#import "ListAccountLeadViewController.h"
#import "EnumClass.h"

#define TAG_SELECT_PERSONAL_POSITION 1
#define TAG_SELECT_PERSONAL_JOB 2

#define TAG_ALERTVIEW_DATEOFBIRTH 233
#define TAG_ALERTVIEW_DATEOFBIRTH_PICKER 2332


#define TEXT_HEADER_ADD_LEADER_PERSON @"THÊM MỚI KHÁCH HÀNG CÁ NHÂN"
#define TEXT_HEADER_EDIT_LEADER_PERSON @"SỬA KHÁCH HÀNG CÁ NHÂN"

@interface EditAccountLeadViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOSYSCATProcess *dtoSyscatProcess; //NGHE NGHIEP CA NHAN
    Util*util;
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    
    //thong tin chon cho loai hinh CA NHAN
    
    int SELECTED_TAG ;
    
    NSInteger selectPersonJobIndex;
    NSArray *listArrPersonJob;
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectPersonPositionIndex;
    NSArray *listArrPersonPosition;
    
    BOOL succsess;//Trang thai acap nhat
    
    //key board
    float heightKeyboard;
    UITextField *_txt;
    BOOL isPhone,isEmail,isSMS,isMeeting;
    
    
    //thong tin chon NGAY - THANG
    int SELECTED_DATE_TAG ;
    NSDate  *dateBirthday;
    NSDateFormatter *df;
    
    //luu lai thong tin chon dia chi cua ban do
    float _longitude, _latitude;
    Language *obj;
    UIAlertView *alertView ;
    UIToolbar *toolBar;
    UITableView *tableAlert;
    
    
}
@end

@implementation EditAccountLeadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [self registerForKeyboardNotifications];
    return self;
}

- (void)viewDidLoad
{
    isPhone=NO;
    isEmail=NO;
    isSMS=NO;
    isMeeting=NO;
    _latitude=0;
    _longitude=0;
    [super viewDidLoad];
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    util=[Util new];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj=[Language getInstance];
    obj.str=[defaults objectForKey:@"Language"];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self setLanguage];
    if ([self currentDeviceType]==iPhone) {
        [self setBorderTextfield:_txtName];
        [self setBorderTextfield:_txtPhone];
        [self setBorderTextfield:_txtNumberIdentity];
        [self setBorderTextfield:_txtEmail];
        [self setBorderTextfield:_txtCompany];
        [self setBorderTextfield:_txtPersonPosition];
        [self setBorderTextfield:_txtDateOfBirth];
        [self setBorderTextfield:_txtAddress];
        [self setBorderTextfield:_txtMonthlyIncom];
        [self setBorderTextfield:_txtTotalassets];
        [_bodyMainView setContentSize:CGSizeMake(320, _bodyMainView.frame.size.height+50)];
        //show date
        self.datePicker = [[UIDatePicker alloc] init];
        
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.backgroundColor=[UIColor whiteColor];
        [self.txtDateOfBirth setInputView:self.datePicker];
        //show select
        tableAlert = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 230)];
        tableAlert.delegate=self;
        tableAlert.dataSource=self;
        [tableAlert reloadData];
        [self.txtPersonPosition setInputView:tableAlert];
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        toolBar.barStyle=UIBarStyleDefault;
        UIBarButtonItem *doneBtn;
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(setSelectedDate)];
        
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [self.txtDateOfBirth setInputAccessoryView:toolBar];
        [self.txtPersonPosition setInputAccessoryView:toolBar];
        
    }
    else{
        [_txtPhone setPaddingRight];
        [_txtName setPaddingRight];
    }
}
-(void)setBorderTextfield:(UITextField *)txtField{
    
    txtField.textColor = TEXT_COLOR_REPORT;
    txtField.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    [txtField setBorderWithOption:smgSelect];
    [txtField setPaddingLeft];
}
//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:FORMAT_DATE];
    
    
    _latitude = -1; //khong chon
    _longitude = -1; //khong chon
    
    selectPersonJobIndex = -1;
    selectPersonPositionIndex = -1;
    succsess = NO;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    arrayData  = [NSArray new];
    arrayData = [dtoLeadProcess filter];
    
    dtoSyscatProcess = [DTOSYSCATProcess new];
    listArrPersonJob = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_PERSONAL_JOB];
    listArrPersonPosition = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_PERSONAL_POSITION];
    
    dataId = 0;
    if (self.dataSend) {
        if([self currentDeviceType]==iPhone)
        {
            self.fullNameLB.text = @"CẬP NHẬP";
        }
        else{
            self.fullNameLB.text = TEXT_HEADER_EDIT_LEADER_PERSON;
        }
        [self loadEditData];
    }else{
        if([self currentDeviceType]==iPhone)
        {
            self.fullNameLB.text = @"THÊM MỚI";
        }
        else{
            self.fullNameLB.text = TEXT_HEADER_ADD_LEADER_PERSON;
        }
    }
    
}

//Load thong tin len form sua
-(void) loadEditData {
    _btnDel.hidden=NO;
    NSDictionary * getData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[self.dataSend objectForKey:DTOLEAD_id]];
    NSLog(@"getData: %@",getData);
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_name]]) {
        _txtName.text =[getData objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_address]]) {
        _txtAddress.text =[getData objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_mobile]]) {
        _txtPhone.text =[getData objectForKey:DTOLEAD_mobile];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_organization]]) {
        _txtCompany.text =[getData objectForKey:DTOLEAD_organization];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_birthday]]) {
        _txtDateOfBirth.text =[getData objectForKey:DTOLEAD_birthday];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_email]]) {
        _txtEmail.text =[getData objectForKey:DTOLEAD_email];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_identifiedNumber]]) {
        _txtNumberIdentity.text =[getData objectForKey:DTOLEAD_identifiedNumber];
    }
    NSString *strPersonalJob = [getData objectForKey:DTOLEAD_personalJob];
    if (![StringUtil stringIsEmpty:strPersonalJob]) {
        NSArray *arrayPersonJobID = [listArrPersonJob valueForKey:DTOSYSCAT_sysCatId];
        selectPersonJobIndex = [arrayPersonJobID indexOfObject:strPersonalJob];
        if (selectPersonJobIndex>=0) {
            NSDictionary *dataPersonJob = [listArrPersonJob objectAtIndex:selectPersonJobIndex];
            _txtJob.text = [dataPersonJob objectForKey:DTOSYSCAT_name];
        }
    }
    
    NSString *strPersonalPosition = [getData objectForKey:DTOLEAD_personalPosition];
    if (![StringUtil stringIsEmpty:strPersonalPosition]) {
        NSArray *arrayPersonJobID = [listArrPersonPosition valueForKey:DTOSYSCAT_sysCatId];
        selectPersonPositionIndex = [arrayPersonJobID indexOfObject:strPersonalPosition];
        if (selectPersonPositionIndex>=0) {
            NSDictionary *dataPersonJob = [listArrPersonPosition objectAtIndex:selectPersonPositionIndex];
            _txtPersonPosition.text = [dataPersonJob objectForKey:DTOSYSCAT_name];
        }
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_sex]]) {
        if ([[getData objectForKey:DTOLEAD_sex] isEqualToString:@"Nữ"]) {
            _segSex.selectedSegmentIndex = 1;
        }
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_marialStatus]]) {
        if ([[getData objectForKey:DTOLEAD_marialStatus] isEqualToString:@"1"]) {
            _segMarialStatus.selectedSegmentIndex = 1;
        }
    }
    
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_monthlyIncome]]) {
        _txtMonthlyIncom.text =[getData objectForKey:DTOLEAD_monthlyIncome];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_assetTotal]]) {
        _txtTotalassets.text =[getData objectForKey:DTOLEAD_assetTotal];
    }
    if ([[getData objectForKey:DTOLEAD_disableEmail] isEqualToString:@"1"]) {
        isEmail=YES;
        [_btnCheckEmail setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
    }
    if ([[getData objectForKey:DTOLEAD_disablePhone] isEqualToString:@"1"]) {
        isPhone=YES;
        [_btnCheckMobile setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
    }
    if ([[getData objectForKey:DTOLEAD_disableSms ] isEqualToString:@"1"]) {
        isSMS=YES;
        [_btnCheckSMS setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
    }
    if(![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_lat]]){
        _latitude =[[dicData objectForKey:DTOLEAD_lat] floatValue];
    }
    if(![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_lon]]){
        _longitude =[[dicData objectForKey:DTOLEAD_lon] floatValue];
    }
}


- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    //    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    //    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    
    
    //[self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    //[self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    //    for (UIView *viewSubTemp in self.headerMainView.subviews) {
    //
    //
    //        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
    //            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
    //        }
    //    }
    
    
    
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    //[self.btnSave setStyleNormalWithOption:smgSelect];
    
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        
        //        if ([viewTemp isKindOfClass:[UIView class]]) {
        //            ((UIView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
        //
        //            ((UIView*) viewTemp).layer.borderWidth = BORDER_WITH;
        //            ((UIView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
        //
        //        }
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
            }
            
            
            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                
                
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                //                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                //                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
                [((UITextField*) viewSubTemp) setPaddingLeft];
            }
            
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            if(viewTemp.tag!=10){
                [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
            }
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) actionSave:(id)sender{
    //check valid to save
    
    if (![util checkValidToSave:_txtName :LocalizedString(@"KEY_LEAD_CN_CHECK_NAME") :self.viewMainBodyInfo]) {
        return;
    }
    if(![util checkValidToSave:_txtPhone :LocalizedString(@"KEY_LEAD_CN_CHECK_MOBILE") :_viewMainBodyInfo]){
        return;
    }
    if(_txtEmail.text.length>0 && ![util validateEmail:_txtEmail.text]){
        
        [util showTooltip:_txtEmail withText:LocalizedString(@"KEY_LEAD_CN_CHECK_EMAIL") showview:_viewMainBodyInfo];
        [util setBorder:_txtEmail];
        return;
    }
    if (_txtNumberIdentity.text.length>0){
        if(_txtNumberIdentity.text.length<9 || _txtNumberIdentity.text.length >=20) {
            [util showTooltip:_txtNumberIdentity withText:LocalizedString(@"MIN_NUMBERIDENTITY") showview:_viewMainBodyInfo];
            [util setBorder:_txtNumberIdentity];
            return;
        }
    }
    if (_txtPhone.text.length > 20 || _txtPhone.text.length <9 ) {
        [util showTooltip:_txtPhone withText:LocalizedString(@"MAXLENG_PHONE") showview:_viewMainBodyInfo];
        [util setBorder:_txtPhone];
        return;
    }
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    
    
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOLEAD_name];
    [dicEntity setObject:[StringUtil trimString:_txtNumberIdentity.text] forKey:DTOLEAD_identifiedNumber];
    [dicEntity setObject:[StringUtil trimString:_txtAddress.text] forKey:DTOLEAD_address];
    [dicEntity setObject:[StringUtil trimString:_txtPhone.text]forKey:DTOLEAD_mobile];
    [dicEntity setObject:[StringUtil trimString:_txtCompany.text] forKey:DTOLEAD_organization];
    
    
    [dicEntity setObject:[StringUtil trimString:_txtDateOfBirth.text] forKey:DTOLEAD_birthday];
    
    [dicEntity setObject:[StringUtil trimString:_txtEmail.text] forKey:DTOLEAD_email];
    if(_longitude>0){
        NSString *myLon=[NSString stringWithFormat:@"%f",_longitude];
        [dicEntity setObject:myLon forKey:DTOLEAD_lon];
    }
    if(_latitude>0){
        NSString *myLat=[NSString stringWithFormat:@"%f",_latitude];
        [dicEntity setObject:myLat forKey:DTOLEAD_lat];
    }
    if (isPhone) {
        [dicEntity setObject:@"1" forKey:DTOLEAD_disablePhone];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOLEAD_disablePhone];
    }
    if (isEmail) {
        [dicEntity setObject:@"1" forKey:DTOLEAD_disableEmail];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOLEAD_disableEmail];
    }
    if (isSMS) {
        [dicEntity setObject:@"1" forKey:DTOLEAD_disableSms];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOLEAD_disableSms];
    }
    if (isMeeting) {
        [dicEntity setObject:@"1" forKey:DTOLEAD_disableMeeting];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOLEAD_disableMeeting];
    }
    
    
    //xac dinh chuc danh
    if (selectPersonJobIndex>=0) {
        [dicEntity setObject:[[listArrPersonJob objectAtIndex:selectPersonJobIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOLEAD_personalJob];
    }
    //nghe nghiep
    if (selectPersonPositionIndex>=0) {
        [dicEntity setObject:[[listArrPersonPosition objectAtIndex:selectPersonPositionIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOLEAD_personalPosition];
    }
    
    
    if (self.segSex.selectedSegmentIndex == 0) {
        [dicEntity setObject:@"Nam" forKey:DTOLEAD_sex];
    }else{
        [dicEntity setObject:@"Nữ" forKey:DTOLEAD_sex];
    }
    
    if (self.segSex.selectedSegmentIndex == 0) {
        [dicEntity setObject:@"0" forKey:DTOLEAD_marialStatus];
    }else{
        [dicEntity setObject:@"1" forKey:DTOLEAD_marialStatus];
    }
    
    [dicEntity setObject:[StringUtil trimString:_txtMonthlyIncom.text] forKey:DTOLEAD_monthlyIncome];
    [dicEntity setObject:[StringUtil trimString:_txtTotalassets.text] forKey:DTOLEAD_assetTotal];
    [dicEntity setObject:@"0" forKey:DTOLEAD_leadType];
    [dicEntity setObject:@"1" forKey:DTOLEAD_status];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOLEAD_updatedDate];
    
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOLEAD_id] forKey:DTOLEAD_id];
    }else{
        [dicEntity setObject:IntToStr([dtoLeadProcess getClientId]) forKey:DTOLEAD_clientLeadId];
    }
    succsess = [dtoLeadProcess insertToDBWithEntity:dicEntity];
    
    if (succsess) {
        //them moi thanh cong thi sang form chi tiet
        //       NSMutableArray *dtArry =  [dtoLeadProcess filterTop];
        //        DetailLeadViewController *detail = [[DetailLeadViewController alloc] initWithNibName:@"DetailLeadViewController" bundle:nil];
        //        detail.dataSend = [dtArry objectAtIndex:0];
        //        detail.detailNew=YES;
        //        [self presentViewController:detail animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_ERROR") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERT_EXIT") otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
    
}

- (IBAction)actionDel:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_DEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles:LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
    alert.tag=11;
    [alert show];
}

-(void) actionClose:(id)sender{
    
}

-(void) homeBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) dateChanged:(id)sender
{
    NSDateFormatter *birthDateFormatter;
    birthDateFormatter = [[NSDateFormatter alloc] init];
    //[birthDateFormatter setDateStyle:NSDateFormatterShortStyle];
    birthDateFormatter.dateFormat=@"dd/MM/yyyy";
    UIDatePicker *birthDatePicker = (UIDatePicker *)sender;
    NSString *date=[birthDateFormatter stringFromDate:birthDatePicker.date];
    _txtDateOfBirth.text=date;
    NSLog(@"birthdateformat = %@",[birthDateFormatter stringFromDate:birthDatePicker.date] );
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (succsess && alertView.tag == 5 && buttonIndex == 0) { //thong bao dong form
        // [self dismissViewControllerAnimated:YES completion:nil];
        NSMutableArray *array = [dtoLeadProcess filterTop];
        _dataSend =[array objectAtIndex:0];
        return;
    }
    
    if (succsess && alertView.tag == 5 && buttonIndex == 1) {
        //reset lai form
        [self resetForm];
        return;
    }
    if(alertView.tag==6){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if(alertView.tag==11){
        if(buttonIndex==0){
            BOOL result =    [dtoLeadProcess deleteEntity:[_dataSend objectForKey:DTOLEAD_id]];
            if(result){
                //[self dismissViewControllerAnimated:YES completion:nil];
                ListAccountLeadViewController *viewControler=[[ListAccountLeadViewController alloc]initWithNibName:@"ListAccountLeadViewController" bundle:nil];
                [self presentViewController:viewControler animated:YES completion:nil];
            }
        }
    }
}

-(void) resetForm {
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).text = @"";
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).text = @"";
            }
            
        }
    }
    selectPersonJobIndex = -1;
    selectPersonPositionIndex = -1;
    succsess = false;
    
    [self hiddenKeyBoard];
    
}

-(void) hiddenKeyBoard {
    for (UIView *viewTemp in _bodyMainView.subviews) {
        for (UIView *subViewTemp in viewTemp.subviews) {
            
            if([subViewTemp isKindOfClass:[UITextField class]]){
                [(UITextField *)subViewTemp resignFirstResponder];
            }
            
            
        }
    }
}


- (IBAction)actionChoicePersonalJob:(id)sender {
    
    //hide all key
    [self hiddenKeyBoard];
    
    SELECTED_TAG = TAG_SELECT_PERSONAL_JOB;
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectPersonJobIndex;
    
    detail.listData = [listArrPersonJob valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _btnPersonalJob.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewExpandInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}
- (IBAction)actionChoicePersonalPosition:(id)sender {
    
    //hide all key
    [self hiddenKeyBoard];
    if([self currentDeviceType]==iPhone){
        alertView = [[UIAlertView alloc] initWithTitle:@"Chọn chức danh" message:@"" delegate:self cancelButtonTitle:@"Huỷ" otherButtonTitles:nil, nil];
        UITableView *tableAlert = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 230)];
        tableAlert.delegate=self;
        tableAlert.dataSource=self;
        [tableAlert reloadData];
        //tableAlert.dataSource=[listArrPersonPosition valueForKey:DTOSYSCAT_name];
        
        [alertView addSubview:tableAlert];
        alertView.tag=222;
        alertView.bounds = CGRectMake(0, 0, 300 ,200);
        [alertView setValue:tableAlert forKey:@"accessoryView"];
        [alertView show];
    }
    else{
        SELECTED_TAG = TAG_SELECT_PERSONAL_POSITION;
        SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
        
        detail.selectIndex = selectPersonPositionIndex;
        
        detail.listData = [listArrPersonPosition valueForKey:DTOSYSCAT_name];
        
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = _btnPersonalPosition.frame;
        
        detail.delegate =(id<SelectIndexDelegate>) self;
        self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

#pragma mark check valid data


#pragma mark UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtName) {
        [textField resignFirstResponder];
        
        [self.txtNumberIdentity becomeFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.txtName) {
        return YES;
    }
    
    //    float height = 190;
    //    if (textField == _txtTotalassets || textField == _txtAddress) {
    //        height = 230;
    //    }
    //
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.25f];
    //
    //    CGRect frame = self.mainView.frame;
    //    frame.origin.y = frame.origin.y - height;
    //    [self.mainView setFrame:frame];
    //
    //    [UIView commitAnimations];
    
    return  YES;
    
}// return NO to disallow editing.

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return  YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //    if (textField == self.txtName) {
    //        return;
    //    }
    //
    //    float height = 190;
    //    if (textField == _txtTotalassets || textField == _txtAddress) {
    //        height = 230;
    //    }
    //
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:0.25f];
    //    CGRect frame = self.mainView.frame;
    //    frame.origin.y = frame.origin.y + height;
    //    [self.mainView setFrame:frame];
    //
    //    [UIView commitAnimations];
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    if(textField==_txtName){
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 100 || returnKey;
    }
    if(textField==_txtCompany){
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 100 || returnKey;
    }
    if(textField==_txtPhone){
        
        if ([string length] == 0 && range.length > 0)
        {
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return NO;
        }
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
        {
            
            BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
            
            return newLength <= 20 || returnKey;
        }
        
        return NO;
    }
    if(textField==_txtEmail){
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 50 || returnKey;
    }
    if(textField==_txtAddress){
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 200 || returnKey;
    }
    if(textField==_txtNumberIdentity){
        if ([string length] == 0 && range.length > 0)
        {
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return NO;
        }
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
        {
            
            BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
            
            return newLength <= 20 || returnKey;
        }
        
        return NO;
    }
    if(textField==_txtMonthlyIncom){
        if ([string length] == 0 && range.length > 0)
        {
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return NO;
        }
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
        {
            _txtMonthlyIncom.text=[util formatCurrenc:textField :string];
            
            return NO;
        }
        
        return NO;
    }
    if (textField==_txtTotalassets) {
        _txtTotalassets.text=[util formatCurrenc:textField :string];
        return NO;
    }
    
    return  YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    return  YES;
//}// called when 'return' key pressed. return NO to ignore.


#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    
    switch (SELECTED_TAG) {
        case TAG_SELECT_PERSONAL_POSITION:
        {
            selectPersonPositionIndex = index;
            if (index<listArrPersonPosition.count) {
                NSDictionary *dic = [listArrPersonPosition objectAtIndex:index];
                _txtPersonPosition.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
        case TAG_SELECT_PERSONAL_JOB:{
            selectPersonJobIndex = index;
            if (index<listArrPersonJob.count) {
                NSDictionary *dic = [listArrPersonJob objectAtIndex:index];
                _txtJob.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark UITextField


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (kbSize.width>0) {
        heightKeyboard = kbSize.height;
    }
    
    self.bodyMainView.contentSize = CGSizeMake(self.bodyMainView.frame.size.width, self.bodyMainView.frame.size.height + heightKeyboard);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, heightKeyboard, 0.0);
    self.bodyMainView.contentInset = contentInsets;
    self.bodyMainView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    //CGRect aRect = self.view.frame;
    CGRect aRect;
    if ([self currentDeviceType]==iPhone) {
        aRect = CGRectMake(0, 0, 320, 568);
    }else{
        aRect = CGRectMake(0, 0, 1024, 768);
    }
    aRect.size.height -= kbSize.width;
    if (!CGRectContainsPoint(aRect, _txt.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _txt.frame.origin.y-heightKeyboard);
        [self.bodyMainView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    if(self.bodyMainView.contentSize.height>self.bodyMainView.frame.size.height){
        self.bodyMainView.contentSize = CGSizeMake(self.bodyMainView.frame.size.width, self.bodyMainView.frame.size.height - heightKeyboard);
        
        
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.bodyMainView.contentInset = contentInsets;
        self.bodyMainView.scrollIndicatorInsets = contentInsets;
    }
}
- (IBAction)actionAddAdress:(id)sender {
    
    //chọn địa điểm
    
    //neu la luc them moi
    
    //neu la luc sua
    
    TestMapViewController *detail = [[TestMapViewController alloc] initWithNibName:@"TestMapViewController" bundle:nil];
    
    if (self.dataSend) {
        if (![StringUtil stringIsEmpty:[self.dataSend objectForKey:DTOACCOUNT_lat]]) {
            float fLon = [[self.dataSend objectForKey:DTOACCOUNT_lon] floatValue];
            float fLan =[[self.dataSend objectForKey:DTOACCOUNT_lat] floatValue];
            detail.lan = fLan;
            detail.lon = fLon;
            //viewController.address = [dicData objectForKey:DTOLEAD_address];
            if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
                detail.address = [dicData objectForKey:DTOACCOUNT_address];
            }else{
                detail.address = @"";
            }
            
        }
    }
    
    detail.typeMapView = typeMapView_Choice;
    detail.selectMapDelegate = self;
    [self presentViewController:detail animated:YES completion:nil];
    
}

#pragma mark SelectMap Delegate
-(void) selectAddress:(GMSAddress *)addressObj{
    
    NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
    NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
    NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
    NSLog(@"locality=%@", addressObj.locality);
    NSLog(@"subLocality=%@", addressObj.subLocality);
    NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
    NSLog(@"postalCode=%@", addressObj.postalCode);
    NSLog(@"country=%@", addressObj.country);
    NSLog(@"lines=%@", addressObj.lines);
    
    
    _longitude = addressObj.coordinate.longitude;
    _latitude = addressObj.coordinate.latitude;
    
    
    
    if (addressObj.lines.count>0) {
        self.txtAddress.text =[addressObj.lines objectAtIndex:0];
    }
    
}

- (IBAction)actionCheckMobile:(id)sender {
    if(isPhone==NO){
        isPhone=YES;
        [_btnCheckMobile setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
    }
    else if(isPhone==YES){
        isPhone=NO;
        [_btnCheckMobile setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)actionCheckMail:(id)sender {
    if(isEmail==NO){
        isEmail=YES;
        [_btnCheckEmail setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
    }
    else if(isEmail==YES){
        isEmail=NO;
        [_btnCheckEmail setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)actionCheckSMS:(id)sender {
    if (isSMS==NO) {
        isSMS=YES;
        [_btnCheckSMS setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
    }
    else if(isSMS==YES){
        isSMS=NO;
        [_btnCheckSMS setImage:[UIImage imageNamed: @"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)actionChoiceDateOfBirth:(id)sender {
    
    [self hiddenKeyBoard];
    if ([self currentDeviceType]==iPad)
    {
        if (self.txtDateOfBirth.text.length==0) {
            dateBirthday = [DateUtil getDateFromString:@"01/01/2000" :FORMAT_DATE];
        }else{
            dateBirthday = [DateUtil getDateFromString:self.txtDateOfBirth.text :FORMAT_DATE];
        }
        //SELECTED_DATE_TAG = TAG_SELECT_DATE_BIRTHDAY;
        CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
        detail.dateSelected = dateBirthday;
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = self.btnBirthDay.frame;
        
        detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
        
        
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

#pragma mark select date
-(void) selectDatePickerWithDate:(NSDate *)date
{
    
    self.txtDateOfBirth.text = [NSString stringWithFormat:@"%@",
                                [df stringFromDate:date]];
    dateBirthday = date;
    
}

-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}
//set multilanguage
-(void)setLanguage{
    
    if(_dataSend.count>0){
        if ([self currentDeviceType]==iPhone) {
            _fullNameLB.text=LocalizedString(@"KEY_UPDATE");
        }
        else{
            _fullNameLB.text = LocalizedString(@"KEY_LEAD_EDIT_CN_NEW");
        }
    }
    else{
        if ([self currentDeviceType]==iPhone) {
            _fullNameLB.text=LocalizedString(@"KEY_ADDNEW");
        }
        else{
            _fullNameLB.text = LocalizedString(@"KEY_LEAD_ADD_CN_NEW");
        }
    }
    _lbThongtinchinh.text=LocalizedString(@"KEY_LEAD_ADD_NEW");
    //ten khach hang
    _lbtenkhachhang.text=LocalizedString(@"KEY_LEAD_CN_NAME");
    _txtName.placeholder=LocalizedString(@"KEY_LEAD_CN_NAME");
    //cmt
    _lbchungminhthu.text=LocalizedString(@"KEY_LEAD_CN_PASSPORT");
    _txtNumberIdentity.placeholder=LocalizedString(@"KEY_LEAD_CN_PASSPORT");
    //di dong
    _lbdidong.text=LocalizedString(@"KEY_LEAD_CN_PHONE");
    _txtPhone.placeholder=LocalizedString(@"KEY_LEAD_CN_PHONE");
    //cong ty
    _lbCongty.text=LocalizedString(@"KEY_LEAD_CN_COMPANY");
    _txtCompany.placeholder=LocalizedString(@"KEY_LEAD_CN_COMPANY");
    //ngay sinh
    _lbNgaysinh.text=LocalizedString(@"KEY_LEAD_CN_BIRTHDAY");
    _txtDateOfBirth.placeholder=LocalizedString(@"KEY_LEAD_CN_BIRTHDAY");
    _lbthongtinkhacs.text=LocalizedString(@"KEY_LEAD_CN_ORTHER");
    _lbgioitinh.text=LocalizedString(@"KEY_LEAD_CN_GT");
    _lbtinhtranghonnhan.text=LocalizedString(@"KEY_LEAD_CN_GD");
    //dia chi
    _lbdiachi.text=LocalizedString(@"KEY_LEAD_CN_ADDRESS");
    _txtAddress.placeholder=LocalizedString(@"KEY_LEAD_CN_ADDRESS");
    _lbthunhap.text=LocalizedString(@"KEY_LEAD_CN_THUNHAP");
    _txtMonthlyIncom.placeholder=LocalizedString(@"KEY_LEAD_CN_THUNHAP");
    _lbtongtaisan.text=LocalizedString(@"KEY_LEAD_CN_TOTAL_TS");
    _txtTotalassets.placeholder=LocalizedString(@"KEY_LEAD_CN_TOTAL_TS");
    _lbkhongllq.text=LocalizedString(@"KEY_LEAD_CN_KLLQ");
    _lbdienthoai.text=LocalizedString(@"KEY_LEAD_CN_MOBIE");
    _txtPersonPosition.placeholder=LocalizedString(@"KEY_LEAD_CN_CHUCDANH");
    
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[listArrPersonPosition valueForKey:DTOSYSCAT_name]  count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [[listArrPersonPosition valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"More text";
    //cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    NSDictionary *getData = [[listArrPersonPosition valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
    _txtPersonPosition.text=getData;
    selectPersonPositionIndex=indexPath.row;
    [self.txtPersonPosition resignFirstResponder];
    
}

//For iPhone only
-(void) setSelectedDate{
    NSDate *date = self.datePicker.date;
    if([self.txtDateOfBirth isFirstResponder]){
        [self.txtDateOfBirth resignFirstResponder];
        self.txtDateOfBirth.text = [NSString stringWithFormat:@"%@",
                                    [df stringFromDate:date]];
    }
    else{
        [self.txtPersonPosition resignFirstResponder];
    }
}
@end
