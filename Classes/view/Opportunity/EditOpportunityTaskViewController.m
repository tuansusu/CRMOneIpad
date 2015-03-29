//
//  EditOpportunityTaskViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/26/14.
//
//

#import "EditOpportunityTaskViewController.h"
#import "DTOTASKProcess.h"
#import "DTOSYSCATProcess.H"
//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"

#define TAG_SELECT_DATE_FROM 1 //NGAY BAT DAU
#define TAG_SELECT_DATE_TO 2 //NGAY KET THUC
#define TAG_SELECT_TIME_FROM 3 //THOI GIAN BAT DAU
#define TAG_SELECT_TIME_TO 4 //THOI GIAN KET THUC

#define TAG_SELECT_STATUS 5 //TRANG THAI

@interface EditOpportunityTaskViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOTASKProcess *dtoProcess;
    DTOSYSCATProcess *dtoSyscatProcess;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    //thong tin chon NGAY - THANG
    int SELECTED_DATE_TAG ;
    NSDate *dateFrom, *dateTo;
    NSDate *timeFrom, *timeTo;
    NSDateFormatter *df,*dfTime;
    
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectStatusIndex;
    NSArray *listArrStatus;
    
    BOOL succsess;//Trang thai acap nhat
}
@end

@implementation EditOpportunityTaskViewController

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
    
    //for iphone only
    if(self.currentDeviceType == iPhone){
        
        //Phan chon ngay
        self.datePicker = [[UIDatePicker alloc] init];
        
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self.txtDateFrom setInputView:self.datePicker];
        [self.txtDateTo setInputView:self.datePicker];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolBar setTintColor:[UIColor blackColor]];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(setSelectedDate)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [self.txtDateFrom setInputAccessoryView:toolBar];
        [self.txtDateTo setInputAccessoryView:toolBar];
        
        
        //Phan chon gio
        self.timePicker = [[UIDatePicker alloc] init];
        
        self.timePicker.datePickerMode = UIDatePickerModeTime;
        [self.txtTimeFrom setInputView:self.timePicker];
        [self.txtTimeTo setInputView:self.timePicker];
        
        UIToolbar *toolBar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolBar2 setTintColor:[UIColor blackColor]];
        UIBarButtonItem *doneBtn2 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(setSelectedTime)];
        UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [toolBar2 setItems:[NSArray arrayWithObjects:space2,doneBtn2, nil]];
        [self.txtTimeFrom setInputAccessoryView:toolBar2];
        [self.txtTimeTo setInputAccessoryView:toolBar2];
    }

}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:FORMAT_DATE];
    
    dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:FORMAT_TIME];
    
    selectStatusIndex = -1;
    succsess = NO;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    dtoProcess = [DTOTASKProcess new];
    dtoSyscatProcess = [DTOSYSCATProcess new];
    
    listArrStatus = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_TASK_STATUS];
    
    dataId = 0;
    if(self.currentDeviceType == iPad){
        if (self.dataSend) {
            [self loadEdit];
            self.fullNameLB.text = LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_HEADER_EDIT");
        }else{
            self.fullNameLB.text = LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_HEADER_ADD");
        }
    }else{
        if (self.dataSend) {
            [self loadEdit];
        }
        
        self.fullNameLB.text = @"";
        

    }
    
}

-(void) loadEdit{
    
    NSLog(@"send:%@",_dataSend);
    

    if (_dataSend) {
        _txtName.text=[_dataSend objectForKey:DTOTASK_title];
        if ([[_dataSend objectForKey:DTOTASK_taskStatus] isEqualToString:@"3244"]) {
            _txtStatus.text =@"Đang thực hiện";
            selectStatusIndex=0;
        }
        else{
            _txtStatus.text=@"Đã hoàn thành";
            selectStatusIndex=1;
        }
        NSString *strDateStart=[_dataSend objectForKey:DTOTASK_startDate];
        NSString *strDateEnd=[_dataSend objectForKey:DTOTASK_endDate];


        NSDateFormatter *dateFromStringFormatS=[[NSDateFormatter alloc]init];
        [dateFromStringFormatS setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
        NSDateFormatter *dateEndFormatS=[[NSDateFormatter alloc]init];
        [dateEndFormatS setDateFormat:@"dd/MM/yyyy"];
        NSDate *start=[dateFromStringFormatS dateFromString:strDateStart];
        _txtDateFrom.text=[dateEndFormatS stringFromDate:start ];
        dateFrom = start;
        timeFrom = start;

        NSDateFormatter *timeEndFormatS=[[NSDateFormatter alloc]init];
        [timeEndFormatS setDateFormat:@"HH:mm"];
        _txtTimeFrom.text=[timeEndFormatS stringFromDate:start];


        NSDateFormatter *dateFromStringFormat=[[NSDateFormatter alloc]init];
        [dateFromStringFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];

        NSDateFormatter *dateEndFormat=[[NSDateFormatter alloc]init];
        [dateEndFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *end=[dateFromStringFormat dateFromString:strDateEnd];
        _txtDateTo.text=[dateEndFormat stringFromDate:end ];
        dateTo = end;
        timeTo = end;

        NSDateFormatter *timeEndFormat=[[NSDateFormatter alloc]init];
        [timeEndFormat setDateFormat:@"HH:mm"];
        _txtTimeTo.text=[timeEndFormat stringFromDate:end];
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
    
    [self.btnSave setStyleNormalWithOption:smgSelect];
    
    
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

                
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                    
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
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

- (IBAction)actionChoiceStatus:(id)sender {
    [self hiddenKeyBoard];
    
    if(self.currentDeviceType == iPad){
        SELECTED_DATE_TAG = TAG_SELECT_STATUS;
        
        SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
        
        detail.selectIndex = selectStatusIndex;
        
        detail.listData = [listArrStatus valueForKey:DTOSYSCAT_name];
        
        self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
        CGRect popoverFrame = self.btnChoiceStatus.frame;
        
        detail.delegate =(id<SelectIndexDelegate>) self;
        self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
        [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
        [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_STATUS")
                                                                 delegate:self
                                                        cancelButtonTitle:LocalizedString(@"KEY_CANCEL")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
        
        NSArray *lsStatus = [listArrStatus valueForKey:DTOSYSCAT_name];
        
        for(NSString *title in lsStatus){
            [actionSheet addButtonWithTitle:title];
        }
        [actionSheet showInView:self.view];

    }
    
}

- (IBAction)actionChoiceDateFrom:(id)sender {
    [self hiddenKeyBoard];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:1]]; // I'm in Paris (+1)
    NSDateComponents *comps = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    comps.hour = -7; //WTF
    comps.minute = 0;
    comps.second = 0;
    
    NSDate *newDate = [cal dateFromComponents:comps ];
    
    if (self.txtDateFrom.text.length==0) {
        dateFrom = newDate; //[NSDate date];
    }else{
        dateFrom = [DateUtil getDateFromString:self.txtDateFrom.text :FORMAT_DATE];
    }
    
    SELECTED_DATE_TAG = TAG_SELECT_DATE_FROM;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateFrom;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnChoiceDateFrom.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChocieTimeFrom:(id)sender {
    
    [self hiddenKeyBoard];
    
    if (self.txtTimeFrom.text.length==0) {
        //        self.txtStartDateTime.text = nowTimeStr;
        //        startDate = [NSDate date];
    }else{
        NSString *strEndDate = [NSString stringWithFormat:@"%@ %@",self.txtDateFrom.text,self.txtTimeFrom.text];
        timeFrom = [DateUtil getDateFromString:strEndDate :@"dd/MM/yyyy HH:mm"];
    }
    
    SELECTED_DATE_TAG = TAG_SELECT_TIME_FROM;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = timeFrom;
    detail.isTimeMode = true;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.txtTimeFrom.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceDateTo:(id)sender {
    [self hiddenKeyBoard];
    
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:1]]; // I'm in Paris (+1)
    NSDateComponents *comps = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    comps.hour = -7; 
    comps.minute = 0;
    comps.second = 0;
    
    NSDate *newDate = [cal dateFromComponents:comps ];
    
    if (self.txtDateTo.text.length==0) {
        dateTo =  newDate;//[NSDate date];
    }else{
        dateTo = [DateUtil getDateFromString:self.txtDateTo.text :FORMAT_DATE];
    }
    
    SELECTED_DATE_TAG = TAG_SELECT_DATE_TO;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateTo;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnChoiceDateTo.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceTimeTo:(id)sender {
    if (self.txtTimeTo.text.length==0) {
        //        self.txtStartDateTime.text = nowTimeStr;
        //        startDate = [NSDate date];
    }else{
        NSString *strEndDate = [NSString stringWithFormat:@"%@ %@",self.txtDateTo.text,self.txtTimeTo.text];
        timeTo = [DateUtil getDateFromString:strEndDate :@"dd/MM/yyyy HH:mm"];
    }
    
    SELECTED_DATE_TAG = TAG_SELECT_TIME_TO;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = timeTo;
    detail.isTimeMode = true;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.txtTimeTo.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


-(void) selectDatePickerWithDate:(NSDate *)date
{
    NSLog(@"select date = %@", date);
    switch (SELECTED_DATE_TAG) {
        case TAG_SELECT_DATE_FROM:
            self.txtDateFrom.text = [NSString stringWithFormat:@"%@",
                                     [df stringFromDate:date]];
            dateFrom = date;
            timeFrom = date; //tam fix
            break;
        case TAG_SELECT_DATE_TO:
            self.txtDateTo.text = [NSString stringWithFormat:@"%@",
                                   [df stringFromDate:date]];
            dateTo = date;
            timeTo = date; //tam fix
            break;
            
        case TAG_SELECT_TIME_FROM:{
            self.txtTimeFrom.text = [NSString stringWithFormat:@"%@", [dfTime stringFromDate:date]];
            
            NSString *strTimeFrom = [NSString stringWithFormat:@"%@ %@",self.txtDateFrom.text,self.txtTimeFrom.text];
            timeFrom = [DateUtil getDateFromString:strTimeFrom :@"dd/MM/yyyy HH:mm"];
        }
            break;
        case TAG_SELECT_TIME_TO:{
            self.txtTimeTo.text = [NSString stringWithFormat:@"%@", [dfTime stringFromDate:date]];
            
            NSString *strTimeTo = [NSString stringWithFormat:@"%@ %@",self.txtDateTo.text,self.txtTimeTo.text];
            timeTo = [DateUtil getDateFromString:strTimeTo :@"dd/MM/yyyy HH:mm"];
        }
            break;
            
        default:
            break;
    }
}
-(void) setSelectedTime{
    NSDate *date = self.timePicker.date;
    //[self.dtStartDate resignFirstResponder];
    if([self.txtTimeFrom isFirstResponder]){
        [self.txtTimeFrom resignFirstResponder];
        self.txtTimeFrom.text = [NSString stringWithFormat:@"%@", [dfTime stringFromDate:date]];
        
        NSString *strTimeFrom = [NSString stringWithFormat:@"%@ %@",self.txtDateFrom.text,self.txtTimeFrom.text];
        timeFrom = [DateUtil getDateFromString:strTimeFrom :@"dd/MM/yyyy HH:mm"];
        
    }else if([self.txtTimeTo isFirstResponder]){
        [self.txtTimeTo resignFirstResponder];
        [self.txtTimeTo resignFirstResponder];
        self.txtTimeTo.text = [NSString stringWithFormat:@"%@", [dfTime stringFromDate:date]];
        
        NSString *strTimeTo = [NSString stringWithFormat:@"%@ %@",self.txtDateTo.text,self.txtTimeTo.text];
        timeTo = [DateUtil getDateFromString:strTimeTo :@"dd/MM/yyyy HH:mm"];
    }
}

-(void) setSelectedDate{
    NSDate *date = self.datePicker.date;
    //[self.dtStartDate resignFirstResponder];
    if([self.txtDateFrom isFirstResponder]){
        [self.txtDateFrom resignFirstResponder];
        self.txtDateFrom.text = [NSString stringWithFormat:@"%@",
                                 [df stringFromDate:date]];
        dateFrom = date;
        timeFrom = date;
    }else if([self.txtDateTo isFirstResponder]){
        [self.txtDateTo resignFirstResponder];
        self.txtDateTo.text = [NSString stringWithFormat:@"%@",
                               [df stringFromDate:date]];
        dateTo = date;
        timeTo = date;
    }
}


-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}

-(void) actionSave:(id)sender{
    
    [self hiddenKeyBoard];
    
    //check valid to save
    if(![self checkValidToSave]){
        return;
    }
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOTASK_title];
    
    if (selectStatusIndex>=0) {
        [dicEntity setObject:[[listArrStatus objectAtIndex:selectStatusIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOTASK_taskStatus];
    }
    
    [dicEntity setObject:[DateUtil formatDate:timeFrom :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_startDate];
    [dicEntity setObject:[DateUtil formatDate:timeTo :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_endDate];
    
    
    if(self.dataSend){
       // [dicEntity setObject:[self.dataSend objectForKey:DTOOPPORTUNITY_id] forKey:DTOTASK_opportunityId];
    }else{
        [dicEntity setObject:[self.dataRoot objectForKey:DTOOPPORTUNITY_id] forKey:DTOTASK_opportunityId];
        NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
        [dicEntity setObject:strClientContactId forKey:DTOTASK_clientTaskId];
    }
    [dicEntity setObject:@"1" forKey:DTOTASK_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_updatedDate];
    
    
    [dicEntity setObject:@"1" forKey:DTOTASK_clientId];
    
    
    
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    }
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    
    
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

-(BOOL)checkValidToSave{
    //clear all boder red
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
            }
        }
    }
    if([StringUtil trimString:self.txtName.text].length==0)
    {
        [self showTooltip:self.txtName withText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ERR_BLANK_NAME")];
        [self.txtName becomeFirstResponder];
        [self setBorder:self.txtName];
        return NO;
    }
    
    if(selectStatusIndex < 0){
        [self showTooltip:self.txtStatus withText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ERR_BLANK_STATUS")];
        [self.txtStatus becomeFirstResponder];
        [self setBorder:self.txtStatus];
        return NO;
    }
    
    if(dateFrom == nil){
        [self showTooltip:self.txtDateFrom withText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ERR_BLANK_STARTDATE")];
        [self.txtDateFrom becomeFirstResponder];
        [self setBorder:self.txtDateFrom];
        return NO;
        
    }
    if(dateTo == nil){
        [self showTooltip:self.txtDateTo withText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ERR_BLANK_ENDDATE")];
        [self.txtDateTo becomeFirstResponder];
        [self setBorder:self.txtDateTo];
        return NO;
        
    }
    
    return YES;
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
    selectStatusIndex = -1;
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

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    switch (SELECTED_DATE_TAG) {
        case TAG_SELECT_STATUS:
        {
            selectStatusIndex = index;
            if (index<listArrStatus.count) {
                NSDictionary *dic = [listArrStatus objectAtIndex:index];
                self.txtStatus.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex < 1)
        return;
    buttonIndex -=1;
    selectStatusIndex = buttonIndex;
    if (buttonIndex<listArrStatus.count) {
        NSDictionary *dic = [listArrStatus objectAtIndex:buttonIndex];
        self.txtStatus.text = [dic objectForKey:DTOSYSCAT_name];
    }
}



#pragma mark Tooltip
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
-(void)setBorder:(UITextField *)txtView{
    
    txtView .layer.cornerRadius=1.0f;
    txtView.layer.masksToBounds=YES;
    txtView.layer.borderColor=[[UIColor redColor]CGColor ];
    txtView.layer.borderWidth=1.0f;
    [txtView becomeFirstResponder];
}
- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}

#pragma mark - Phần đa ngôn ngữ
-(void)setLanguage{
    [_lblTitle setText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_TITLE")];
    [_txtName setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_TITLE")];
    [_lblStatus setText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_STATUS")];
    [_txtStatus setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_STATUS")];
    [_lblStartDate setText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_STARTDATE_TITLE")];
    [_txtDateFrom setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_STARTDATE_DETAIL_DATE")];
    [_txtTimeFrom setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_STARTDATE_DETAIL_TIME")];
    [_lblEndDate setText:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ENDDATE_TITLE")];
    [_txtDateTo setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ENDDATE_DETAIL_DATE")];
    [_txtTimeTo setPlaceholder:LocalizedString(@"KEY_OPPORTUNITY_TASK_EDIT_ENDDATE_DETAIL_TIME")];
    if(self.currentDeviceType == iPad){
        [_btnSave setTitle:LocalizedString(@"KEY_UPDATE") forState:UIControlStateNormal];
    }else{
        [_btnSave setTitle:LocalizedString(@"KEY_SAVE") forState:UIControlStateNormal];
    }
}
@end
