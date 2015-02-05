//
//  FlowLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/3/14.
//
//

#import "FlowLeadViewController.h"
#import "DTOSYSCATProcess.h"
#import "CalendarPickerViewController.h"
#import "DTOFLLOWUPProcess.h"
#import "Util.h"

#define FOLLOW_UP_LEAD_ITEM 44
#define TAG_SELECT_DATE_START 11

@interface FlowLeadViewController (){
    int smgSelect ; //option layout
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    BOOL isRemind, isEMail, isSMS, isHome;
    NSInteger selectPersonPositionIndex;
    NSArray *listArrPersonPosition;
    NSInteger selectMucDich;
    int SELECTED_TAG ;
    NSDate *dateStart, *dateEnd, *dateRemind;
    NSDateFormatter *df;
    DTOSYSCATProcess *dtoSyscatProcess; //NGHE NGHIEP CA NHAN
    DTOFLLOWUPProcess *dtoFollowProcess;
    NSString *catId;
    BOOL success;
    Util *util;
}

@end

@implementation FlowLeadViewController

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
    NSLog(@"dataSend:%@",self.dataSend);
    
    NSString *name= [_dataSend objectForKey:DTOLEAD_name];
    _lbTitel.text=[NSString stringWithFormat:@"THEO DÕI KHÁCH HÀNG ĐẦU MỐI - %@",name];
    dtoSyscatProcess=[DTOSYSCATProcess new];
    dtoFollowProcess=[DTOFLLOWUPProcess new];
    isRemind=NO;
    isEMail=YES;
    isSMS=NO;
    isHome=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    listArrPersonPosition = [dtoSyscatProcess filterWithCatType:FOLLOW_UP_LEAD];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    util=[Util new];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    NSString *MyString;
    NSDate *now = [NSDate date];
    dateStart=now;
    dateRemind=now;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    MyString = [dateFormatter stringFromDate:now];
    _txtNgaybatdau.text=MyString;
    int addDay=1;
    NSDate *addNew=[now dateByAddingTimeInterval:60*60*24*addDay];
    dateEnd=addNew;
    NSString *newDay;
    newDay=[dateFormatter stringFromDate:addNew];
    _txtNgayhoanthanh.text=newDay;
    _txtThoigiannhacnho.text=MyString;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateInterFaceWithOption : (int) option
{
    
    //[self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    
    [self.viewheader setBackgroundColor:HEADER_VIEW_COLOR1];
    
    [self.viewheader setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
    self.viewinfo.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    
    self.viewinfo.layer.borderWidth = BORDER_WITH;
    self.viewinfo.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in self.viewmaininfo.subviews) {
        
        for (UIView *viewSubTemp in self.viewmaininfo.subviews) {
            
            
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
            
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
                continue;
            }
            
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            if(viewTemp.tag!=10){
                [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
            }
        }
        
    }
    
}

- (IBAction)actionSave:(id)sender {
    //check validate
    if([StringUtil stringIsEmpty:_txtMucDich.text] && [StringUtil stringIsEmpty:catId]){
        
        [util showTooltip:_txtMucDich withText:@"Anh/Chị chưa chọn mục đích theo dõi" showview:_viewmaininfo];
        [util setBorder:_txtMucDich];
        return;
    }
    NSString *strClientContactId = IntToStr(([dtoFollowProcess getClientId]));
    NSMutableDictionary *dicEntity=[NSMutableDictionary new];
    [dicEntity setObject:strClientContactId forKey:DTOFOLLOWUP_clientFollowUpId];
   // [dicEntity setObject:NULL forKey:DTOFOLLOWUP_createdBy];
   // [dicEntity setObject:NULL forKey:DTOFOLLOWUP_createdDate];
    [dicEntity setObject:@"107" forKey:DTOFOLLOWUP_employeeId];
    [dicEntity setObject:[DateUtil formatDate:dateEnd :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOFOLLOWUP_endDate];
    //[dicEntity setObject:dateEnd forKey:DTOFOLLOWUP_endDate];
   // [dicEntity setObject:nil forKey:DTOFOLLOWUP_followUpId];
    [dicEntity setObject:@"1" forKey:DTOFOLLOWUP_followUpState];
    if (isEMail) {
        [dicEntity setObject:@"1" forKey:DTOFOLLOWUP_isEmail];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOFOLLOWUP_isEmail];
    }
    if(isHome){
        [dicEntity setObject:@"1" forKey:DTOFOLLOWUP_isNotify];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOFOLLOWUP_isNotify];
    }
    if (isRemind) {
        [dicEntity setObject:@"1" forKey:DTOFOLLOWUP_isReminder];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOFOLLOWUP_isReminder];
    }
    if (isSMS) {
        [dicEntity setObject:@"1" forKey:DTOFOLLOWUP_isSms];
    }
    else{
        [dicEntity setObject:@"0" forKey:DTOFOLLOWUP_isSms];
    }
    //[dicEntity setObject:dateRemind forKey:DTOFOLLOWUP_notifyDate];
    [dicEntity setObject:[DateUtil formatDate:dateRemind :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOFOLLOWUP_notifyDate];
    NSString *leadId=[_dataSend objectForKey:DTOLEAD_leadId] ;
    if (leadId.length>0) {
        [dicEntity setObject:[_dataSend objectForKey:DTOLEAD_leadId] forKey:DTOFOLLOWUP_objectId];
    }
    else{
        [dicEntity setObject:[_dataSend objectForKey:DTOLEAD_clientLeadId] forKey:DTOFOLLOWUP_objectId];
    }
    [dicEntity setObject:[_dataSend objectForKey:DTOLEAD_name] forKey:DTOFOLLOWUP_objectName];
    [dicEntity setObject:@"LEAD" forKey:DTOFOLLOWUP_objectType];
    //[dicEntity setObject:dateStart forKey:DTOFOLLOWUP_startDate];
    [dicEntity setObject:[DateUtil formatDate:dateStart :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOFOLLOWUP_startDate];
    [dicEntity setObject:catId forKey:DTOFOLLOWUP_sysCatId];
   // [dicEntity setObject:NULL forKey:DTOFOLLOWUP_updatedBy];
   // [dicEntity setObject:NULL forKey:DTOFOLLOWUP_updatedDate];
    
    success=[dtoFollowProcess insertToDBWithEntity:dicEntity];
    if (success) {
        //Thong bao cap nhat thanh cong va thoat
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Thực hiện thành công!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 5;
        [alert show];
    }
    else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Sảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
    

    
}
- (IBAction)actionCancel:(id)sender {
    
    [_delegate delegate_dismisFollow:0];
}

- (IBAction)actionRemind:(id)sender {
    
    if(!isRemind){
        [_btnCheckRemind setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
        isRemind=YES;
    }
    else {
        [_btnCheckRemind setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        isRemind=NO;
    }
}

- (IBAction)actionEmail:(id)sender {
    if (isEMail) {
        [_btnEmail setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        isEMail=NO;
    }
    else{
        [_btnEmail setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
        isEMail=YES;
    }
}

- (IBAction)actionSMS:(id)sender {
    if (!isSMS) {
        [_btnSMS setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
        isSMS=YES;
    }
    else{
        [_btnSMS setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        isSMS=NO;
    }
}

- (IBAction)actionHome:(id)sender {
    if (isHome) {
        [_btnHome setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        isHome=NO;
    }
    else{
        [_btnHome setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];
        isHome=YES;
    }
}

- (IBAction)actionChoseTimeRemind:(id)sender {
    [self hiddenKeyBoard];
    
    NSString *MyString;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.S"];
    MyString = [dateFormatter stringFromDate:now];
    
    if (self.txtThoigiannhacnho.text.length==0) {
        dateRemind = [DateUtil getDateFromString:MyString:FORMAT_DATE];
    }else{
        dateRemind = [DateUtil getDateFromString:self.txtThoigiannhacnho.text :FORMAT_DATE];
    }
    
    SELECTED_TAG = TAG_SELECT_DATE_START;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateStart;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnRemind.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewmaininfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoseDateEnd:(id)sender {
    [self hiddenKeyBoard];
    
    NSString *MyString;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *addNew=[now dateByAddingTimeInterval:60*60*24*1];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.S"];
    MyString = [dateFormatter stringFromDate:addNew];
    
    if (self.txtNgayhoanthanh.text.length==0) {
        dateEnd = [DateUtil getDateFromString:MyString:FORMAT_DATE];
    }else{
        dateEnd = [DateUtil getDateFromString:_txtNgayhoanthanh.text :FORMAT_DATE];
    }
    
    SELECTED_TAG = TAG_SELECT_DATE_START;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateEnd;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnDateEnd.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewmaininfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoseMucDic:(id)sender {
    
    //hide all key
    [self hiddenKeyBoard];
    
    SELECTED_TAG = FOLLOW_UP_LEAD_ITEM;
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectPersonPositionIndex;
    
    detail.listData = [listArrPersonPosition valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _btnChoseMucDich.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewmaininfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoseDateStart:(id)sender {
    
    [self hiddenKeyBoard];
    
    NSString *MyString;
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss.S"];
    MyString = [dateFormatter stringFromDate:now];
    
    if (self.txtNgaybatdau.text.length==0) {
        dateStart = [DateUtil getDateFromString:MyString:FORMAT_DATE];
    }else{
        dateStart = [DateUtil getDateFromString:self.txtNgaybatdau.text :FORMAT_DATE];
    }
    
    SELECTED_TAG = TAG_SELECT_DATE_START;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateStart;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnDateStart.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewmaininfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma -mark an keyboard

-(void) hiddenKeyBoard {
    for (UIView *viewTemp in _viewmaininfo.subviews) {
        for (UIView *subViewTemp in viewTemp.subviews) {
            
            if([subViewTemp isKindOfClass:[UITextField class]]){
                [(UITextField *)subViewTemp resignFirstResponder];
            }
            
            
        }
    }
}
-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    
    switch (SELECTED_TAG) {
        case FOLLOW_UP_LEAD_ITEM:
        {
            selectMucDich = index;
            if (index<listArrPersonPosition.count) {
                NSDictionary *dic = [listArrPersonPosition objectAtIndex:index];
                catId=[dic objectForKey:DTOSYSCAT_sysCatId];
                _txtMucDich.text = [dic objectForKey:DTOSYSCAT_name];
                
            }
        }
            
        default:
            break;
    }
    
}
-(void) selectDatePickerWithDate:(NSDate *)date
{
    switch (SELECTED_TAG) {
        case TAG_SELECT_DATE_START:
            self.txtNgaybatdau.text = [NSString stringWithFormat:@"%@",
                                       [df stringFromDate:date]];
            dateStart = date;
            break;
            
        default:
            break;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==5) {
        [_delegate delegate_dismisFollow:1];
    }
    else if(alertView.tag==6){
        [_delegate delegate_dismisFollow:0];
    }
}
@end
