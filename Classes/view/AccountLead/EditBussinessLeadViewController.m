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
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
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
        self.fullNameLB.text=@"CẬP NHẬP KHÁCH HÀNG TIỀM NĂNG (DOANH NGHIỆP)";
        [self loadEditData];
    }
    
}

//Load thong tin len form sua
-(void) loadEditData {
    
    NSLog(@"dataSend:%@",_dataSend);
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_name]]) {
        _txtName.text =[_dataSend objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_address]]) {
        _txtAddress.text =[_dataSend objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_mobile]]) {
        _txtPhone.text =[_dataSend objectForKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_registrationNumber]]) {
        _txtRegisterCodeBussiness.text =[_dataSend objectForKey:DTOLEAD_registrationNumber];
    }
    

    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_taxCode]]) {
        _txtTaxCode.text =[_dataSend objectForKey:DTOLEAD_taxCode];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_fax]]) {
        _txtFax.text =[_dataSend objectForKey:DTOLEAD_fax];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_revenue]]) {
        _txtRevenue.text =[_dataSend objectForKey:DTOLEAD_revenue];
    }
    
    NSString *strPersonalJob = [_dataSend objectForKey:DTOLEAD_orgTypeId];
    if (![StringUtil stringIsEmpty:strPersonalJob]) {
        NSArray *arrayPersonJobID = [listArrOrgType valueForKey:DTOSYSCAT_sysCatId];
        selectOrgTypeIdIndex = [arrayPersonJobID indexOfObject:strPersonalJob];
        if (selectOrgTypeIdIndex>=0) {
            NSDictionary *dataPersonJob = [listArrOrgType objectAtIndex:selectOrgTypeIdIndex];
            _txtSysCatType.text = [dataPersonJob objectForKey:DTOSYSCAT_name];
        }
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_profitNonTax]]) {
        _txtProfitBeforeTax.text =[_dataSend objectForKey:DTOLEAD_profitNonTax];
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_charter]]) {
        _txtCharterCapital.text =[_dataSend objectForKey:DTOLEAD_charter];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_equityOwner]]) {
        _txtCapital.text =[_dataSend objectForKey:DTOLEAD_equityOwner];
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_employeeNumber]]) {
        _txtNumberEmployee.text =[_dataSend objectForKey:DTOLEAD_employeeNumber];
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_shareholderNumber]]) {
        _txtNumberShareholders.text =[_dataSend objectForKey:DTOLEAD_shareholderNumber];
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_assetTotal]]) {
        _txtTotalassets.text =[_dataSend objectForKey:DTOLEAD_assetTotal];
    }
    if(![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_lon]]){
        _longitude =[[_dataSend objectForKey:DTOLEAD_lon] floatValue];
    }
    if(![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_lat]]){
        _latitude=[[_dataSend objectForKey:DTOLEAD_lat] floatValue];
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
    
    
    [self.btnSave setStyleNormalWithOption:smgSelect];
    
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
            
            [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
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
    if(![util checkValidToSave:_txtName :@"Anh/Chị chưa nhập tên khách hàng" :self.bodyMainView]){
        return;
    }
    if(![util checkValidToSave:_txtPhone :@"Anh/Chị chưa nhập số điện thoại khách hàng" :self.bodyMainView]){
        return;
    }
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOLEAD_name];
    [dicEntity setObject:[StringUtil trimString:_txtAddress.text] forKey:DTOLEAD_address];
    [dicEntity setObject:[StringUtil trimString:_txtPhone.text]forKey:DTOLEAD_mobile];
    [dicEntity setObject:[StringUtil trimString:_txtRegisterCodeBussiness.text] forKey:DTOLEAD_registrationNumber];
    [dicEntity setObject:[StringUtil trimString:_txtTaxCode.text] forKey:DTOLEAD_taxCode];
    [dicEntity setObject:[StringUtil trimString:_txtFax.text] forKey:DTOLEAD_fax];
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
    [dicEntity setObject:[StringUtil trimString:_txtNumberEmployee.text] forKey:DTOLEAD_employeeNumber];
    [dicEntity setObject:[StringUtil trimString:_txtNumberShareholders.text] forKey:DTOLEAD_shareholderNumber];
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
        //Thong bao cap nhat thanh cong va thoat
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
        alert.tag = 5;
        [alert show];
        
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
    
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
        heightKeyboard = kbSize.width;
    }
    
    
    self.bodyMainView.contentSize = CGSizeMake(self.bodyMainView.frame.size.width, self.bodyMainView.frame.size.height + heightKeyboard);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, heightKeyboard, 0.0);
    self.bodyMainView.contentInset = contentInsets;
    self.bodyMainView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    //CGRect aRect = self.view.frame;
    CGRect aRect = CGRectMake(0, 0, 1024, 768);
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
@end
