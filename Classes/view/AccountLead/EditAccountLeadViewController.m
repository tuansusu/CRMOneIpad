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

#define TAG_SELECT_PERSONAL_POSITION 1
#define TAG_SELECT_PERSONAL_JOB 2

@interface EditAccountLeadViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOSYSCATProcess *dtoSyscatProcess; //NGHE NGHIEP CA NHAN
    
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
}
@end

@implementation EditAccountLeadViewController

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
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    
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
        
        [self loadEditData];
    }
    
}

//Load thong tin len form sua
-(void) loadEditData {
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_name]]) {
        _txtName.text =[_dataSend objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_address]]) {
        _txtAddress.text =[_dataSend objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_mobile]]) {
        _txtPhone.text =[_dataSend objectForKey:DTOLEAD_mobile];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_organization]]) {
        _txtCompany.text =[_dataSend objectForKey:DTOLEAD_organization];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_email]]) {
        _txtEmail.text =[_dataSend objectForKey:DTOLEAD_email];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_identifiedNumber]]) {
        _txtNumberIdentity.text =[_dataSend objectForKey:DTOLEAD_identifiedNumber];
    }
    
 
    NSString *strPersonalJob = [_dataSend objectForKey:DTOLEAD_personalJob];
    if (![StringUtil stringIsEmpty:strPersonalJob]) {
        NSArray *arrayPersonJobID = [listArrPersonJob valueForKey:DTOSYSCAT_sysCatId];
        selectPersonJobIndex = [arrayPersonJobID indexOfObject:strPersonalJob];
        if (selectPersonJobIndex>=0) {
            NSDictionary *dataPersonJob = [listArrPersonJob objectAtIndex:selectPersonJobIndex];
            _txtJob.text = [dataPersonJob objectForKey:DTOSYSCAT_name];
        }
    }
    
    NSString *strPersonalPosition = [_dataSend objectForKey:DTOLEAD_personalPosition];
    if (![StringUtil stringIsEmpty:strPersonalPosition]) {
        NSArray *arrayPersonJobID = [listArrPersonPosition valueForKey:DTOSYSCAT_sysCatId];
        selectPersonPositionIndex = [arrayPersonJobID indexOfObject:strPersonalPosition];
        if (selectPersonPositionIndex>=0) {
            NSDictionary *dataPersonJob = [listArrPersonPosition objectAtIndex:selectPersonPositionIndex];
            _txtPersonPosition.text = [dataPersonJob objectForKey:DTOSYSCAT_name];
        }
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_sex]]) {
        if ([[_dataSend objectForKey:DTOLEAD_sex] isEqualToString:@"Nữ"]) {
            _segSex.selectedSegmentIndex = 1;
        }
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_marialStatus]]) {
        if ([[_dataSend objectForKey:DTOLEAD_marialStatus] isEqualToString:@"1"]) {
            _segMarialStatus.selectedSegmentIndex = 1;
        }
    }
    

    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_monthlyIncome]]) {
        _txtMonthlyIncom.text =[_dataSend objectForKey:DTOLEAD_monthlyIncome];
    }
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOLEAD_assetTotal]]) {
        _txtTotalassets.text =[_dataSend objectForKey:DTOLEAD_assetTotal];
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
                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
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


-(void) actionSave:(id)sender{
    //check valid to save
    
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOLEAD_name];
    [dicEntity setObject:[StringUtil trimString:_txtAddress.text] forKey:DTOLEAD_address];
    [dicEntity setObject:[StringUtil trimString:_txtPhone.text]forKey:DTOLEAD_mobile];
    [dicEntity setObject:[StringUtil trimString:_txtCompany.text] forKey:DTOLEAD_organization];
    [dicEntity setObject:[StringUtil trimString:_txtEmail.text] forKey:DTOLEAD_email];
    
    [dicEntity setObject:[StringUtil trimString:_txtNumberIdentity.text] forKey:DTOLEAD_identifiedNumber];
    
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
    }
    succsess = [dtoLeadProcess insertToDBWithEntity:dicEntity];
    
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
            [(UITextField *)subViewTemp resignFirstResponder];
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

#pragma mark check valid data


#pragma mark UITextField


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    float height = 190;
    if (textField == _txtTotalassets || textField == _txtAddress) {
        height = 230;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    
    CGRect frame = self.mainView.frame;
    frame.origin.y = frame.origin.y - height;
    [self.mainView setFrame:frame];
    
    [UIView commitAnimations];
    
    return  YES;
    
}// return NO to disallow editing.

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return  YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    float height = 190;
    if (textField == _txtTotalassets || textField == _txtAddress) {
        height = 230;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    CGRect frame = self.mainView.frame;
    frame.origin.y = frame.origin.y + height;
    [self.mainView setFrame:frame];
    
    [UIView commitAnimations];
    
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
@end
