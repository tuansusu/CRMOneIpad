//
//  EditCalendarLeadViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "EditCalendarLeadViewController.h"

#import "DTOTASKProcess.h"
#import "DTOSYSCATProcess.H"
#import "DTOACCOUNTLEADProcess.h"

#import "AMRatingControl.h"
#import "SelectIndexViewController.h"
#import "CalendarPickerViewController.h"
#import "AlarmCalendarViewController.h"
#import "RepeatCalendarViewController.h"

#import <EventKit/EventKit.h>

//REMOVE DEPLOY
#import "UIDevice+extend.h"
#import "Constant.h"
#import "GraphicName.h"
#import "AUISelectiveBordersLayer.h"
#import "DataField.h"
#import "DateUtil.h"
#import "NSDate+Utilities.h"
#import "Validator.h"
#import "Util.h"

#define TAG_SELECT_DATE_FROM  1//NGAY BAT DAU
#define TAG_SELECT_DATE_TO    2//NGAY KET THUC
#define TAG_SELECT_TIME_FROM  3//THOI GIAN BAT DAU
#define TAG_SELECT_TIME_TO    4//THOI GIAN KET THUC
#define TAG_SELECT_STATUS     5//TRANG THAI
#define TAG_SELECT_EVENT_TYPE 6//HINH THUC

#define TAG_SELECT_CUSTOMER_TYPE 7
#define TAG_SELECT_CUSTOMERS     8


@interface EditCalendarLeadViewController () <UITextFieldDelegate, SelectIndexDelegate, CalendarSelectDatePickerDelegate, AlarmCalendarViewDelegate, RepeatCalendarViewDelegate>
{
    
}

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;
//////////chon trol
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtTypeObject;
@property (weak, nonatomic) IBOutlet UITextField *txtNameObject;

@property (weak, nonatomic) IBOutlet UITextField *txtStatus;


@property (weak, nonatomic) IBOutlet UITextField *txtDateFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtTimeFrom;

@property (weak, nonatomic) IBOutlet UITextField *txtDateTo;

@property (weak, nonatomic) IBOutlet UITextField *txtTimeTo;

- (IBAction)actionChoiceStatus:(id)sender;

- (IBAction)actionChoiceDateFrom:(id)sender;
- (IBAction)actionChocieTimeFrom:(id)sender;
- (IBAction)actionChoiceDateTo:(id)sender;
- (IBAction)actionChoiceTimeTo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnChoiceStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceDateFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceTimeFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceDateTo;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceTimeTo;

@property (weak, nonatomic) IBOutlet UIView *viewRatingStar;



@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////



- (IBAction)actionChoiceLocation:(id)sender;
- (IBAction)actionChoiceEventType:(id)sender;
- (IBAction)actionChoiceRepeat:(id)sender;
- (IBAction)actionChoiceAlarm:(id)sender;
@end

@implementation EditCalendarLeadViewController
{
    __weak IBOutlet UILabel     *_titleLabel;
    
    __weak IBOutlet UITextField *_txtLocation;//TODO: delegate
    __weak IBOutlet UIButton    *_btnChoiceLocation;
    
    __weak IBOutlet UITextField *_txtEventType;//TODO: delegate
    __weak IBOutlet UIButton    *_btnChoiceEventType;
    
    __weak IBOutlet UITextField *_txtDescription;
    
    __weak IBOutlet UITextField *_txtRepeat;//TODO: delegate
    __weak IBOutlet UIButton    *_btnChoiceRepeat;
    
    __weak IBOutlet UITextField *_txtAlarm;//TODO: delegate
    __weak IBOutlet UIButton    *_btnChoiceAlarm;
    
    
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOTASKProcess *dtoProcess;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    int dataId; //xac dinh id de them moi hay sua
    
    //thong tin chon NGAY - THANG
    int SELECTED_POPOVER_TAG;
    NSDate *_startDateTime, *_endDateTime;
    
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectStatusIndex;
    NSArray *statusArray;
    
    BOOL succsess;//Trang thai acap nhat
    BOOL isEditTask;
    
    /* alarm and repeat config */
    AlarmCalendarConfig * _alarmConfig;
    RepeatCalendarConfig * _repeatConfig;
    Util *util;
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
    util = [Util new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    
    [self renderControl];
    
    [self initData];
    
    if (self.dataSend)
    {
        // edit/view event
        [self loadEdit];
    }
    else if (self.dataRoot)
    {
        // new event
        [self loadDefaults];
    }
    else
    {
        // ??
    }
}

-(void) renderControl {
    
    AMRatingControl *coloredRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(0, 0)
                                                                           emptyColor:[UIColor yellowColor]
                                                                           solidColor:[UIColor redColor]
                                                                         andMaxRating:5];
    
    // Define block to handle events
    coloredRatingControl.editingChangedBlock = ^(NSUInteger rating)
    {
        //[label setText:];
        NSLog(@"editingChangeBlock %d", rating);
    };
    
    coloredRatingControl.editingDidEndBlock = ^(NSUInteger rating)
    {
        NSLog(@"editingDidEndBlock %d", rating);
    };
    
    // Add the control(s) as a subview of your view
    [_viewRatingStar addSubview:coloredRatingControl];
}

//khoi tao gia tri mac dinh cua form
- (void)initData
{
    
    selectStatusIndex = -1;
    succsess = NO;
    _barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[[NSUserDefaults standardUserDefaults] objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    dtoProcess = [DTOTASKProcess new];
    DTOSYSCATProcess *dtoSyscatProcess = [DTOSYSCATProcess new];
    
    statusArray = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_TASK_STATUS];
    
    dataId = 0;
}

#pragma mark - new view: load defaults data into view
- (void) loadDefaults
{
    _fullNameLB.text  = @"THÊM MỚI LỊCH";
    
    _txtName.text     = @"";
    _txtStatus.text   = [[statusArray objectAtIndex:0] objectForKey:DTOSYSCAT_name];
    selectStatusIndex = 0;
    
    // round up date
    NSDate *nextHour = [[NSDate date] roundToNextHour];
    [self setStartDateTime: nextHour];
    [self setEndDateTime  :[nextHour roundToNextHour]];
    
    //TODO: set default type
    
    if(![StringUtil stringIsEmpty:[_dataRoot objectForKey:DTOLEAD_leadType]])
    {
        if ([ObjectToStr([_dataRoot objectForKey:DTOLEAD_leadType]) isEqualToString:FIX_LEADTYPE_PERSON])
        {
            _txtTypeObject.text = SELECT_TEXT_ADD_PERSON;
        }
        else
        {
            _txtTypeObject.text = SELECT_TEXT_ADD_BUSSINESS;
        }
    }
    
    _txtNameObject.text = [_dataRoot objectForKey:DTOLEAD_name];
}

#pragma mark - edit view: load existing data into view
- (void) loadEdit
{
    NSLog(@"send:%@",_dataSend);
    
    _fullNameLB.text = @"CẬP NHẬP LỊCH";
    if (_dataSend) {
        isEditTask = YES;
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
        
        _alarmConfig = [[AlarmCalendarConfig alloc] initFromDictionary:_dataSend];
        if (_alarmConfig != nil)
        {
            if (_alarmConfig.isReminder)
            {
                _txtAlarm.text = [_alarmConfig toReadableText];
            }
            else
            {
                _txtAlarm.text = @"";
            }
        }
        
        _repeatConfig = [[RepeatCalendarConfig alloc] initFromDictionary:_dataSend];
        if (_repeatConfig != nil)
        {
            if (_repeatConfig.isRepeat)
            {
                _txtRepeat.text = [_repeatConfig toReadableText];
            }
            else
            {
                _txtRepeat.text = @"";
            }
        }
    }
    
}


- (void) updateInterFaceWithOption : (int) option
{
    _fullNameLB.text                = TITLE_ADD_CALENDAR;
    _headerViewBar.backgroundColor  = HEADER_VIEW_COLOR1;
    _fullNameLB.textColor           = TEXT_COLOR_HEADER_APP;
    
    _footerView.backgroundColor     = TOOLBAR_VIEW_COLOR;
    _barLabel.textColor             = TEXT_TOOLBAR_COLOR1;
    
    //    _headerMainView.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    //    [_headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    //    for (UIView *viewSubTemp in _headerMainView.subviews)
    //    {
    //        if ([viewSubTemp isKindOfClass:[UILabel class]])
    //        {
    //            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
    //        }
    //    }
    
    [self.btnSave setStyleNormalWithOption:smgSelect];
    
    _mainView.backgroundColor       = HEADER_SUB_VIEW_COLOR1;
    
    _bodyMainView.backgroundColor   = BACKGROUND_NORMAL_COLOR1;
    _bodyMainView.layer.borderWidth = BORDER_WITH;
    _bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in _bodyMainView.subviews)
    {
        for (UIView *viewSubTemp in viewTemp.subviews)
        {
            
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
                continue;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UILabel class]])
            {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            else if ([viewSubTemp isKindOfClass:[UITextView class]])
            {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            else if ([viewSubTemp isKindOfClass:[UITextField class]])
            {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                //                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                //                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                
                [((UITextField*) viewSubTemp) setPaddingLeft];
                [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
            }
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]])
        {
            [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
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

- (IBAction)actionChoiceLocation:(id)sender
{
    
}

- (IBAction)actionChoiceEventType:(id)sender
{
    
}

- (IBAction)actionChoiceRepeat:(id)sender
{
    RepeatCalendarViewController * detail = [[RepeatCalendarViewController alloc] init];
    detail.delegate = self;
    detail.config = _repeatConfig;
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:detail];
    _listPopover = [[UIPopoverController alloc] initWithContentViewController:nav];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = detail.view.frame.size;
    [_listPopover presentPopoverFromRect:_txtRepeat.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionChoiceAlarm:(id)sender
{
    AlarmCalendarViewController * detail = [[AlarmCalendarViewController alloc] init];
    detail.delegate = self;
    detail.config = _alarmConfig;
    _listPopover = [[UIPopoverController alloc] initWithContentViewController:detail];
    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    _listPopover.popoverContentSize = detail.view.frame.size;
    [_listPopover presentPopoverFromRect:_txtAlarm.frame inView:_viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - CalendarSelectDatePickerDelegate

-(void) selectDatePickerWithDate:(NSDate *)date
{
    NSLog(@"select date = %@", date);
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

-(void) actionSave:(id)sender{
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
    
    //TODO: check
    [dicEntity setObject:@"1" forKey:DTOTASK_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate date] :FORMAT_DATE_AND_TIME] forKey:DTOTASK_updatedDate];
    NSString *strClientContactId = IntToStr(([dtoProcess getClientId]));
    [dicEntity setObject:strClientContactId forKey:DTOTASK_clientTaskId];
    [dicEntity setObject:@"1" forKey:DTOTASK_clientId];
    [dicEntity setObject:@"5" forKey:DTOTASK_formal];
    [dicEntity setObject:@"0" forKey:DTOTASK_typeTask];
    
    if (_dataRoot) {
        if (_isKH360) {
            [dicEntity setObject:[self.dataRoot objectForKey:DTOACCOUNT_clientAccountId] forKey:DTOTASK_accountId];
        }else{
            [dicEntity setObject:[_dataRoot objectForKey:DTOLEAD_clientLeadId] forKey:DTOTASK_clientLeadId];
        }
    }
    
    if (_dataSend)
    {
        if (_isKH360) {
            if ([self.dataRoot objectForKey:DTOACCOUNT_clientAccountId]) {
                [dicEntity setObject:[self.dataRoot objectForKey:DTOACCOUNT_clientAccountId] forKey:DTOTASK_accountId];
            }
        }else{
            if ([_dataSend objectForKey:DTOLEAD_clientLeadId]) {
                [dicEntity setObject:[_dataSend objectForKey:DTOLEAD_clientLeadId] forKey:DTOTASK_clientLeadId];
            }
            
        }
        
        [dicEntity setObject:[_dataSend objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    }
    
    if (_alarmConfig != nil)
    {
        [dicEntity addEntriesFromDictionary:[_alarmConfig toDictionary]];
    }
    
    if (_repeatConfig != nil)
    {
        [dicEntity addEntriesFromDictionary:[_repeatConfig toDictionary]];
    }
    
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    if (succsess)
    {
        if (isEditTask) {
            NSMutableArray *resultArr =  [dtoProcess filterTheNewestRecord];
            if (resultArr.count>0) {
                NSMutableDictionary *newTaskDic = [resultArr objectAtIndex:0];
                NSString *key =[newTaskDic valueForKey:DTOTASK_id];
                NSString* eventIden = [[NSUserDefaults standardUserDefaults] objectForKey:key];
                
                EKEventStore *eventStore = [[EKEventStore alloc] init];
                [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    granted=YES;
                    if(granted)
                    {
                        EKEvent *event = [eventStore eventWithIdentifier:eventIden];
                        
                        NSString *titleTaskUpdated =[newTaskDic objectForKey:DTOTASK_title];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
                        NSString *startDateTaskUpdated =[newTaskDic objectForKey:DTOTASK_startDate];
                        NSString *endDateTaskUpdated =[newTaskDic objectForKey:DTOTASK_endDate];
                        NSString *startDateEvent = [dateFormatter stringFromDate:event.startDate];
                        NSString *endDateEvent = [dateFormatter stringFromDate:event.endDate];
                        
                        if (![event.title isEqualToString:titleTaskUpdated] || ![startDateTaskUpdated isEqualToString:startDateEvent] || ![endDateTaskUpdated isEqualToString:endDateEvent]) {
                            [eventStore removeEvent:event span:EKSpanFutureEvents error:&error];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:[newTaskDic objectForKey:DTOTASK_id]];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [self addNewEvent];
                            [self setEditing:NO animated:YES];
                        }
                    }
                    
                }];
                if(_dataSend.count>0){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 6;
                    [alert show];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
                    alert.tag = 5;
                    [alert show];
                }
                
            }
        }else {
            [self addNewEvent];
            [self setEditing:NO animated:YES];
            //Thong bao cap nhat thanh cong va thoat
            if(_dataSend.count>0){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 6;
                [alert show];
            }else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
                alert.tag = 5;
                [alert show];
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(reloadListCalendarTask)]) {
            [_delegate reloadListCalendarTask];
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
-(void)addNewEvent
{
    NSMutableArray *resultArr =  [dtoProcess filterTheNewestRecord];
    if (resultArr.count>0) {
        NSMutableDictionary *newTaskDic = [resultArr objectAtIndex:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted){
                //---- codes here when user allow your app to access theirs' calendar.
                EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                event.title     = [StringUtil trimString:_txtName.text];
                
                event.startDate = _startDateTime;
                event.endDate   = _endDateTime;
                
                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                
                // set alarm
                // remove all alarms first
                for (EKAlarm *anAlarm in event.alarms) {
                    [event removeAlarm:anAlarm];
                }
                if (_alarmConfig != nil && _alarmConfig.isReminder && _alarmConfig.reminderNofify)
                {
                    NSDate *alarmDate = [NSDate dateWithTimeInterval:(-_alarmConfig.reminderTime*60) sinceDate:_startDateTime];
                    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:alarmDate];
                    [event addAlarm:alarm];
                }
                
                // set recurrence
                // remove all rules first
                for (EKRecurrenceRule *aRule in event.recurrenceRules) {
                    [event removeRecurrenceRule:aRule];
                }
                if (_repeatConfig != nil && _repeatConfig.isRepeat)
                {
                    [event addRecurrenceRule:_repeatConfig.toEKRecurrenceRule];
                }
                
                NSError *err;
                [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                if (!err) {
                    NSString *key =[newTaskDic objectForKey:DTOTASK_id];
                    NSString *value =event.eventIdentifier;
                    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
            }
        }];
    }
}

- (BOOL)validateBeforeSave
{
    /* returns TRUE if all fields validate OK */
    if ([StringUtil stringIsEmpty:_txtName.text])
    {
        [util showTooltip:_txtName withText:@"Vui lòng nhập tiêu đề lịch" showview:self.view];
        return FALSE;
    }
    else if ([_txtName.text length] > 200)
    {
        [util showTooltip:_txtName withText:@"Vui lòng nhập tiêu đề lịch ít hơn 200 kí tự" showview:self.view];
        return FALSE;
    }
    else if (   [_endDateTime compare:_startDateTime] == NSOrderedAscending
             || [_endDateTime compare:_startDateTime] == NSOrderedSame)
    {
        [util showTooltip:_txtDateFrom withText:@"Vui lòng nhập thời điểm kết thúc sau thời điểm bắt đầu" showview:self.view];
        return FALSE;
    }
    else if (selectStatusIndex < 0)
    {
        [util showTooltip:_txtStatus withText:@"Vui lòng nhập trạng thái của Sự kiện" showview:self.view];
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark - Delegate calls
-(void) homeBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView.tag ==1) {
        
        
    }
    if (succsess && alertView.tag == 5 && buttonIndex == 0) { //thong bao dong form
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (succsess && alertView.tag == 5 && buttonIndex == 1) {
        //reset lai form
        [self resetForm];
    }
    if (alertView.tag==6) {
        [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if ([_listPopover isPopoverVisible])
    {
        [ _listPopover dismissPopoverAnimated:YES];
    }
    
    switch (SELECTED_POPOVER_TAG)
    {
        case TAG_SELECT_STATUS:
        {
            selectStatusIndex = index;
            if (index<statusArray.count)
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
    if (textField == _txtName || textField == _txtDescription)
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
    else if (textField == _txtEventType)
    {
        [_btnChoiceEventType sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtRepeat)
    {
        [_btnChoiceRepeat sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtAlarm)
    {
        [_btnChoiceAlarm sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _txtTypeObject || textField == _txtNameObject)
    {
        //??
    }
    else
    {
        
    }
    
    return FALSE;
}

#pragma mark - AlarmCalendarViewDelegate
- (void)alarmCalendarView:(AlarmCalendarViewController *)alarmCalendarView confirmConfig:(AlarmCalendarConfig *)alarmConfig
{
    _alarmConfig = alarmConfig;
    if (alarmConfig != nil)
    {
        if (alarmConfig.isReminder)
        {
            _txtAlarm.text = [alarmConfig toReadableText];
        }
        else
        {
            _txtAlarm.text = @"";
        }
    }
    [self dismissPopoverView];
}

#pragma mark - RepeatCalendarViewDelegate
- (void)repeatCalendarView:(RepeatCalendarViewController *)repeatCalendarView confirmConfig:(RepeatCalendarConfig *)repeatConfig
{
    _repeatConfig = repeatConfig;
    if (repeatConfig != nil)
    {
        if (repeatConfig.isRepeat)
        {
            _txtRepeat.text = [repeatConfig toReadableText];
        }
        else
        {
            _txtRepeat.text = @"";
        }
    }
    [self dismissPopoverView];
}

@end
