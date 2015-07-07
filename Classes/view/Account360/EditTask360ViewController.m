//
//  EditTaskLeadViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/7/14.
//
//

#import "EditTask360ViewController.h"
#import "DTOTASKProcess.h"
#import "DTOSYSCATProcess.H"
//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"
#import "EnumClass.h"
#import "Util.h"

#define TAG_SELECT_DATE_FROM 1 //NGAY BAT DAU
#define TAG_SELECT_DATE_TO 2 //NGAY KET THUC
#define TAG_SELECT_TIME_FROM 3 //THOI GIAN BAT DAU
#define TAG_SELECT_TIME_TO 4 //THOI GIAN KET THUC

#define TAG_SELECT_STATUS 5 //TRANG THAI

@interface EditTask360ViewController ()
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
    
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    UIToolbar *toolBar;
    UITableView *tableAlert;
    
    Util *util;
    
    BOOL succsess;//Trang thai acap nhat
}
@end

@implementation EditTask360ViewController

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
    
    util=[Util new];
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
    if (self.dataSend) {
        
        [self loadEdit];
    }else{
        
    }
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
        datePicker.backgroundColor=[UIColor whiteColor];
        [_txtDateFrom setInputView:datePicker];
        [_txtDateTo setInputView:datePicker];
        
        timePicker =[[UIDatePicker alloc] init];
        timePicker.datePickerMode=UIDatePickerModeTime;
        timePicker.backgroundColor=[UIColor whiteColor];
        [_txtTimeFrom setInputView:timePicker];
        [_txtTimeTo setInputView:timePicker];
        
        tableAlert = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        tableAlert.delegate=self;
        tableAlert.dataSource=self;
        [tableAlert reloadData];
        [_txtStatus setInputView:tableAlert];
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        toolBar.backgroundColor=HEADER_VIEW_COLOR1;
        UIBarButtonItem *doneBtn;
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(setSelectedDate)];
        
        [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [_txtDateFrom setInputAccessoryView:toolBar];
        [_txtDateTo setInputAccessoryView:toolBar];
        [_txtStatus setInputAccessoryView:toolBar];
        [_txtTimeFrom setInputAccessoryView:toolBar];
        [_txtTimeTo setInputAccessoryView:toolBar];
        if (self.dataSend.count == 0) {
            [self loadDefaults];
        }
        else{
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
        timeFrom = [date copy];
    }
    else if([_txtDateTo isFirstResponder]){
        [_txtDateTo resignFirstResponder];
        _txtDateTo.text= [NSString stringWithFormat:@"%@",[df stringFromDate:date]];
        timeTo = [date copy];
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
    _fullNameLB.text  = @"THÊM MỚI CÔNG VIỆC";
    
    _txtName.text     = @"";
    _txtStatus.text   = [[listArrStatus objectAtIndex:0] objectForKey:DTOSYSCAT_name];
    selectStatusIndex = 0;
    [self setStartDateTime:[NSDate date]];
    [self setEndDateTime:[NSDate date]];
}
-(void) loadEdit{
    
    NSLog(@"send:%@",_dataSend);
    
    self.fullNameLB.text=@"CẬP NHẬP CÔNG VIỆC";
    
    _txtName.text=[_dataSend objectForKey:DTOTASK_title];
    if ([[_dataSend objectForKey:DTOTASK_taskStatus] isEqualToString:@"3244"]) {
        _txtStatus.text =@"Đang thực hiện";
        selectStatusIndex=0;
    }
    else{
        _txtStatus.text=@"Đã hoàn thành";
        selectStatusIndex=1;
    }
    
    NSString *startDateStr = [_dataSend objectForKey:DTOTASK_startDate];
    [self setStartDateTime:[DateUtil getDateFromString:startDateStr :FORMAT_DATE_AND_TIME]];
    
    NSString *endDateStr = [_dataSend objectForKey:DTOTASK_endDate];
    [self setEndDateTime:[DateUtil getDateFromString:endDateStr :FORMAT_DATE_AND_TIME]];
    
}

- (void)setStartDateTime:(NSDate *)date
{
    timeFrom = [date copy];
    _txtDateFrom.text = [DateUtil formatDate:timeFrom :FORMAT_DATE];
    _txtTimeFrom.text = [DateUtil formatDate:timeFrom :FORMAT_TIME];
}

- (void)setEndDateTime:(NSDate *)date
{
    timeTo = [date copy];
    _txtDateTo.text = [DateUtil formatDate:timeTo :FORMAT_DATE];
    _txtTimeTo.text = [DateUtil formatDate:timeTo :FORMAT_TIME];
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
    
    
    //    [self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    //    [self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    //    for (UIView *viewSubTemp in self.headerMainView.subviews) {
    //
    //
    //        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
    //            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
    //        }
    //    }
    
    [self.btnSave setStyleNormalWithOption:smgSelect];
    
    
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

- (IBAction)actionChoiceStatus:(id)sender {
    [self hiddenKeyBoard];
    
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
    
}

- (IBAction)actionChoiceDateFrom:(id)sender {
    [self hiddenKeyBoard];
    
    if (self.txtDateFrom.text.length==0) {
        dateFrom = [NSDate date];
    }else{
        dateTo = [DateUtil getDateFromString:self.txtDateFrom.text :FORMAT_DATE];
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
    
    if (self.txtDateTo.text.length==0) {
        dateTo = [NSDate date];
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
            break;
        case TAG_SELECT_DATE_TO:
            self.txtDateTo.text = [NSString stringWithFormat:@"%@",
                                   [df stringFromDate:date]];
            dateTo = date;
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
-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}

-(void) actionSave:(id)sender{
    //check valid to save
    if (![self validateBeforeSave]) {
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
    
    [dicEntity setObject:@"1" forKey:DTOTASK_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_updatedDate];
    NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
    [dicEntity setObject:strClientContactId forKey:DTOTASK_clientTaskId];
    [dicEntity setObject:@"1" forKey:DTOTASK_clientId];
    [dicEntity setObject:@"1" forKey:DTOTASK_typeTask];
    
    if (self.dataRoot) {
        
        [dicEntity setObject:[self.dataRoot objectForKey:DTOACCOUNT_clientAccountId] forKey:DTOTASK_accountId];
        
    }
    
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    }
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    
    
    if (succsess) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
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
#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[listArrStatus valueForKey:DTOSYSCAT_name]  count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [[listArrStatus valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
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
    
    NSDictionary *getData = [[listArrStatus valueForKey:DTOSYSCAT_name] objectAtIndex:indexPath.row];
    _txtStatus.text=getData;
    selectStatusIndex=indexPath.row;
    [_txtStatus resignFirstResponder];
    
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
    else if (   [timeTo compare:timeFrom] == NSOrderedAscending
             || [timeTo compare:timeFrom] == NSOrderedSame)
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
@end
