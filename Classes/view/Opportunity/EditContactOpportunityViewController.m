//
//  EditContactLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "EditContactOpportunityViewController.h"
#import "DTOCONTACTProcess.h"
#import "DTOOPPORTUNITYCONTACTProcess.h"
//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"
#import "DTOATTACHMENTProcess.h"

#define TAG_SELECT_DATE_CREATE 1 //NGAY CAP CHUNG MINH THU
#define TAG_SELECT_DATE_BIRTHDAY 2 //NGAY SINH
#define NUMBER_ONLY @"1234567890"//SO NHAP
#define CHARACTER_MAX 15 //MAX CUA SDT
#define CHARACTER_MIN 9//MIN CUA SDT
@interface EditContactOpportunityViewController ()
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

@implementation EditContactOpportunityViewController

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
        if(self.currentDeviceType == iPad){
            [UIDevice updateLayoutInIOs7OrAfter:self];
        }
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self setLanguage];
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
        
        self.fullNameLB.text = LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_HEADER_EDIT");
    }else{
        self.fullNameLB.text = LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_HEADER_ADD");
    }
    
    if(self.currentDeviceType == iPhone){
        self.fullNameLB.text = @"";
    }
    
}

-(void) loadEdit{
    
    NSLog(@"data:%@", _dataSend);
    _lbTitle.text=LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_HEADER_EDIT");

    NSString *avartar = [dicData objectForKey:DTOCONTACT_avartar];
    if (![StringUtil stringIsEmpty:avartar]) {
        self.imgAvartar.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:avartar]];
    }
    
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
        
        if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewSubTemp) setAlpha:1.0f];
        }
    }
    
    for (UIView *viewSubTemp in self.viewMainBodyInfo.subviews) {
        
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
        
        if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewSubTemp) setAlpha:1.0f];
        }
    }

    
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            
            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                if(viewSubTemp.tag == 505){
                    ((UILabel*) viewSubTemp).textColor = [UIColor redColor];
                    
                }else{
                    ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                }
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
    
    //For iPhone only
    if(self.currentDeviceType == iPhone){
        [self.viewMainBodyInfo setScrollEnabled:YES];
        [self.viewMainBodyInfo setContentSize:CGSizeMake(self.view.frame.size.width, self.tvNote.frame.origin.y + self.tvNote.frame.size.height + 100)];
        [self.viewMainBodyInfo setFrame:CGRectMake(self.viewMainBodyInfo.frame.origin.x, self.viewMainBodyInfo.frame.origin.y, self.viewMainBodyInfo.frame.size.width, self.viewMainBodyInfo.frame.size.height - self.headerViewBar.frame.size.height) ];
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
    if (![self checkValidToSave]) {
        return;
    }
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
    
    
    [dicEntity setObject:@"1" forKey:DTOCONTACT_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOCONTACT_updatedDate];
    
    [dicEntity setObject:@"1" forKey:DTOCONTACT_clientId];
    
    //truong hop them moi file
    if(![StringUtil stringIsEmpty:fileAvartar]){
        [dicEntity setObject:imagePath forKey:DTOCONTACT_avartar];
        
    }
    NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
    
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOCONTACT_id] forKey:DTOCONTACT_id];
    }else{
        [dicEntity setObject:strClientContactId forKey:DTOCONTACT_clientContactId];
    }
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    if (succsess && !self.dataSend) {
        
        strClientContactId = IntToStr(([dtoProcess getClientId] - 1));
        
        //cap nhat vao bang quan he
        NSMutableDictionary *dicSubEntity =  [[NSMutableDictionary alloc]init];
        
        DTOOPPORTUNITYCONTACTProcess  *dtoOpportunityContactProcess = [DTOOPPORTUNITYCONTACTProcess new];
        //id tu tang cua thang OpportunityContactId
        
        
        NSString *strOpportunityContactId = IntToStr([dtoOpportunityContactProcess getClientId]);
        //id tu tang cua thang OpportunityContactId
        [dicSubEntity setObject:strOpportunityContactId forKey:DTOOPPORTUNITYCONTACT_clientOpportunityContactId];
        [dicSubEntity setObject:@"0" forKey:@"updatedBy"];
        //id cua thang contact vua tao
        [dicSubEntity setObject:strClientContactId forKey:DTOCONTACT_clientContactId];
        
        [dicSubEntity setObject:[self.dataRoot objectForKey:DTOOPPORTUNITY_clientOpportunityId] forKey:DTOOPPORTUNITY_clientOpportunityId];
        [dicSubEntity setObject:[self.dataRoot objectForKey:DTOOPPORTUNITY_clientOpportunityId] forKey:DTOOPPORTUNITYCONTACT_opportunityId];
        [dicSubEntity setObject:@"1" forKey:DTOACCOUNTCONTACT_isActive];
        
        succsess = [dtoOpportunityContactProcess insertToDBWithEntity:dicSubEntity];
        
    }
    
    
    if (succsess) {
        //Thong bao cap nhat thanh cong va thoat
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_ALERT_TITLE") message:LocalizedString(@"KEY_ALERT_SUCCESS2") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERT_NO") otherButtonTitles:LocalizedString(@"KEY_ALERT_YES"), nil];
        alert.tag = 5;
        [alert show];
        
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_ALERT_TITLE") message:LocalizedString(@"KEY_ALERT_ERROR") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERT_EXIT") otherButtonTitles:nil];
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
    
    if(self.currentDeviceType == iPad){
        
        
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
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:LocalizedString(@"KEY_CANCEL")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_CHOOSE_PHOTO"),@"Camera", nil];
        [actionSheet showInView:self.view];
        
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


#pragma mark check
-(BOOL) checkValidToSave {
    BOOL isValidate = YES;
    if ([StringUtil trimString: self.txtName.text].length==0) {
        [self showTooltip:self.txtName withText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_ERR_BLANK_NAME")];
        
        [self.txtName  becomeFirstResponder];
        [self setBorder:self.txtName];
        isValidate = NO;
        return isValidate;
    }
    if([StringUtil trimString:self.txtPosition.text].length==0){
        
        [self showTooltip:self.txtPosition  withText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_ERR_BLANK_POSITION")];
        [self.txtPosition becomeFirstResponder];
        [self setBorder:self.txtPosition];
        isValidate=NO;
        return isValidate;
    }
    if([StringUtil trimString:self.txtPhone.text].length==0){
        
        [self showTooltip:self.txtPhone  withText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_ERR_BLANK_PHONE")];
        [self.txtPhone becomeFirstResponder];
        [self setBorder:self.txtPhone];
        isValidate=NO;
        return isValidate;
    }
    
    if(self.txtEmail.text.length > 0 && [self validateEmail:self.txtEmail.text]==NO)
    {
        [self showTooltip:self.txtEmail withText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_ERR_EMAIL_NOT_VALID")];
        [self.txtEmail becomeFirstResponder];
        [self setBorder:self.txtEmail];
        isValidate=NO;
        return isValidate;
    }
    
    if(self.txtName.text.length > 200){
        [self showTooltip:self.txtName withText:LocalizedString(@"KEY_VALIDATE_LENGTH_200_ERROR")];
        [self.txtName becomeFirstResponder];
        [self setBorder:self.txtName];
        
        return NO;
    }
    
    if(self.txtPosition.text.length > 200){
        [self showTooltip:self.txtPosition withText:LocalizedString(@"KEY_VALIDATE_LENGTH_200_ERROR")];
        [self.txtPosition becomeFirstResponder];
        [self setBorder:self.txtPosition];
        
        return NO;
    }
    
    if(self.txtPhone.text.length > 20 || self.txtPhone.text.length < 10){
        [self showTooltip:self.txtPhone withText:LocalizedString(@"MAXLENG_PHONE")];
        [self.txtPhone becomeFirstResponder];
        [self setBorder:self.txtPhone];
        
        return NO;
    }
    
    if(self.txtNumberIdentity.text.length > 200){
        [self showTooltip:self.txtNumberIdentity withText:LocalizedString(@"KEY_VALIDATE_LENGTH_200_ERROR")];
        [self.txtNumberIdentity becomeFirstResponder];
        [self setBorder:self.txtNumberIdentity];
        
        return NO;
    }
    
    if(self.txtWhereBorn.text.length > 200){
        [self showTooltip:self.txtWhereBorn withText:LocalizedString(@"KEY_VALIDATE_LENGTH_200_ERROR")];
        [self.txtWhereBorn becomeFirstResponder];
        [self setBorder:self.txtWhereBorn];
        
        return NO;
    }
    
    
    if(self.txtAddress.text.length > 200){
        [self showTooltip:self.txtAddress withText:LocalizedString(@"KEY_VALIDATE_LENGTH_200_ERROR")];
        [self.txtAddress becomeFirstResponder];
        [self setBorder:self.txtAddress];
        
        return NO;
    }
    
    if(self.tvNote.text.length > 2000){
        [self showTooltip:self.tvNote withText:LocalizedString(@"KEY_VALIDATE_LENGTH_2000_ERROR")];
        [self.tvNote becomeFirstResponder];
        [self setBorder:self.tvNote];
        
        return NO;
    }
    
    
    return isValidate;
}


#pragma mark tooltip

-(void) showTooltip : (UIView*) inputTooltipView withText : (NSString*) inputMessage {
    
    [self dismissAllPopTipViews];
    
    
    NSString *contentMessage = inputMessage;
    //UIView *contentView = inputTooltipView;
    
    UIColor *backgroundColor = [UIColor redColor];
    
    UIColor *textColor = [UIColor whiteColor];
    
    //NSString *title = inputMessage;
    
    CMPopTipView *popTipView;
    
    
    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
    
    popTipView.delegate = self;
    
    /* Some options to try.
     */
    //popTipView.disableTapToDismiss = YES;
    //popTipView.preferredPointDirection = PointDirectionUp;
    //popTipView.hasGradientBackground = NO;
    //popTipView.cornerRadius = 2.0;
    //popTipView.sidePadding = 30.0f;
    //popTipView.topMargin = 20.0f;
    //popTipView.pointerSize = 50.0f;
    //popTipView.hasShadow = NO;
    
    popTipView.preferredPointDirection = PointDirectionDown;
    popTipView.hasShadow = NO;
    
    if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
        popTipView.backgroundColor = backgroundColor;
    }
    if (textColor && ![textColor isEqual:[NSNull null]]) {
        popTipView.textColor = textColor;
    }
    
    popTipView.animation = arc4random() % 2;
    popTipView.has3DStyle = (BOOL)(arc4random() % 2);
    
    popTipView.dismissTapAnywhere = YES;
    [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
    
    
    [popTipView presentPointingAtView:inputTooltipView inView:self.viewMainBodyInfo animated:YES];
    
    
    [self.visiblePopTipViews addObject:popTipView];
    self.currentPopTipViewTarget = inputTooltipView;
    
    
    
}

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}
#pragma mark - Phan chon anh tren iphone
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if(buttonIndex == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    self.imgAvartar.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"yyyyMMdd_HHmmss"];
    NSDate *now = [NSDate date];
    NSString *nowStr = [df stringFromDate:now];

    
    //luu file
    NSString *strFileName = [NSString stringWithFormat:@"%@_%@.jpg", @"", nowStr];    NSData* imageData = UIImageJPEGRepresentation(self.imgAvartar.image, 1.0);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:strFileName];

    
    [imageData writeToFile:dbPath atomically:YES];
    fileAvartar = strFileName;
    imagePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:strFileName];
}
#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}
#pragma mark -check email
-(BOOL) validateEmail:(NSString *)email{
    
    NSString *emailRegex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailtext=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailtext evaluateWithObject:email];
}
#pragma mark-set border text
-(void)setBorder:(UITextField *)txtView{
    
    txtView .layer.cornerRadius=1.0f;
    txtView.layer.masksToBounds=YES;
    txtView.layer.borderColor=[[UIColor redColor]CGColor ];
    txtView.layer.borderWidth=1.0f;
    [txtView becomeFirstResponder];
}

#pragma mark - Phần đa ngôn ngữu
-(void) setLanguage{
    [_btnChoicePhoto setTitle:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_CHOOSE_PHOTO") forState:UIControlStateNormal];
    [_lblName setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_NAME")];
    [_txtName setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_NAME")];
    [_lblPhone setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_PHONE")];
    [_txtPhone setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_PHONE")];
    [_lblIdentityNumber setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_IDENTITYNUMBER")];
    [_txtNumberIdentity setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_IDENTITYNUMBER")];
    [_lblWhereBorn setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_WHERE_BORN")];
    [_txtWhereBorn setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_WHERE_BORN")];
    [_lblEmail setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_EMAIL")];
    [_txtEmail setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_EMAIL")];
    [_lblNote setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_NOTE")];
    [_lblPositioin setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_POSITION")];
    [_lblCreateDate setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_DATE_CREATE")];
    [_txtDateCreate setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_DATE_CREATE")];
    [_lblBirthday setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_BIRTHDAY")];
    [_txtDateOfBirth setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_BIRTHDAY")];
    [_lblLocation setText:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_ADDRESS")];
    [_txtAddress setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_CONTACT_EDIT_ADDRESS")];
    if(self.currentDeviceType == iPad){
        //[_btnSave setTitle:LocalizedString(@"KEY_UPDATE") forState:UIControlStateNormal];
        [_btnSave setTitle:@"" forState:UIControlStateNormal];
    }else{
        [_btnSave setTitle:LocalizedString(@"KEY_SAVE") forState:UIControlStateNormal];
    }
}
@end
