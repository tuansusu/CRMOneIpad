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

#define TAG_SELECT_DATE_FROM 1 //NGAY BAT DAU
#define TAG_SELECT_DATE_TO   2 //NGAY KET THUC
#define TAG_SELECT_TIME_FROM 3 //THOI GIAN BAT DAU
#define TAG_SELECT_TIME_TO   4 //THOI GIAN KET THUC
#define TAG_SELECT_STATUS    5 //TRANG THAI

@interface EditTaskLeadViewController ()
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
    int SELECTED_POPOVER_TAG ;
    NSDate *dateFrom, *dateTo;
    NSDate *timeFrom, *timeTo;
    NSDateFormatter *df,*dfTime;
    
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectStatusIndex;
    NSArray *listArrStatus;
    
    BOOL succsess;//Trang thai acap nhat
}

- (IBAction)actionChoiceStatus:(id)sender;

- (IBAction)actionChoiceDateFrom:(id)sender;
- (IBAction)actionChocieTimeFrom:(id)sender;
- (IBAction)actionChoiceDateTo:(id)sender;
- (IBAction)actionChoiceTimeTo:(id)sender;

- (IBAction)homeBack:(id)sender;
- (IBAction)actionSave:(id)sender;

//////////chon trol


@end

@implementation EditTaskLeadViewController
{
    // interface references here - if not used outside object
    __weak IBOutlet UILabel *_titleLabel;
    
    __weak IBOutlet UIButton *_btnHome;
    __weak IBOutlet UIButton *_btnSave;
    
    __weak IBOutlet UIView  *_headerView;
    __weak IBOutlet UILabel *_headerLabel;
    __weak IBOutlet UIView  *_footerView;
    __weak IBOutlet UILabel *_footerLabel;
    
    __weak IBOutlet UIView  *_mainView;
    __weak IBOutlet UIView  *_headerMainView;
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
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    
    [self initData];
    [self updateInterFaceWithOption:smgSelect];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:FORMAT_DATE];
    
    dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:FORMAT_TIME];
    
    selectStatusIndex = -1;
    succsess = NO;
    
    dtoProcess = [DTOTASKProcess new];
    dtoSyscatProcess = [DTOSYSCATProcess new];
    
    listArrStatus = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_TASK_STATUS];
    
    dataId = 0;
    
    if (self.dataSend)
    {
        // edit/view task
        [self loadEdit];
    }
    else if (self.dataRoot)
    {
        // new task
    }
    else
    {
        // ??
    }
}

-(void) loadEdit{
    
    NSLog(@"send:%@",_dataSend);
    
    _titleLabel.text=@"CẬP NHẬP CÔNG VIỆC";
    
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
    
    NSDateFormatter *timeEndFormatS=[[NSDateFormatter alloc]init];
    [timeEndFormatS setDateFormat:@"HH:mm"];
    _txtTimeFrom.text=[timeEndFormatS stringFromDate:start];
    
    
    
    NSDateFormatter *dateFromStringFormat=[[NSDateFormatter alloc]init];
    [dateFromStringFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    
    NSDateFormatter *dateEndFormat=[[NSDateFormatter alloc]init];
    [dateEndFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *end=[dateFromStringFormat dateFromString:strDateEnd];
    _txtDateTo.text=[dateEndFormat stringFromDate:end ];
    
    NSDateFormatter *timeEndFormat=[[NSDateFormatter alloc]init];
    [timeEndFormat setDateFormat:@"HH:mm"];
    _txtTimeTo.text=[timeEndFormat stringFromDate:end];
}


- (void) updateInterFaceWithOption : (int) option
{
    // fixed contents
    // header + footer
    _headerView.backgroundColor = HEADER_VIEW_COLOR1;
    _headerLabel.text           = TITLE_APPLICATION;
    _headerLabel.textColor      = TEXT_COLOR_HEADER_APP;

    _footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    _footerLabel.text           = [NSString stringWithFormat:@"%@ %@, %@", VOFFICE, [defaults objectForKey:@"versionSoftware"], COPY_OF_SOFTWARE];
    _footerLabel.textColor      = TEXT_TOOLBAR_COLOR1;
    
    // main
    _mainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    // - header
    _headerMainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    [_headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
    for (UIView *childView in _headerMainView.subviews)
    {
        if ([childView isKindOfClass:[UILabel class]]) {
            ((UILabel*) childView).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    // - body
    _bodyMainView.backgroundColor   = BACKGROUND_NORMAL_COLOR1;
    _bodyMainView.layer.borderWidth = BORDER_WITH;
    _bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *childView in _bodyMainView.subviews)
    {
        for (UIView *subChildView in childView.subviews)
        {
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
                ((UITextField*) subChildView).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) subChildView).layer.borderWidth = BORDER_WITH;
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

- (IBAction)actionChoiceStatus:(id)sender
{
    // status drop down
    [self hideKeyboard];
    
    SELECTED_POPOVER_TAG = TAG_SELECT_STATUS;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectStatusIndex;
    
    detail.listData = [listArrStatus valueForKey:DTOSYSCAT_name];
    
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _btnChoiceStatus.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [_listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [_listPopover presentPopoverFromRect:popoverFrame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (IBAction)actionChoiceDateFrom:(id)sender {
    [self hideKeyboard];
    
    if (_txtDateFrom.text.length==0) {
        dateFrom = [NSDate date];
    }else{
        dateTo = [DateUtil getDateFromString:_txtDateFrom.text :FORMAT_DATE];
    }
    
    SELECTED_POPOVER_TAG = TAG_SELECT_DATE_FROM;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateFrom;
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _btnChoiceDateFrom.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [_listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [_listPopover presentPopoverFromRect:popoverFrame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChocieTimeFrom:(id)sender {
    if (_txtTimeFrom.text.length==0) {
        //        self.txtStartDateTime.text = nowTimeStr;
        //        startDate = [NSDate date];
    }else{
        NSString *strEndDate = [NSString stringWithFormat:@"%@ %@",_txtDateFrom.text,_txtTimeFrom.text];
        timeFrom = [DateUtil getDateFromString:strEndDate :@"dd/MM/yyyy HH:mm"];
    }
    
    SELECTED_POPOVER_TAG = TAG_SELECT_TIME_FROM;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = timeFrom;
    detail.isTimeMode = true;
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _txtTimeFrom.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [_listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [_listPopover presentPopoverFromRect:popoverFrame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceDateTo:(id)sender {
    [self hideKeyboard];
    
    if (_txtDateTo.text.length==0) {
        dateTo = [NSDate date];
    }else{
        dateTo = [DateUtil getDateFromString:_txtDateTo.text :FORMAT_DATE];
    }
    
    SELECTED_POPOVER_TAG = TAG_SELECT_DATE_TO;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateTo;
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _btnChoiceDateTo.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [_listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [_listPopover presentPopoverFromRect:popoverFrame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChoiceTimeTo:(id)sender {
    if (_txtTimeTo.text.length==0) {
        //        self.txtStartDateTime.text = nowTimeStr;
        //        startDate = [NSDate date];
    }else{
        NSString *strEndDate = [NSString stringWithFormat:@"%@ %@",_txtDateTo.text,_txtTimeTo.text];
        timeTo = [DateUtil getDateFromString:strEndDate :@"dd/MM/yyyy HH:mm"];
    }
    
    SELECTED_POPOVER_TAG = TAG_SELECT_TIME_TO;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = timeTo;
    detail.isTimeMode = true;
    _listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = _txtTimeTo.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [_listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [_listPopover presentPopoverFromRect:popoverFrame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


-(void) selectDatePickerWithDate:(NSDate *)date
{
    NSLog(@"select date = %@", date);
    switch (SELECTED_POPOVER_TAG) {
        case TAG_SELECT_DATE_FROM:
            _txtDateFrom.text = [NSString stringWithFormat:@"%@",
                                        [df stringFromDate:date]];
            dateFrom = date;
            break;
        case TAG_SELECT_DATE_TO:
            _txtDateTo.text = [NSString stringWithFormat:@"%@",
                                       [df stringFromDate:date]];
            dateTo = date;
            break;
            
        case TAG_SELECT_TIME_FROM:{
            _txtTimeFrom.text = [NSString stringWithFormat:@"%@", [dfTime stringFromDate:date]];
            
            NSString *strTimeFrom = [NSString stringWithFormat:@"%@ %@",_txtDateFrom.text,_txtTimeFrom.text];
            timeFrom = [DateUtil getDateFromString:strTimeFrom :@"dd/MM/yyyy HH:mm"];
        }
            break;
        case TAG_SELECT_TIME_TO:{
            _txtTimeTo.text = [NSString stringWithFormat:@"%@", [dfTime stringFromDate:date]];
            
            NSString *strTimeTo = [NSString stringWithFormat:@"%@ %@",_txtDateTo.text,_txtTimeTo.text];
            timeTo = [DateUtil getDateFromString:strTimeTo :@"dd/MM/yyyy HH:mm"];
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

-(void) actionSave:(id)sender{
    //check valid to save
    
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    [dicEntity setObject:[StringUtil trimString:_txtName.text] forKey:DTOTASK_title];
    
    if (selectStatusIndex>=0) {
        [dicEntity setObject:[[listArrStatus objectAtIndex:selectStatusIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOTASK_taskStatus];
    }
    
    [dicEntity setObject:[DateUtil formatDate:timeFrom :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_startDate];
    [dicEntity setObject:[DateUtil formatDate:timeTo :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_endDate];
    
   [dicEntity setObject:[self.dataRoot objectForKey:DTOLEAD_clientLeadId] forKey:DTOTASK_clientLeadId];
    [dicEntity setObject:@"1" forKey:DTOTASK_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOTASK_updatedDate];
    NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
    [dicEntity setObject:strClientContactId forKey:DTOTASK_clientTaskId];
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

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (_listPopover)
    {
        [ _listPopover dismissPopoverAnimated:YES];
    }
    
    switch (SELECTED_POPOVER_TAG)
    {
        case TAG_SELECT_STATUS:
        {
            selectStatusIndex = index;
            if (index < listArrStatus.count)
            {
                NSDictionary *dic = [listArrStatus objectAtIndex:index];
                _txtStatus.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
        
        default:
            break;
    }
}

@end
