//
//  EditCalendarLeadViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "EditCalendar360ViewController.h"
#import "DTOTASKProcess.h"
#import "DTOSYSCATProcess.H"
#import "DTOACCOUNTLEADProcess.h"
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

@interface EditCalendar360ViewController ()
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

@implementation EditCalendar360ViewController

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
    [self renderControl];
    [self initData];
    
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
    [self.viewRatingStar addSubview:coloredRatingControl];
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
    if (self.dataSend) {
        
        
    }
    
    if(self.dataRoot){
        if(![StringUtil stringIsEmpty:[self.dataRoot objectForKey:DTOLEAD_leadType]]){
            if([ObjectToStr([self.dataRoot objectForKey:DTOLEAD_leadType]) isEqualToString:FIX_LEADTYPE_PERSON]){
                self.txtTypeObject.text = SELECT_TEXT_ADD_PERSON;
            }else{
                self.txtTypeObject.text = SELECT_TEXT_ADD_BUSSINESS;
            }
        }
        
        self.txtNameObject.text = [self.dataRoot objectForKey:DTOLEAD_name];
    }
    
    
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
    
    
    //[self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    //[self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    //for (UIView *viewSubTemp in self.headerMainView.subviews) {
        
        
        //if ([viewSubTemp isKindOfClass:[UILabel class]]) {
          //  ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        //}
    //}
    
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
    [dicEntity setObject:@"5" forKey:DTOTASK_formal];
    
    
    
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

@end
