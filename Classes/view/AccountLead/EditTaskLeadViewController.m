//
//  EditTaskLeadViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/7/14.
//
//

#import "EditTaskLeadViewController.h"
#import "DTOTASKProcess.h"
#import "DTOSYSCATProcess.H"
//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"
#import "Util.h"
#import "EnumClass.h"

#define TAG_SELECT_DATE_FROM 1 //NGAY BAT DAU
#define TAG_SELECT_DATE_TO   2 //NGAY KET THUCaction
#define TAG_SELECT_TIME_FROM 3 //THOI GIAN BAT DAU
#define TAG_SELECT_TIME_TO   4 //THOI GIAN KET THUC
#define TAG_SELECT_STATUS    5 //TRANG THAI

@interface EditTaskLeadViewController () <UITextFieldDelegate>

- (IBAction)actionChoiceStatus:(id)sender;

- (IBAction)actionChoiceDateFrom:(id)sender;
- (IBAction)actionChocieTimeFrom:(id)sender;
- (IBAction)actionChoiceDateTo:(id)sender;
- (IBAction)actionChoiceTimeTo:(id)sender;

- (IBAction)homeBack:(id)sender;
- (IBAction)actionSave:(id)sender;

-(IBAction)selectStatus:(id)sender;
@end

@implementation EditTaskLeadViewController
{
    // interface references here - if not used outside object
    //__weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UIButton *_btnHome;
    __weak IBOutlet UIButton *_btnSave;
    
    __weak IBOutlet UIView  *_headerView;
    __weak IBOutlet UILabel *_headerLabel;
    __weak IBOutlet UIView  *_footerView;
    __weak IBOutlet UILabel *_footerLabel;
    
    __weak IBOutlet UIView  *_mainView;
    //__weak IBOutlet UIView  *_headerMainView;
    __weak IBOutlet UIView  *_bodyMainView;
    __weak IBOutlet UIView  *_viewMainBodyInfo;
    
    __weak IBOutlet UIButton *_btnChoiceStatus;
    __weak IBOutlet UIButton *_btnChoiceDateFrom;
    __weak IBOutlet UIButton *_btnChoiceTimeFrom;
    __weak IBOutlet UIButton *_btnChoiceDateTo;
    __weak IBOutlet UIButton *_btnChoiceTimeTo;
    
    __weak IBOutlet UITextField *_txtName;
    __weak IBOutlet UITextField *_txtStatus;
    __weak IBOutlet UITextField *_txtDateFrom;
    __weak IBOutlet UITextField *_txtTimeFrom;
    __weak IBOutlet UITextField *_txtDateTo;
    __weak IBOutlet UITextField *_txtTimeTo;
    
    UIPopoverController *_listPopover;
    
    // internal variables
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    Util *util;
    DTOTASKProcess *dtoProcess;
    DTOSYSCATProcess *dtoSyscatProcess;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    int dataId; //xac dinh id de them moi hay sua
    
    //thong tin chon NGAY - THANG
    int SELECTED_POPOVER_TAG ;
    NSDate *_startDateTime, *_endDateTime;
    
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectStatusIndex;
    NSArray *statusArray;
    
    
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    UIToolbar *toolBar;
    UITableView *tableAlert;
    NSDateFormatter *df;
    NSDateFormatter *dfTime;
    
    BOOL succsess;//Trang thai acap nhat
}

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
    
    if ([UIDevice getCurrentSysVer] >= 7.0)
    {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    
    [self initData];
    
    if (self.dataSend)
    {
        // edit/view task
        [self loadEdit];
    }
    else if (self.dataRoot)
    {
        // new task
        [self loadDefaults];
    }
    else
    {
        // ??
    }
}

#pragma mark - init view data
//khoi tao gia tri mac dinh cua form
- (void) initData
{
    util=[Util new];
    dtoProcess = [DTOTASKProcess new];
    
    /* fetch task status values from dtosyscat */
    dtoSyscatProcess = [DTOSYSCATProcess new];
    statusArray = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_TASK_STATUS];
    
    selectStatusIndex = -1;
    succsess = NO;
    
    dataId = 0;
    //======
    if ([self currentDeviceType]==iPhone) {
        
        //set boder textfield
        [self setBorderTextfield:_txtDateFrom];
        [self setBorderTextfield:_txtDateTo];
        [self setBorderTextfield:_txtName];
        [self setBorderTextfield:_txtStatus];
        [self setBorderTextfield:_txtTimeFrom];
        [self setBorderTextfield:_txtTimeTo];
        //toolbar
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:FORMAT_DATE];
        
        dfTime = [[NSDateFormatter alloc] init];
        [dfTime setDateFormat:FORMAT_TIME];
        //show date
        datePicker = [[UIDatePicker alloc] init];
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.tintColor=[UIColor whiteColor];
        [_txtDateFrom setInputView:datePicker];
        [_txtDateTo setInputView:datePicker];
        
        timePicker =[[UIDatePicker alloc] init];
        timePicker.datePickerMode=UIDatePickerModeTime;
        timePicker.tintColor=[UIColor whiteColor];
        [_txtTimeFrom setInputView:timePicker];
        [_txtTimeTo setInputView:timePicker];
        
        tableAlert = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        tableAlert.delegate=self;
        tableAlert.dataSource=self;
        [tableAlert reloadData];
        [_txtStatus setInputView:tableAlert];
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        toolBar.tintColor=HEADER_VIEW_COLOR1;
        UIBarButtonItem *doneBtn;
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(setSelectedDate)];
        
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [_txtDateFrom setInputAccessoryView:toolBar];
        [_txtDateTo setInputAccessoryView:toolBar];
        [_txtStatus setInputAccessoryView:toolBar];
        [_txtTimeFrom setInputAccessoryView:toolBar];
        [_txtTimeTo setInputAccessoryView:toolBar];
        if (_dataSend.count==0) {
            [self loadDefaults];
        }else{
            [self loadEdit];
        }
        
    }
}
//For iPhone only
-(void) setSelectedDate{
    NSDate *date = datePicker.date;
    if([_txtDateFrom isFirstResponder]){
        [_txtDateFrom resignFirstResponder];
        _txtDateFrom.text = [NSString stringWithFormat:@"%@",
                             [df stringFromDate:date]];
        _startDateTime = [date copy];
    }
    else if([_txtDateTo isFirstResponder]){
        [_txtDateTo resignFirstResponder];
        _txtDateTo.text= [NSString stringWithFormat:@"%@",[df stringFromDate:date]];
        _endDateTime = [date copy];
    }
    else if([_txtTimeFrom isFirstResponder]){
        [_txtTimeFrom resignFirstResponder];
        _txtTimeFrom.text=[NSString stringWithFormat:@"%@",[dfTime stringFromDate:date]];
        
    }
    else if([_txtTimeTo isFirstResponder]){
        [_txtTimeTo resignFirstResponder];
        _txtTimeTo.text=[NSString stringWithFormat:@"%@",[dfTime stringFromDate:date]];
        
    }
    else{
        [_txtStatus resignFirstResponder];
    }
}
-(void)setBorderTextfield:(UITextField *)txtField{
    
    txtField.textColor = TEXT_COLOR_REPORT;
    txtField.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    [txtField setBorderWithOption:smgSelect];
    [txtField setPaddingLeft];
}
#pragma mark - new view: load defaults data into view
- (void) loadDefaults
{
    _headerLabel.text  = @"THÊM MỚI CÔNG VIỆC";
    
    _txtName.text     = @"";
    _txtStatus.text   = [[statusArray objectAtIndex:0] objectForKey:DTOSYSCAT_name];
    selectStatusIndex = 0;
    [self setStartDateTime:[NSDate date]];
    [self setEndDateTime:[NSDate date]];
}

#pragma mark - edit view: load existing data into view
- (void) loadEdit
{
    NSLog(@"send:%@",_dataSend);
    
    _headerLabel.text = @"CẬP NHẬP CÔNG VIỆC";
    _txtName.text    = [_dataSend objectForKey:DTOTASK_title];
    
    if ([[_dataSend objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE)
    {
        _txtStatus.text = @"Đang thực hiện";
        selectStatusIndex = 0;//TODO: check
    }
    else if ([[dicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE)
    {
        _txtStatus.text = @"Đã hoàn thành";
        selectStatusIndex = 1;//TODO: check
    }
    
    NSString *startDateStr = [_dataSend objectForKey:DTOTASK_startDate];
    [self setStartDateTime:[DateUtil getDateFromString:startDateStr :FORMAT_DATE_AND_TIME]];
    
    NSString *endDateStr = [_dataSend objectForKey:DTOTASK_endDate];
    [self setEndDateTime:[DateUtil getDateFromString:endDateStr :FORMAT_DATE_AND_TIME]];
}

#pragma mark - init view interface
- (void) updateInterFaceWithOption : (int) option
{
    // fixed contents
    // header + footer
    _headerView.backgroundColor = HEADER_VIEW_COLOR1;
    //_headerLabel.text           = TITLE_APPLICATION;
    _headerLabel.textColor      = TEXT_COLOR_HEADER_APP;
    
    _footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    _footerLabel.text           = [NSString stringWithFormat:@"%@ %@, %@", VOFFICE, [[NSUserDefaults standardUserDefaults] objectForKey:@"versionSoftware"], COPY_OF_SOFTWARE];
    _footerLabel.textColor      = TEXT_TOOLBAR_COLOR1;
    
    // main
    _mainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    // - header
    
    //[self.btnSave setStyleNormalWithOption:smgSelect];
    
    //    _headerMainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    //    [_headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    //
    //    for (UIView *childView in _headerMainView.subviews)
    //    {
    //        if ([childView isKindOfClass:[UILabel class]])
    //        {
    //            ((UILabel*) childView).textColor = TEXT_COLOR_REPORT_TITLE_1;
    //        }
    //    }
    // - body
    _bodyMainView.backgroundColor   = BACKGROUND_NORMAL_COLOR1;
    _bodyMainView.layer.borderWidth = BORDER_WITH;
    _bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *childView in _bodyMainView.subviews)
    {
        for (UIView *subChildView in childView.subviews)
        {
            
            if ([subChildView isKindOfClass:[UIImageView class]]) {
                
                [((UIImageView*) subChildView) setAlpha:1.0f];
            }
            
            if ([subChildView isKindOfClass:[UILabel class]])
            {
                ((UILabel*) subChildView).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            else if ([subChildView isKindOfClass:[UITextView class]])
            {
                ((UITextView*) subChildView).textColor         = TEXT_COLOR_REPORT;
                ((UITextView*) subChildView).backgroundColor   = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) subChildView).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) subChildView).layer.borderWidth = BORDER_WITH;
            }
            else if ([subChildView isKindOfClass:[UITextField class]])
            {
                ((UITextField*) subChildView).textColor         = TEXT_COLOR_REPORT;
                ((UITextField*) subChildView).backgroundColor   = BACKGROUND_NORMAL_COLOR1;
                //                ((UITextField*) subChildView).layer.borderColor = [BORDER_COLOR CGColor];
                //                ((UITextField*) subChildView).layer.borderWidth = BORDER_WITH;
                
                [((UITextField*) subChildView) setPaddingLeft];
                [((UITextField*) subChildView) setBorderWithOption:smgSelect];
                
            }
        }
        
        if ([childView isKindOfClass:[UIButton class]])
        {
            [((UIButton*) childView) setStyleNormalWithOption:smgSelect];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setStartDateTime:(NSDate *)date
{
    _startDateTime = [date copy];
    _txtDateFrom.text = [DateUtil formatDate:_startDateTime :FORMAT_DATE];
    _txtTimeFrom.text = [DateUtil formatDate:_startDateTime :FORMAT_TIME];
}

- (void)setEndDateTime:(NSDate *)date
{
    _endDateTime = [date copy];
    _txtDateTo.text = [DateUtil formatDate:_endDateTime :FORMAT_DATE];
    _txtTimeTo.text = [DateUtil formatDate:_endDateTime :FORMAT_TIME];
}
#pragma mark - dropdown
- (IBAction)actionChoiceStatus:(id)sender
{
    [self hideKeyboard];
    SELECTED_POPOVER_TAG = TAG_SELECT_STATUS;
    
    // status drop down
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    detail.selectIndex = selectStatusIndex;
    detail.listData = [statusArray valueForKey:DTOSYSCAT_name];
    detail.delegate = (id<SelectIndexDelegate>) self;
    
    _listPopover = [[UIPopoverController alloc] initWithContentViewController:detail];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = CGSizeMake(320,250);
    [_listPopover presentPopoverFromRect:_txtStatus.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceDateFrom:(id)sender
{
    [self hideKeyboard];
    SELECTED_POPOVER_TAG = TAG_SELECT_DATE_FROM;
    
    // date-from date picker
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = _startDateTime;
    detail.isTimeMode   = FALSE;
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    
    _listPopover = [[UIPopoverController alloc] initWithContentViewController:detail];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = CGSizeMake(320, 260);
    [_listPopover presentPopoverFromRect:_txtDateFrom.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChocieTimeFrom:(id)sender
{
    [self hideKeyboard];
    SELECTED_POPOVER_TAG = TAG_SELECT_TIME_FROM;
    
    // time-from date picker
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = _startDateTime;
    detail.isTimeMode   = TRUE;
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = CGSizeMake(320, 260);
    [_listPopover presentPopoverFromRect:_txtTimeFrom.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceDateTo:(id)sender
{
    [self hideKeyboard];
    SELECTED_POPOVER_TAG = TAG_SELECT_DATE_TO;
    
    // date-to date picker
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = _endDateTime;
    detail.isTimeMode   = FALSE;
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = CGSizeMake(320, 260);
    [_listPopover presentPopoverFromRect:_txtDateTo.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceTimeTo:(id)sender
{
    [self hideKeyboard];
    SELECTED_POPOVER_TAG = TAG_SELECT_TIME_TO;
    
    // time-to date picker
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = _endDateTime;
    detail.isTimeMode   = TRUE;
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = CGSizeMake(320, 260);
    [_listPopover presentPopoverFromRect:_txtTimeTo.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - Delegate calls
-(void) selectDatePickerWithDate:(NSDate *)date
{
    NSLog(@"selected date = %@", date);
    switch (SELECTED_POPOVER_TAG)
    {
        case TAG_SELECT_DATE_FROM:
        case TAG_SELECT_TIME_FROM:
        {
            [self setStartDateTime:date];
        }
            break;
        case TAG_SELECT_DATE_TO:
        case TAG_SELECT_TIME_TO:
        {
            [self setEndDateTime:date];
        }
            break;
        default:
            break;
    }
}

-(void) dismissPopoverView
{
    if ([_listPopover isPopoverVisible])
        [_listPopover dismissPopoverAnimated:YES];
}

#pragma mark - Save
- (void)actionSave:(id)sender
{
    //check valid to save
    if (![self validateBeforeSave])
    {
        return;
    }
    
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOTASK_title];
    
    if (selectStatusIndex >= 0)
    {
        [dicEntity setObject:[[statusArray objectAtIndex:selectStatusIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOTASK_taskStatus];
    }
    
    [dicEntity setObject:[DateUtil formatDate:_startDateTime :FORMAT_DATE_AND_TIME] forKey:DTOTASK_startDate];
    [dicEntity setObject:[DateUtil formatDate:_endDateTime   :FORMAT_DATE_AND_TIME] forKey:DTOTASK_endDate];
    
    
    [dicEntity setObject:@"1" forKey:DTOTASK_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate date] :FORMAT_DATE_AND_TIME] forKey:DTOTASK_updatedDate];
    NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
    [dicEntity setObject:strClientContactId forKey:DTOTASK_clientTaskId];
    [dicEntity setObject:@"1" forKey:DTOTASK_clientId];
    [dicEntity setObject:@"1" forKey:DTOTASK_typeTask];
    
    if (self.dataRoot) {
        //TODO: check
        if (self.isKHDM) {
            [dicEntity setObject:[self.dataRoot objectForKey:DTOLEAD_clientLeadId] forKey:DTOTASK_clientLeadId];
        }else{
            [dicEntity setObject:[self.dataRoot objectForKey:DTOACCOUNT_clientAccountId] forKey:DTOTASK_accountId];
        }
        
    }
    
    if (self.dataSend)
    {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    }
    
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    if (succsess)
    {
        if ([self currentDeviceType]==iPhone) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            //Thong bao cap nhat thanh cong va thoat
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
            alert.tag = 5;
            [alert show];
        }
    }
    else
    {
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Sảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
}

- (BOOL)validateBeforeSave
{
    /* returns TRUE if all fields validate OK */
    if ([StringUtil stringIsEmpty:_txtName.text])
    {
        [util showTooltip:_txtName withText:@"Vui lòng nhập tiêu đề cho Công việc" showview:self.view];
        [util setBorder:_txtName];
        return FALSE;
    }
    else if ([_txtName.text length] > 200)
    {
        [util showTooltip:_txtName withText:@"Vui lòng nhập tiêu đề cho Công việc ít hơn 200 kí tự" showview:self.view];
        [util setBorder:_txtName];
        return FALSE;
    }
    else if (   [_endDateTime compare:_startDateTime] == NSOrderedAscending
             || [_endDateTime compare:_startDateTime] == NSOrderedSame)
    {
        
        [util showTooltip:_txtDateTo withText:@"Vui lòng nhập thời điểm kết thúc sau thời điểm bắt đầu" showview:self.view];
        [util setBorder:_txtDateTo];
        return FALSE;
    }
    else if (selectStatusIndex < 0)
    {
        [util showTooltip:_txtStatus withText:@"Vui lòng nhập trạng thái của Công việc" showview:self.view];
        [util setBorder:_txtStatus];
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark - Delegate calls
- (IBAction)homeBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0 && alertView.tag ==1) {
        
        
    }
    if (succsess && alertView.tag == 5 && buttonIndex == 0) { //thong bao dong form
        [self dismissViewControllerAnimated:YES completion:nil];
        if (_delegate && [_delegate respondsToSelector:@selector(closeEditTaskLeadViewController:)]) {
            [_delegate closeEditTaskLeadViewController:self];
        }
    }
    
    if (succsess && alertView.tag == 5 && buttonIndex == 1) {
        //reset lai form
        [self resetForm];
    }
}

-(void) resetForm {
    for (UIView *viewTemp in _bodyMainView.subviews) {
        
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
    
    [self hideKeyboard];
    
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - Status dropdown : SelectIndexDelegate
-(void) selectAtIndex:(NSInteger)index
{
    if ([_listPopover isPopoverVisible])
    {
        [ _listPopover dismissPopoverAnimated:YES];
    }
    
    switch (SELECTED_POPOVER_TAG)
    {
        case TAG_SELECT_STATUS:
        {
            selectStatusIndex = index;
            if (index < statusArray.count)
            {
                NSDictionary *dic = [statusArray objectAtIndex:index];
                _txtStatus.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _txtName)
    {
        /* do not show drop down - allow editing */
        return TRUE;
    }
    else if (textField == _txtStatus)
    {
        /* show status picker */
        [_btnChoiceStatus sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtDateFrom)
    {
        /* show date from picker */
        [_btnChoiceDateFrom sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtDateTo)
    {
        /* show date to picker */
        [_btnChoiceDateTo sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtTimeFrom)
    {
        /* show time from picker */
        [_btnChoiceTimeFrom sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtTimeTo)
    {
        /* show time to picker */
        [_btnChoiceTimeTo sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
    }
    
    return FALSE;
}
-(IBAction)selectStatus:(id)sender{
    
    NSLog(@"haha");
}
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[statusArray valueForKey:DTOSYSCAT_name]  count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [[statusArray valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
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
    
    NSDictionary *getData = [[statusArray valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
    _txtStatus.text=getData;
    selectStatusIndex=indexPath.row;
    [_txtStatus resignFirstResponder];
    
}
@end
