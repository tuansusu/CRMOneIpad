//
//  EditContactLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "EditContact360ViewController.h"
#import "DTOCONTACTProcess.h"
#import "DTOACCCONTACTProcess.h"
//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"
#import "DTOATTACHMENTProcess.h"
#import "Util.h"
#import "TestMapViewController.h"

#define TAG_SELECT_DATE_CREATE 1 //NGAY CAP CHUNG MINH THU
#define TAG_SELECT_DATE_BIRTHDAY 2 //NGAY SINH
#define NUMBER_ONLY @"1234567890"//SO NHAP
#define CHARACTER_MAX 15 //MAX CUA SDT
#define CHARACTER_MIN 9//MIN CUA SDT
@interface EditContact360ViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOCONTACTProcess *dtoProcess;
    DTOATTACHMENTProcess *dtoFileProcess;
    Util*util;
    NSString *fileAvartar;
    NSString *imagePath;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
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
}
@end

@implementation EditContact360ViewController

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
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    util=[Util new];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
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
    
    
    [self.btnSave setStyleNormalWithOption:smgSelect];
    
    for (UIView *viewSubTemp in self.headerMainView.subviews) {
        
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            
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
                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                [((UITextField*) viewSubTemp) setPaddingLeft];
                continue;
                
                
            }
            
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
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

- (IBAction)actionChoiceDateBirthday:(id)sender {
    
    [self hiddenKeyBoard];
    
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
    if (![util checkValidToSave:_txtName :@"Anh/Chị chưa nhập tên liên hệ" :self.bodyMainView]) {
        return;
    }
    if(![util checkValidToSave:_txtPhone :@"Anh/Chị chưa nhập số điện thoại liên hệ" :self.bodyMainView]){
        return;
    }
    if(![util checkValidToSave:_txtPosition :@"Anh/Chị chưa nhập chức danh liên hệ" :self.bodyMainView]){
        return;
    }
    if(_txtEmail.text.length>0 && ![util validateEmail:_txtEmail.text]){
        [util showTooltip:_txtEmail withText:@"Email không đúng định dạng" showview:_bodyMainView];
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
            
            [dicSubEntity setObject:[self.dataRoot objectForKey:DTOACCOUNT_clientAccountId] forKey:DTOACCOUNTCONTACT_clientLeadId];
            [dicSubEntity setObject:@"1" forKey:DTOACCOUNTCONTACT_isActive];
            
            succsess = [dtoAccContactProcess insertToDBWithEntity:dicSubEntity];
        }
        
    }
    if (succsess) {
        //Thong bao cap nhat thanh cong va thoat
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
        alert.tag = 5;
        [alert show];
        
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Sảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
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
        CGPoint scrollPoint = CGPointMake(0.0, _txt.frame.origin.y-heightKeyboard);
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
    
    
    _txt = textField;
    
//    [self keyboardWillBeHidden:nil];
//    [self keyboardWasShown:nil];
    
    
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
    NSLog(@"text thay doi");
    if(textField==self.txtPhone){
        NSLog(@"text phone thay doi");
        NSNumberFormatter *nf=[[NSNumberFormatter alloc]init];
        [nf setNumberStyle:NSNumberFormatterNoStyle];
        NSString *newString =[NSString stringWithFormat:@"%@%@",textField.text,string];
        NSNumber *number =[nf numberFromString:newString];
        if(number){
            return YES;
        }
        else{
            return  NO;
        }
    }
    else{
        NSLog(@"khong phai text phone");
        return YES;
    }
    
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
    
    [self viewWhenAddSubView];
    SelectPhotoViewController *detail = [[SelectPhotoViewController alloc] initWithNibName:@"SelectPhotoViewController" bundle:nil];
    detail.delegate = self;
    detail.typeImage = @"Lead";
    detail.index = 0;
    detail.view.frame = CGRectMake(380, 80, 320,480);
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
    
    
   // _longitude = addressObj.coordinate.longitude;
   // _latitude = addressObj.coordinate.latitude;
    
    
    
    if (addressObj.lines.count>0) {
        self.txtAddress.text =[addressObj.lines objectAtIndex:0];
    }
    
}
@end
