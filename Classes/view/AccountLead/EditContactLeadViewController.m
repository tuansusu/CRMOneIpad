//
//  EditContactLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "EditContactLeadViewController.h"
#import "DTOCONTACTProcess.h"
#import "DTOACCCONTACTProcess.h"
//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"
#import "TestMapViewController.h"
#import "DTOATTACHMENTProcess.h"
#import "EnumClass.h"

#define TAG_SELECT_DATE_CREATE 1 //NGAY CAP CHUNG MINH THU
#define TAG_SELECT_DATE_BIRTHDAY 2 //NGAY SINH
#define NUMBER_ONLY @"1234567890"//SO NHAP
#define CHARACTER_MAX 15 //MAX CUA SDT
#define CHARACTER_MIN 9//MIN CUA SDT
@interface EditContactLeadViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOCONTACTProcess *dtoProcess;
    DTOATTACHMENTProcess *dtoFileProcess;
    
    NSString *fileAvartar;
    NSString *imagePath;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    Util *util;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    //thong tin chon NGAY - THANG
    int SELECTED_DATE_TAG ;
    NSDate *dateCreate, *dateBirthday;
    NSDateFormatter *df;
    
    NSInteger selectPersonJobIndex;
    NSArray *listArrPersonJob;
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectPersonPositionIndex;
    NSArray *listArrPersonPosition;
    
    BOOL succsess;//Trang thai acap nhat
    
    //key board
    float heightKeyboard;
    UITextField *_txt;
    //luu lai thong tin chon dia chi cua ban do
    float _longitude, _latitude;
    Language *obj;
}
@end

@implementation EditContactLeadViewController

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
    util=[Util new];
    obj= [Language getInstance];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj.str = [defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self setLanguage];
    if(_dataSend.count >0){
        
        _btnDelContact.hidden=NO;
    }
    if([self currentDeviceType]==iPhone)
    {
        _tvNote.layer.borderColor = [[UIColor colorWithRed:215.0 / 255.0 green:215.0 / 255.0 blue:215.0 / 255.0 alpha:1] CGColor];
        _tvNote.layer.borderWidth = 0.6f;
        _tvNote.layer.cornerRadius = 6.0f;
        
    }
    
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:FORMAT_DATE];
    
    selectPersonJobIndex = -1;
    selectPersonPositionIndex = -1;
    succsess = NO;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    dtoProcess = [DTOCONTACTProcess new];
    //    arrayData  = [NSArray new];
    //    arrayData = [dtoLeadProcess filter];
    
    dataId = 0;
    if (self.dataSend) {
        
        [self loadEdit];
    }
    
}

-(void) loadEdit{
    
    NSLog(@"data:%@", _dataSend);
    _lbTitle.text=@"CẬP NHẬP LIÊN HỆ";
    _btnDelContact.hidden=NO;
    _txtAddress.text=[_dataSend objectForKey:DTOCONTACT_address];
    _txtDateOfBirth.text=[_dataSend objectForKey:DTOCONTACT_birthday];
    _txtEmail.text=[_dataSend objectForKey:DTOCONTACT_email];
    _txtName.text=[_dataSend objectForKey:DTOCONTACT_fullName];
    _txtNumberIdentity.text=[_dataSend objectForKey:DTOCONTACT_identifiedNumber];
    _txtPhone.text=[_dataSend objectForKey:DTOCONTACT_mobile];
    _txtPosition.text=[_dataSend objectForKey:DTOCONTACT_position];
    _txtWhereBorn.text=[_dataSend objectForKey:DTOCONTACT_identifiedIssueArea];
    _txtDateCreate.text=[_dataSend objectForKey:DTOCONTACT_identifiedIssueDate];
    _tvNote.text=[_dataSend objectForKey:DTOCONTACT_roleDescription];
    NSString *avartar = [_dataSend objectForKey:DTOCONTACT_avartar];
    if (![StringUtil stringIsEmpty:avartar]) {
        _imgAvartar.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:avartar]];
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
    
    
    [self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    [self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    for (UIView *viewSubTemp in self.headerMainView.subviews) {
        
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    //[self.btnSave setStyleNormalWithOption:smgSelect];
    _btnChoicePhoto.titleLabel.textColor=[UIColor blueColor];
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
                continue;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                continue;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                continue;
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                //                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                //                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                
                [((UITextField*) viewSubTemp) setPaddingLeft];
                [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
                continue;
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
#pragma mark action button
- (IBAction)actionChoiceDateCreate:(id)sender {
    [self hiddenKeyBoard];
    if([self currentDeviceType]==iPhone)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Ngày cấp" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, 250, 200)];
        
        picker = [[UIDatePicker alloc] init];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.tag =TAG_SELECT_DATE_CREATE;
        [picker setDate:[NSDate date]];
        
        
        [picker addTarget:self action: @selector(dateChanged:) forControlEvents:UIControlEventAllEvents];
        
        [alert addSubview:picker];
        alert.tag=TAG_SELECT_DATE_CREATE;
        alert.bounds = CGRectMake(0, 0, 300 ,200);
        [alert setValue:picker forKey:@"accessoryView"];
        alert.tag=123;
        [alert show];
    }
    else{
        if (self.txtDateCreate.text.length==0) {
            dateCreate = [DateUtil getDateFromString:@"01/01/2000" :FORMAT_DATE];
        }else{
            dateCreate = [DateUtil getDateFromString:self.txtDateCreate.text :FORMAT_DATE];
        }
        
        SELECTED_DATE_TAG = TAG_SELECT_DATE_CREATE;
        CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
        detail.dateSelected = dateCreate;
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = self.btnCreateDate.frame;
        
        detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
        
        
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}
-(void) dateChanged:(id) sender{
    NSDateFormatter *birthDateFormatter;
    birthDateFormatter = [[NSDateFormatter alloc] init];
    //[birthDateFormatter setDateStyle:NSDateFormatterShortStyle];
    birthDateFormatter.dateFormat=@"dd/MM/yyyy";
    UIDatePicker *birthDatePicker = (UIDatePicker *)sender;
    NSString *date=[birthDateFormatter stringFromDate:birthDatePicker.date];
    
    if (birthDatePicker.tag==TAG_SELECT_DATE_CREATE) {
        _txtDateCreate.text=date;
    }
    else{
        _txtDateOfBirth.text=date;
    }
    
    
}
- (IBAction)actionChoiceDateBirthday:(id)sender {
    
    [self hiddenKeyBoard];
    
    if([self currentDeviceType]==iPhone)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Chọn ngày sinh" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, 250, 200)];
        
        picker = [[UIDatePicker alloc] init];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.tag =TAG_SELECT_DATE_BIRTHDAY;
        [picker setDate:[NSDate date]];
        
        
        [picker addTarget:self action: @selector(dateChanged:) forControlEvents:UIControlEventAllEvents];
        
        [alert addSubview:picker];
        alert.tag=TAG_SELECT_DATE_BIRTHDAY;
        alert.bounds = CGRectMake(0, 0, 300 ,200);
        [alert setValue:picker forKey:@"accessoryView"];
        alert.tag=123;
        [alert show];
        
    }
    else
    {
        if (self.txtDateCreate.text.length==0) {
            dateBirthday = [DateUtil getDateFromString:@"01/01/2000" :FORMAT_DATE];
        }else{
            dateBirthday = [DateUtil getDateFromString:self.txtDateOfBirth.text :FORMAT_DATE];
        }
        
        SELECTED_DATE_TAG = TAG_SELECT_DATE_BIRTHDAY;
        CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
        detail.dateSelected = dateBirthday;
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = self.btnBirthDay.frame;
        
        detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
        
        
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(void) selectDatePickerWithDate:(NSDate *)date
{
    switch (SELECTED_DATE_TAG) {
        case TAG_SELECT_DATE_BIRTHDAY:
            self.txtDateOfBirth.text = [NSString stringWithFormat:@"%@",
                                        [df stringFromDate:date]];
            dateBirthday = date;
            break;
        case TAG_SELECT_DATE_CREATE:
            self.txtDateCreate.text = [NSString stringWithFormat:@"%@",
                                       [df stringFromDate:date]];
            dateCreate = date;
            break;
            
        default:
            break;
    }
}
-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}

-(void) actionSave:(id)sender{
    //check valid to save
    if (![util checkValidToSave:_txtName :LocalizedString(@"KEY_LEAD_CN_CHECK_NAME") :self.bodyMainView]) {
        return;
    }
    if(![util checkValidToSave:_txtPhone :LocalizedString(@"KEY_LEAD_CN_CHECK_MOBILE") :self.bodyMainView]){
        return;
    }
    if(![util checkValidToSave:_txtPosition :LocalizedString(@"KEY_LEAD_CN_CHECK_POSITION") :self.bodyMainView]){
        return;
    }
    if(_txtEmail.text.length>0 && ![util validateEmail:_txtEmail.text]){
        [util showTooltip:_txtEmail withText:LocalizedString(@"KEY_LEAD_CN_CHECK_EMAIL") showview:_bodyMainView];
        [util setBorder:_txtEmail];
        return;
    }
    
    NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOCONTACT_fullName];
    [dicEntity setObject:[StringUtil trimString:_txtAddress.text] forKey:DTOCONTACT_address];
    [dicEntity setObject:[StringUtil trimString:_txtPhone.text]forKey:DTOCONTACT_mobile];
    [dicEntity setObject:[StringUtil trimString:_txtPosition.text] forKey:DTOCONTACT_position];
    [dicEntity setObject:[StringUtil trimString:_txtEmail.text] forKey:DTOLEAD_email];
    [dicEntity setObject:[StringUtil trimString:_txtDateOfBirth.text] forKey:DTOCONTACT_birthday];
    [dicEntity setObject:[StringUtil trimString:_txtNumberIdentity.text] forKey:DTOLEAD_identifiedNumber];
    [dicEntity setObject:[StringUtil trimString:_txtDateCreate.text] forKey:DTOCONTACT_identifiedIssueDate];
    [dicEntity setObject:[StringUtil trimString:_txtWhereBorn.text] forKey:DTOCONTACT_identifiedIssueArea];
    [dicEntity setValue:[StringUtil trimString:_tvNote.text] forKey:DTOCONTACT_roleDescription];
    
    
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOCONTACT_updatedDate];
    [dicEntity setObject:@"1" forKey:DTOCONTACT_isActive];
    
    //truong hop them moi file
    if(![StringUtil stringIsEmpty:fileAvartar]){
        [dicEntity setObject:imagePath forKey:DTOCONTACT_avartar];
        
    }
    
    if (self.dataSend) {
        [dicEntity setObject:[_dataSend objectForKey:DTOCONTACT_id] forKey:DTOCONTACT_id];
    }
    else{
        [dicEntity setObject:strClientContactId forKey:DTOCONTACT_clientContactId];
        [dicEntity setObject:@"1" forKey:DTOCONTACT_clientId];
    }
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    if (succsess) {
        if (_dataSend.count<=0) {
            
            
            strClientContactId = IntToStr(([dtoProcess getClientId] - 1));
            
            //cap nhat vao bang quan he
            NSMutableDictionary *dicSubEntity =  [[NSMutableDictionary alloc]init];
            
            DTOACCCONTACTProcess *dtoAccContactProcess = [DTOACCCONTACTProcess new];
            //id tu tang cua thang AccountcontactId
            NSString *strAccountContactId = IntToStr([dtoAccContactProcess getClientId]);
            //id tu tang cua thang AccountcontactId
            [dicSubEntity setObject:strAccountContactId forKey:DTOACCOUNTCONTACT_clientAccountContactId];
            //id cua thang contact vua tao
            [dicSubEntity setObject:strClientContactId forKey:DTOACCOUNTCONTACT_clientAccountId];
            
            [dicSubEntity setObject:[self.dataRoot objectForKey:DTOLEAD_clientLeadId] forKey:DTOACCOUNTCONTACT_clientLeadId];
            [dicSubEntity setObject:@"1" forKey:DTOACCOUNTCONTACT_isActive];
            
            succsess = [dtoAccContactProcess insertToDBWithEntity:dicSubEntity];
        }
        
    }
    
    
    if (succsess) {
        //Thong bao cap nhat thanh cong va thoat
        if (_dataSend.count>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_SUCCESS2") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 6;
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_SUCCESS2") delegate:self cancelButtonTitle:LocalizedString(@"KEY_NO") otherButtonTitles:LocalizedString(@"KEY_YES"), nil];
            alert.tag = 5;
            [alert show];
        }
        
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_ALERT_TITLE")  message:LocalizedString(@"KEY_ALERT_ERROR") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERT_EXIT") otherButtonTitles:nil];
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
        
        //set gia tri de them moi duoc
        self.dataSend = nil;
        
        //reset lai form
        [self resetForm];
    }
    if(buttonIndex==0 && alertView.tag==55){
        NSMutableDictionary *dicEntity = [NSMutableDictionary new];
        [dicEntity setObject:@"0" forKey:DTOCONTACT_isActive];
        [dicEntity setObject:[_dataSend objectForKey:DTOCONTACT_id] forKey:DTOCONTACT_id];
        succsess = [dtoProcess insertToDBWithEntity:dicEntity];
        if (succsess) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            //khong bao nhap loi - lien he quan tri
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_ALERT_TITLE")  message:LocalizedString(@"KEY_ALERT_ERROR") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERT_EXIT") otherButtonTitles:nil];
            alert.tag = 6;
            [alert show];
        }
    }
    if (alertView.tag==6) {
        [self dismissViewControllerAnimated:YES completion:nil];
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
    
    
    self.viewMainBodyInfo.contentSize = CGSizeMake(self.viewMainBodyInfo.frame.size.width, self.viewMainBodyInfo.frame.size.height + heightKeyboard);
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, heightKeyboard, 0.0);
    self.viewMainBodyInfo.contentInset = contentInsets;
    self.viewMainBodyInfo.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    //CGRect aRect = self.view.frame;
    CGRect aRect = CGRectMake(0, 0, 1024, 768);
    aRect.size.height -= kbSize.width;
    if (!CGRectContainsPoint(aRect, _txt.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _txt.frame.origin.y-heightKeyboard + 20);
        [self.viewMainBodyInfo setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    if(self.viewMainBodyInfo.contentSize.height>self.viewMainBodyInfo.frame.size.height){
        self.viewMainBodyInfo.contentSize = CGSizeMake(self.viewMainBodyInfo.frame.size.width, self.viewMainBodyInfo.frame.size.height - heightKeyboard);
        
        
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.viewMainBodyInfo.contentInset = contentInsets;
        self.viewMainBodyInfo.scrollIndicatorInsets = contentInsets;
    }
}


#pragma mark UITextField


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //[self hiddenKeyBoard];
    //bat dau edit
    _txt = textField;
    //[_txt becomeFirstResponder];
    [self keyboardWillBeHidden:nil];
    [self keyboardWasShown:nil];
    
    
    return  YES;
    
}// return NO to disallow editing.

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return  YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //ket thuc khong edit text do
    if (textField==_txt) {
        _txt = nil;
    }
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //check max leng
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    
    if(textField == _txtPhone )
    {
        if ([string length] == 0 && range.length > 0)
        {
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return NO;
        }
        NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
        {
            
            BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
            
            return newLength <= 20 || returnKey;
        }
        
        return NO;
        
    }
    //check ho ten
    if(textField==_txtName ){
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 50 || returnKey;
    }
    //chuc danh
    if(textField==_txtPosition ){
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 100 || returnKey;
    }
    
    //chung minh thu
    if(textField==_txtNumberIdentity ){
        if ([string length] == 0 && range.length > 0)
        {
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            return NO;
        }
        NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
        {
            
            BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
            
            return newLength <= 20 || returnKey;
        }
        
        return NO;
    }
    
    //noi cap
    if(textField==_txtWhereBorn ){
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 100 || returnKey;
        
    }
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return  YES;
}// called when 'return' key pressed. return NO to ignore.

//end keyboard

/*chon anh dai dien*/
- (IBAction)actionChoicePhoto:(id)sender {
    
    [self hiddenKeyBoard];
    if([self currentDeviceType]==iPhone)
    {
        UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Chọn avartar" delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:@"Camera" otherButtonTitles:@"Galery", nil ];
        action.tag=123;
        [action showInView:self.view];
    }
    else{
        
        [self viewWhenAddSubView];
        SelectPhotoViewController *detail = [[SelectPhotoViewController alloc] initWithNibName:@"SelectPhotoViewController" bundle:nil];
        detail.delegate =(id<SelectPhotoDelegate>) self;
        detail.typeImage = @"Lead";
        detail.index = 0;
        detail.view.frame = CGRectMake(380, 80, 320,380);
        [self addChildViewController: detail];
        [detail didMoveToParentViewController:self];
        //[InterfaceUtil setBorderWithCornerAndBorder:detail.view :10 :0.5 :nil];
        
        [UIView transitionWithView:self.view
                          duration:0.2
                           options:UIViewAnimationOptionCurveEaseIn //any animation
                        animations:^ { [self.view addSubview:detail.view];
                        }
                        completion:nil];
    }
}


- (void) viewWhenAddSubView
{
    self.mainView.alpha = 0.4;
    self.footerView.alpha = 0.4;
    self.headerViewBar.alpha = 0.4;
    
    self.headerViewBar.userInteractionEnabled = NO;
    self.mainView.userInteractionEnabled = NO;
    
    
    
    self.btnHome.enabled = NO;
    self.btnSave.enabled = NO;
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        if([viewTemp isKindOfClass:[UIButton class]])  {
            [((UIButton*) viewTemp) setEnabled:NO];
        }
        
    }
}

- (void) viewWhenRemoveSubView
{
    
    self.mainView.alpha = 1;
    self.footerView.alpha = 1;
    self.headerViewBar.alpha = 1;
    
    self.headerViewBar.userInteractionEnabled = YES;
    self.mainView.userInteractionEnabled = YES;
    
    self.mainView.alpha = 1;
    self.btnHome.enabled = YES;
    self.btnSave.enabled = YES;
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        if([viewTemp isKindOfClass:[UIButton class]])  {
            [((UIButton*) viewTemp) setEnabled:YES];
        }
        
    }
}

#pragma mark delegate photo
-(void) selectPhoto:(NSString *)fileName{
    fileAvartar = fileName;
    [self viewWhenRemoveSubView];
    [self loadimage: fileName];
    
}

-(void)loadimage : (NSString*)fileName{
    
    
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    NSLog(@"duong dan:%@",workSpacePath);
    imagePath=workSpacePath;
    self.imgAvartar.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


- (IBAction)actionSelectAddress:(id)sender {
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
    if (_dataSend.count>0) {
        [_fullNameLB setText:[LocalizedString(@"KEY_CONTACT_EDIT") uppercaseString]];
    }
    else{
        [_fullNameLB setText:[LocalizedString(@"KEY_CONTACT_ADD") uppercaseString]];
    }
    //[_btnSave setTitle:LocalizedString(@"KEY_UPDATE") forState:UIControlStateNormal];
    //[_btnDelContact setTitle:LocalizedString(@"KEY_Delete") forState:UIControlStateNormal];
    [_lbFullname setText:LocalizedString(@"KEY_CONTACT_NAME")];
    [_lbPosition setText:LocalizedString(@"KEY_CONTACT_POSITION")];
    [_lbmobile setText:LocalizedString(@"KEY_CONTACT_PHONE")];
    [_lbpassport setText:LocalizedString(@"KEY_CONTACT_CMT")];
    [_lbNgayCap setText:LocalizedString(@"KEY_CONTACT_CMT_DATE")];
    [_lbNoiSinh setText:LocalizedString(@"KEY_CONTACT_BIRTH")];
    [_lbNgaySinh setText:LocalizedString(@"KEY_CONTACT_BIRTH_DAY")];
    [_lbEmail setText:LocalizedString(@"KEY_CONTACT_EMAIL")];
    [_lbDiaChi setText:LocalizedString(@"KEY_CONTACT_ADDRESS")];
    [_lbNote setText:LocalizedString(@"KEY_CONTACT_NOTE")];
    [_btnChoicePhoto setTitle:LocalizedString(@"KEY_CONTACT_AVARTAR") forState:UIControlStateNormal];
    
}
- (IBAction)actionDel:(id)sender {
    
    //Thong bao cap nhat thanh cong va thoat
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_DEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles:LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
    alert.tag = 55;
    [alert show];
    
    
}
-(void) delegateCancel{
    //[self dismissPopoverView];
    [self viewWhenRemoveSubView];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if(buttonIndex == 1) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    self.imgAvartar.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSDateFormatter *dft = [[NSDateFormatter alloc] init];
   	[dft setDateFormat:@"yyyyMMdd_HHmmss"];
    NSDate *now = [NSDate date];
    NSString *nowStr = [dft stringFromDate:now];
    
    
    //luu file
    NSString *strFileName = [NSString stringWithFormat:@"%@_%@.jpg", @"", nowStr];    NSData* imageData = UIImageJPEGRepresentation(self.imgAvartar.image, 1.0);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    
    [imageData writeToFile:dbPath atomically:YES];
    fileAvartar = strFileName;
    imagePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:strFileName];
}
@end
