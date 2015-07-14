//
//  EditBussinessLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/16/14.
//
//

#import "EditBussinessLeadViewController.h"
#import "DTOACCOUNTLEADProcess.h"
#import "DTOSYSCATProcess.h"
#import "Util.h"
#import "TestMapViewController.h"
#import "ListAccountLeadViewController.h"
#import "EnumClass.h"

@interface EditBussinessLeadViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOSYSCATProcess *dtoSyscatProcess; //loai hinh doanh nghiep
    Util *util;
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    
    //thong tin chon cho loai hinh doanh nghiep
    NSInteger selectOrgTypeIdIndex;
    NSArray *listArrOrgType;
    
    BOOL succsess;//Trang thai acap nhat
    
    //key board
    float heightKeyboard;
    UITextField *_txt;
    //luu lai thong tin chon dia chi cua ban do
    float _longitude, _latitude;
    Language *obj;
    UIAlertView *alertView;
    NSDate  *dateBirthday;
    UIDatePicker *datePicker;
    NSDateFormatter *df;
    UIToolbar *toolBar;
    UITableView *tableAlert;
}
@end

@implementation EditBussinessLeadViewController

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
    [super viewDidLoad];
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    _latitude =0;
    _longitude=0;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    util=[Util new];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    obj=[Language getInstance];
    obj.str=[defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    [self setLanguage];
    if(self.currentDeviceType==iPhone){
        //        [_scrollviewIphone setContentSize:CGSizeMake(0, self.view.frame.size.height)];
        _bodyMainView.contentSize=CGSizeMake(0, self.view.frame.size.height);
        //
        //show date
        datePicker = [[UIDatePicker alloc] init];
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.backgroundColor=[UIColor whiteColor];
        [self.txtNgayTL setInputView:datePicker];
        //show select
        tableAlert = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 230)];
        tableAlert.delegate=self;
        tableAlert.dataSource=self;
        tableAlert.tag=222;
        [tableAlert reloadData];
        [self.txtSysCatType setInputView:tableAlert];
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        toolBar.barStyle=UIBarStyleDefault;
        UIBarButtonItem *doneBtn;
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(setSelectedDate)];
        
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [self.txtNgayTL setInputAccessoryView:toolBar];
        [self.txtSysCatType setInputAccessoryView:toolBar];
        //text
        [self setBorderTextfield:_txtName];
        [self setBorderTextfield:_txtPhone];
        [self setBorderTextfield:_txtTaxCode];
        [self setBorderTextfield:_txtRegisterCodeBussiness];
        [self setBorderTextfield:_txtEmail];
        [self setBorderTextfield:_txtAddress];
        [self setBorderTextfield:_txtSysCatType];
        [self setBorderTextfield:_txtRevenue];
        [self setBorderTextfield:_txtProfitBeforeTax];
        [self setBorderTextfield:_txtCharterCapital];
        [self setBorderTextfield:_txtCapital];
        [self setBorderTextfield:_txtNgayTL];
        [self setBorderTextfield:_txtTotalassets];
        
        [Util setContentSizeScrollView:_bodyMainView : 100];
        
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
    selectOrgTypeIdIndex = -1;
    succsess = NO;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    arrayData  = [NSArray new];
    arrayData = [dtoLeadProcess filter];
    
    dtoSyscatProcess = [DTOSYSCATProcess new];
    listArrOrgType = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_BUSSINESS];
    
    NSLog(@"listArrType = %@", listArrOrgType);
    
    NSLog(@"write = %@", [listArrOrgType valueForKey:DTOSYSCAT_name]);
    
    dataId = 0;
    if (self.dataSend) {
        if([self currentDeviceType]==iPhone)
        {
            self.fullNameLB.text = @"CẬP NHẬP";
        }
        else{
            self.fullNameLB.text=@"CẬP NHẬP KHÁCH HÀNG TIỀM NĂNG (DOANH NGHIỆP)";
        }
        [self loadEditData];
    }
    else{
        if([self currentDeviceType]==iPhone)
        {
            self.fullNameLB.text = @"THÊM MỚI";
        }
    }
}

//Load thong tin len form sua
-(void) loadEditData {
    
    _btnDel.hidden=NO;
    NSDictionary * getData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[self.dataSend objectForKey:DTOLEAD_id]];
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_name]]) {
        _txtName.text =[getData objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_address]]) {
        _txtAddress.text =[getData objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_mobile]]) {
        _txtPhone.text =[getData objectForKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_registrationNumber]]) {
        _txtRegisterCodeBussiness.text =[getData objectForKey:DTOLEAD_registrationNumber];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_birthday]]) {
        _txtNgayTL.text =[getData objectForKey:DTOLEAD_birthday];
    }
    
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_taxCode]]) {
        _txtTaxCode.text =[getData objectForKey:DTOLEAD_taxCode];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_fax]]) {
        _txtFax.text =[getData objectForKey:DTOLEAD_fax];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_revenue]]) {
        _txtRevenue.text =[getData objectForKey:DTOLEAD_revenue];
    }
    
    NSString *strPersonalJob = [getData objectForKey:DTOLEAD_orgTypeId];
    if (![StringUtil stringIsEmpty:strPersonalJob]) {
        NSArray *arrayPersonJobID = [listArrOrgType valueForKey:DTOSYSCAT_sysCatId];
        selectOrgTypeIdIndex = [arrayPersonJobID indexOfObject:strPersonalJob];
        if (selectOrgTypeIdIndex>=0) {
            NSDictionary *dataPersonJob = [listArrOrgType objectAtIndex:selectOrgTypeIdIndex];
            _txtSysCatType.text = [dataPersonJob objectForKey:DTOSYSCAT_name];
        }
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_profitNonTax]]) {
        _txtProfitBeforeTax.text =[getData objectForKey:DTOLEAD_profitNonTax];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_charter]]) {
        _txtCharterCapital.text =[getData objectForKey:DTOLEAD_charter];
    }
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_equityOwner]]) {
        _txtCapital.text =[getData objectForKey:DTOLEAD_equityOwner];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_employeeNumber]]) {
        _txtNumberEmployee.text =[getData objectForKey:DTOLEAD_employeeNumber];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_shareholderNumber]]) {
        _txtNumberShareholders.text =[getData objectForKey:DTOLEAD_shareholderNumber];
    }
    
    if (![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_assetTotal]]) {
        _txtTotalassets.text =[getData objectForKey:DTOLEAD_assetTotal];
    }
    if(![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_lon]]){
        _longitude =[[getData objectForKey:DTOLEAD_lon] floatValue];
    }
    if(![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_lat]]){
        _latitude=[[getData objectForKey:DTOLEAD_lat] floatValue];
    }
    if(![StringUtil stringIsEmpty:[getData objectForKey:DTOLEAD_email]]){
        _txtEmail.text=[getData objectForKey:DTOLEAD_email];
    }
}


- (void) updateInterFaceWithOption : (int) option
{
    //self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    //    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    //    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    
    
    [self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    [self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    for (UIView *viewSubTemp in self.headerMainView.subviews) {
        
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    
    //[self.btnSave setStyleNormalWithOption:smgSelect];
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
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
                
                [((UITextField*) viewSubTemp) setPaddingLeft];
                [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
                
            }
            
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            if ([self currentDeviceType]==iPad) {
                
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


#pragma mark Button Action

-(void) actionSave:(id)sender{
    //check valid to save
    if(![util checkValidToSave:_txtName :LocalizedString(@"KEY_LEAD_CN_CHECK_NAME") :self.bodyMainView]){
        return;
    }
    if(![util checkValidToSave:_txtPhone :LocalizedString(@"KEY_LEAD_CN_CHECK_MOBILE") :self.bodyMainView]){
        return;
    }
    if (_txtEmail.text.length>0) {
        if (![util validateEmail:_txtEmail.text]) {
            [util showTooltip:_txtEmail withText:@"Email không đúng định dạng" showview:self.bodyMainView];
            return;
        }
    }
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOLEAD_name];
    [dicEntity setObject:[StringUtil trimString:_txtAddress.text] forKey:DTOLEAD_address];
    [dicEntity setObject:[StringUtil trimString:_txtPhone.text]forKey:DTOLEAD_mobile];
    [dicEntity setObject:[StringUtil trimString:_txtRegisterCodeBussiness.text] forKey:DTOLEAD_registrationNumber];
    [dicEntity setObject:[StringUtil trimString:_txtTaxCode.text] forKey:DTOLEAD_taxCode];
    //[dicEntity setObject:[StringUtil trimString:_txtFax.text] forKey:DTOLEAD_fax];
    [dicEntity setObject:[StringUtil trimString:_txtEmail.text] forKey:DTOLEAD_email];
    [dicEntity setObject:[StringUtil trimString:_txtNgayTL.text]forKey:DTOLEAD_birthday];
    if(_longitude > 0){
        NSString *myLon=[NSString stringWithFormat:@"%f", _longitude];
        [dicEntity setObject:myLon forKey:DTOLEAD_lon];
    }
    if(_latitude > 0){
        NSString *myLat=[NSString stringWithFormat:@"%f",_latitude];
        [dicEntity setObject:myLat forKey:DTOLEAD_lat];
    }
    if (selectOrgTypeIdIndex>=0) {
        [dicEntity setObject:[[listArrOrgType objectAtIndex:selectOrgTypeIdIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOLEAD_orgTypeId];
    }
    [dicEntity setObject:[StringUtil trimString:_txtRevenue.text] forKey:DTOLEAD_revenue];
    [dicEntity setObject:[StringUtil trimString:_txtProfitBeforeTax.text] forKey:DTOLEAD_profitNonTax];
    [dicEntity setObject:[StringUtil trimString:_txtCharterCapital.text] forKey:DTOLEAD_charter];
    [dicEntity setObject:[StringUtil trimString:_txtCapital.text] forKey:DTOLEAD_equityOwner]; //
    //[dicEntity setObject:[StringUtil trimString:_txtNumberEmployee.text] forKey:DTOLEAD_employeeNumber];
    //[dicEntity setObject:[StringUtil trimString:_txtNumberShareholders.text] forKey:DTOLEAD_shareholderNumber];
    [dicEntity setObject:[StringUtil trimString:_txtTotalassets.text] forKey:DTOLEAD_assetTotal];
    [dicEntity setObject:@"1" forKey:DTOLEAD_leadType];
    [dicEntity setObject:@"1" forKey:DTOLEAD_status];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOLEAD_updatedDate];
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOLEAD_id] forKey:DTOLEAD_id];
    }else{
        [dicEntity setObject:IntToStr([dtoLeadProcess getClientId]) forKey:DTOLEAD_clientLeadId];
    }
    
    succsess = [dtoLeadProcess insertToDBWithEntity:dicEntity];
    if (succsess) {
        //        NSMutableArray *arrayData=[dtoLeadProcess filterTop];
        //        NSDictionary *arrayItem = [arrayData objectAtIndex:0];
        //        DetailLeadViewController *detail = [[DetailLeadViewController alloc]initWithNibName:@"DetailLeadViewController" bundle:nil];
        //        detail.dataSend=arrayItem;
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0 && alertView.tag ==1) {
        
        
    }
    if (succsess && alertView.tag == 5 && buttonIndex == 0) { //thong bao dong form
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (succsess && alertView.tag == 5 && buttonIndex == 1) {
        //reset lai form
        [self resetForm];
    }
    if (alertView.tag==6) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if(alertView.tag==11){
        if(buttonIndex==0){
            BOOL result =    [dtoLeadProcess deleteEntity:[_dataSend objectForKey:DTOLEAD_id]];
            if(result){
                //[self dismissViewControllerAnimated:YES completion:nil];
                ListAccountLeadViewController *viewControler=[[ListAccountLeadViewController alloc] initWithNibName:@"ListAccountLeadViewController" bundle:nil];
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
    selectOrgTypeIdIndex = -1;
    succsess = false;
    //
    
}
#pragma mark check valid data



#pragma mark UITextField


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    //    float height = 190;
    //    if (textField == _txtTotalassets || textField == _txtNumberShareholders) {
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
    
    
    //    float height = 190;
    //    if (textField == _txtTotalassets || textField == _txtNumberShareholders) {
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
    NSCharacterSet *numberOnly=[NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *characterSetText=[NSCharacterSet characterSetWithCharactersInString:textField.text];
    BOOL checkNumber=[numberOnly isSupersetOfSet:characterSetText];
    if (textField==_txtTaxCode) {
        if(_txtTaxCode.text.length>=20 && range.length==0){
            return  NO;
        }
        else{
            return YES;
        }
    }
    if(textField == _txtPhone){
        if(checkNumber && range.length==0){
            
            if(_txtPhone.text.length >=20 && range.length==0){
                return NO;
            }
            else{
                return YES;
            }
        }
        else{
            NSString *str=textField.text;
            _txtPhone.text=[str substringToIndex:textField.text.length-1];
            return NO;
        }
    }
    if(textField==_txtAddress){
        if(_txtAddress.text.length>=200 && range.length==0){
            return NO;
        }
        else{
            return YES;
        }
    }
    if(textField==_txtRegisterCodeBussiness){
        if(_txtRegisterCodeBussiness.text.length>=50 && range.length==0){
            return  NO;
        }
        else{
            return YES;
        }
    }
    if (textField==_txtRevenue) {
        _txtRevenue.text=[util formatCurrenc:textField :string];
        return NO;
    }
    if (textField==_txtProfitBeforeTax) {
        _txtProfitBeforeTax.text = [util formatCurrenc:textField :string];
        return  NO;
    }
    if (textField==_txtCharterCapital) {
        _txtCharterCapital.text=[util formatCurrenc:textField :string];
        return NO;
    }
    if (textField==_txtCapital) {
        _txtCapital.text=[util formatCurrenc:textField :string];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return  YES;
}// called when 'return' key pressed. return NO to ignore.



////////test other way?
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.mainView.frame = CGRectOffset(self.mainView.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    selectOrgTypeIdIndex = index;
    if (index<listArrOrgType.count) {
        NSDictionary *dic = [listArrOrgType objectAtIndex:index];
        _txtSysCatType.text = [dic objectForKey:DTOSYSCAT_name];
    }
    
}

- (IBAction)actionChoiceOrgType:(id)sender {
    if([self currentDeviceType]==iPad){
        SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
        
        detail.selectIndex = selectOrgTypeIdIndex;
        
        detail.listData = [listArrOrgType valueForKey:DTOSYSCAT_name];
        
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = _btnOrgType.frame;
        
        detail.delegate =(id<SelectIndexDelegate>) self;
        self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewExpandInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
    }
    else{
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

- (IBAction)actionChoiseAddress:(id)sender {
    
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
-(void) setLanguage{
    
    if(_dataSend.count>0){
        if ([self currentDeviceType]==iPhone) {
            _fullNameLB.text=LocalizedString(@"KEY_UPDATE");
        }
        else{
            _fullNameLB.text=LocalizedString(@"KEY_LEAD_EDIT_DN_NEW");
        }
    }
    else{
        if ([self currentDeviceType]==iPhone) {
            _fullNameLB.text=LocalizedString(@"KEY_ADDNEW");
        }
        else{
            _fullNameLB.text=LocalizedString(@"KEY_LEAD_ADD_DN_NEW");
        }
    }
    _lbthongtinchinh.text=LocalizedString(@"KEY_LEAD_ADD_NEW");
    _lbtenkhachhang.text=LocalizedString(@"KEY_LEAD_DN_NAME");
    _txtName.placeholder=LocalizedString(@"KEY_LEAD_DN_NAME");
    _lbsodienthoai.text=LocalizedString(@"KEY_LEAD_CN_MOBIE");
    _txtPhone.placeholder=LocalizedString(@"KEY_LEAD_CN_MOBIE");
    _lbmasothue.text=LocalizedString(@"KEY_LEAD_DN_THUE");
    _txtTaxCode.placeholder=LocalizedString(@"KEY_LEAD_DN_THUE");
    _lbsodkkd.text=LocalizedString(@"KEY_LEAD_DN_DKKD");
    _txtRegisterCodeBussiness.placeholder=LocalizedString(@"KEY_LEAD_DN_DKKD");
    _lbdiachi.text=LocalizedString(@"KEY_LEAD_CN_ADDRESS");
    _txtAddress.placeholder=LocalizedString(@"KEY_LEAD_CN_ADDRESS");
    _lbloahinhdn.text=LocalizedString(@"KEY_LEAD_DN_LOAI");
    _txtSysCatType.placeholder=LocalizedString(@"KEY_LEAD_DN_LOAI");
    _lbdoanhthu.text=LocalizedString(@"KEY_LEAD_DN_DOANHTHU");
    _txtRevenue.placeholder=LocalizedString(@"KEY_LEAD_DN_DOANHTHU");
    _lbloinhuantruocthue.text=LocalizedString(@"KEY_LEAD_DN_LOINHUAN");
    _txtProfitBeforeTax.placeholder=LocalizedString(@"KEY_LEAD_DN_LOINHUAN");
    _lbvondieule.text=LocalizedString(@"KEY_LEAD_DN_VONDL");
    _txtCharterCapital.placeholder=LocalizedString(@"KEY_LEAD_DN_VONDL");
    _lbvonsohuu.text=LocalizedString(@"KEY_LEAD_DN_GT_VONSH");
    _txtCapital.placeholder=LocalizedString(@"KEY_LEAD_DN_GT_VONSH");
    _lbsoluongnv.text=LocalizedString(@"KEY_LEAD_DN_GT_SL_NV");
    _txtNumberEmployee.placeholder=LocalizedString(@"KEY_LEAD_DN_GT_SL_NV");
    _lbsoluongcodong.text=LocalizedString(@"KEY_LEAD_DN_SL_CD");
    _txtNumberShareholders.placeholder=LocalizedString(@"KEY_LEAD_DN_SL_CD");
    _lbtongtaisan.text=LocalizedString(@"KEY_LEAD_CN_TOTAL_TS");
    _txtTotalassets.placeholder=LocalizedString(@"KEY_LEAD_CN_TOTAL_TS");
    _lbthongtinkhac.text=LocalizedString(@"KEY_LEAD_CN_ORTHER");
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[listArrOrgType valueForKey:DTOSYSCAT_name]  count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [[listArrOrgType valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
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
    
    NSDictionary *getData = [[listArrOrgType valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
    _txtSysCatType.text=getData;
    selectOrgTypeIdIndex=indexPath.row;
    [_txtSysCatType resignFirstResponder];
    
    NSLog(@"Item %@",dicData);
}
- (IBAction)actionNgayTL:(id)sender {
    [self hiddenKeyBoard];
    if (self.txtNgayTL.text.length==0) {
        dateBirthday = [DateUtil getDateFromString:@"01/01/2000" :FORMAT_DATE];
    }else{
        dateBirthday = [DateUtil getDateFromString:self.txtNgayTL.text :FORMAT_DATE];
    }
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateBirthday;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnNgayTL.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewExpandInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
-(void) selectDatePickerWithDate:(NSDate *)date
{
    NSLog(@"%@",date);
    
    self.txtNgayTL.text = [NSString stringWithFormat:@"%@",
                           [df stringFromDate:date]];
    dateBirthday = date;
    
}
-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
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
//For iPhone only
-(void) setSelectedDate{
    NSDate *date = datePicker.date;
    if([self.txtNgayTL isFirstResponder]){
        [self.txtNgayTL resignFirstResponder];
        self.txtNgayTL.text = [NSString stringWithFormat:@"%@",
                               [df stringFromDate:date]];
    }
    else{
        [self.txtSysCatType resignFirstResponder];
    }
}
//luonghv2 test push github
@end
