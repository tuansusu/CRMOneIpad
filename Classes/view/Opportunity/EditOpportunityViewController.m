//
//  EditOpportunityViewController.m
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 11/25/14.
//
//

#import "EditOpportunityViewController.h"

#import "DTOSYSCATProcess.h"
#import "DTOACCOUNTProcess.h"
#import "DTOACCOUNTLEADProcess.h"
#import "DTOOPPORTUNITYProcess.h"
#import "CalendarPickerViewController.h"

#define TAG_SELECT_STATUS 1
#define TAG_SELECT_NEXT_JOB 2
#define TAG_SELECT_LEVEL 3
#define TAG_SELECT_CUSOMTER 4

#define TAG_SELECT_CUSTOMER_TYPE_ACCOUNT 5 //KH360
#define TAG_SELECT_CUSTOMER_TYPE_LEAD 6 //KHDM

#define START_DATE 1
#define START_DATE_TIME 2
#define END_DATE 3
#define END_DATE_TIME 4

@interface EditOpportunityViewController ()
{
    int smgSelect ; //option layout
    NSArray *listArrStatus;
    NSArray *listArrNextTask;
    NSArray *listArrLevel;
    NSMutableArray *listCustomerType;
    NSArray *listArrLead;
    NSArray *listArrAccount;
    
    NSString *nowStr;
    NSString*nowTimeStr;
    NSDate *now,*startDate,*endDate ;
    NSDateFormatter *df;
    NSDateFormatter *dfTime;
    NSInteger selectDatePicker;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    DTOSYSCATProcess *dtoSyscatProcess;
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOACCOUNTProcess *dtoAccountProcess;
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    int SELECTED_TAG;
    int CUSTOMER_TYPE;
    
    NSInteger selectStatusIndex;
    NSInteger selectNextTaskIndex;
    NSInteger selectLevelIndex;
    NSInteger selectCustomerIndex;
    
    BOOL succsess;//Trang thai acap nhat
}
@end
@implementation EditOpportunityViewController

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
        
     //  [self.tbData setSeparatorInset:UIEdgeInsetsZero];
        
        
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    
    
//    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];
//    [SVProgressHUD show];
    
    //
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"dd/MM/yyyy"];
    dfTime = [[NSDateFormatter alloc] init];
    [dfTime setDateFormat:@"HH:mm"];
    now = [NSDate date];
    nowStr = [df stringFromDate:now];
    nowTimeStr = [dfTime stringFromDate:now];
    
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    succsess = NO;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];

    
    dtoSyscatProcess = [DTOSYSCATProcess new];
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    dtoAccountProcess = [DTOACCOUNTProcess new];
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    listArrStatus = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_OPPORTTUNITY_STATUS];
    listArrNextTask = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_OPPORTTUNITY_NEXT_TASK];
    listArrLevel = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_OPPORTTUNITY_LEVEL];
    listArrLead = [dtoLeadProcess filter];
    listArrAccount = [dtoAccountProcess filter];
    
    NSDictionary *typeAccount = [NSDictionary dictionaryWithObject:@"Khách hàng 360" forKey:@"Name"];
    NSDictionary *typeLead = [NSDictionary dictionaryWithObject:@"Khách hàng đầu mối" forKey:@"Name"];
    listCustomerType = [NSMutableArray array];
    [listCustomerType addObject:typeAccount];
    [listCustomerType addObject:typeLead];
    
    dataId = 0;

    selectStatusIndex = -1;
    selectNextTaskIndex = -1;
    selectLevelIndex = -1;
    selectLevelIndex = -1;
    
    if (self.dataSend) {
        
        [self loadEditData];
    }else{
        //
       // _txtCode.text = [NSString stringWithFormat:@"%d", [dtoOpportunityProcess getClientId]];
    }
}

//Load thong tin len form sua
-(void) loadEditData {
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_name]]) {
        _txtName.text =[_dataSend objectForKey:DTOOPPORTUNITY_name];
    }
    
    
    
    //start date
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_startDate]]) {
        startDate = [DateUtil getDateFromString:[_dataSend objectForKey:DTOOPPORTUNITY_startDate] :@"yyyy-MM-dd HH:mm:ss.S"];
        _dtStartDate.text = [NSString stringWithFormat:@"%@",
                                 [df stringFromDate:startDate]];
        
        self.txtStartDateTime.text =[NSString stringWithFormat:@"%@",
                                     [dfTime stringFromDate:startDate]];

    }
    
    //end date
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_endDate]]) {
        endDate = [DateUtil getDateFromString:[_dataSend objectForKey:DTOOPPORTUNITY_endDate] :@"yyyy-MM-dd HH:mm:ss.S"];
        _dtEndDate.text = [NSString stringWithFormat:@"%@",
                             [df stringFromDate:startDate]];
        
        self.txtEndDateTime.text =[NSString stringWithFormat:@"%@",
                                     [dfTime stringFromDate:endDate]];
        
    }
    
    //trang thai
    NSString *strStatus = [_dataSend objectForKey:DTOOPPORTUNITY_status];
    if (![StringUtil stringIsEmpty:strStatus]) {
        NSArray *arrayStatusID = [listArrStatus valueForKey:DTOSYSCAT_value];
        selectStatusIndex = [arrayStatusID indexOfObject:strStatus];
        if (selectStatusIndex>=0) {
            NSDictionary *dataStatus = [listArrStatus objectAtIndex:selectStatusIndex];
            _txtStatus.text = [dataStatus objectForKey:DTOSYSCAT_name];
        }
    }
    
    //viec tiep theo
    NSString *strNextTask = [_dataSend objectForKey:DTOOPPORTUNITY_nextTask];
    if (![StringUtil stringIsEmpty:strNextTask]) {
        NSArray *arrayNextTaskID = [listArrNextTask valueForKey:DTOSYSCAT_sysCatId];
        selectNextTaskIndex = [arrayNextTaskID indexOfObject:strNextTask];
        if (selectNextTaskIndex>=0) {
            NSDictionary *dataNextTask = [listArrNextTask objectAtIndex:selectNextTaskIndex];
            _txtNextTask.text = [dataNextTask objectForKey:DTOSYSCAT_name];
        }
    }
    
    //Muc do co hoi
    NSString *strLevel = [_dataSend objectForKey:DTOOPPORTUNITY_opportunityLevelId];
    if (![StringUtil stringIsEmpty:strLevel]) {
        NSArray *arrayLevelID = [listArrLevel valueForKey:DTOSYSCAT_sysCatId];
        selectLevelIndex = [arrayLevelID indexOfObject:strLevel];
        if (selectLevelIndex>=0) {
            NSDictionary *dataLevel = [listArrLevel objectAtIndex:selectLevelIndex];
            _txtLevel.text = [dataLevel objectForKey:DTOSYSCAT_name];
            
            int value = [[dataLevel objectForKey:DTOSYSCAT_value] intValue];
            self.pgLevel.progress = (float)value / 100;
        }
    }

    //Khach hang
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_accountId]]) {
        NSArray *arrayAccountID = [listArrAccount valueForKey:DTOACCOUNT_id];
        selectCustomerIndex = [arrayAccountID indexOfObject:[_dataSend objectForKey:DTOOPPORTUNITY_accountId]];
        if (selectCustomerIndex>=0) {
            NSDictionary *dataAccount = [listArrAccount objectAtIndex:selectCustomerIndex];
            _txtCustomer.text = [dataAccount objectForKey:DTOACCOUNT_name];
        }
    } else if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_leadId]]) {
        NSArray *arrayLeadID = [listArrLead valueForKey:DTOLEAD_leadId];
        selectCustomerIndex = [arrayLeadID indexOfObject:[_dataSend objectForKey:DTOOPPORTUNITY_leadId]];
        if (selectCustomerIndex>=0) {
            NSDictionary *dataLead = [listArrLead objectAtIndex:selectCustomerIndex];
            _txtCustomer.text = [dataLead objectForKey:DTOLEAD_name];
        }
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
-(IBAction)homeBack:(id)sender
{
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
    selectCustomerIndex = -1;
    selectLevelIndex = -1;
    selectNextTaskIndex = -1;
    selectCustomerIndex = -1;
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

- (IBAction)actionChooseStatus:(id)sender {

    SELECTED_TAG = TAG_SELECT_STATUS;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectStatusIndex;
    
    detail.listData = [listArrStatus valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnStatus.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}
- (IBAction)actionChooseNextTask:(id)sender {
    
    SELECTED_TAG = TAG_SELECT_NEXT_JOB;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectNextTaskIndex;
    
    detail.listData = [listArrNextTask valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnNextTask.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
- (IBAction)actionChooseLevel:(id)sender {
    SELECTED_TAG = TAG_SELECT_LEVEL;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectLevelIndex;
    
    detail.listData = [listArrLevel valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnLevel.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionChooseCustomer:(id)sender {
    SELECTED_TAG = TAG_SELECT_CUSOMTER;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = -1;
    
    detail.listData = [listCustomerType valueForKey:@"Name"];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnCustomer.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    switch (SELECTED_TAG) {
        case TAG_SELECT_STATUS:
        {
            selectStatusIndex = index;
            if (index<listArrStatus.count) {
                NSDictionary *dic = [listArrStatus objectAtIndex:index];
                self.txtStatus.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
        case TAG_SELECT_NEXT_JOB:{
            selectNextTaskIndex = index;
            if (index<listArrNextTask.count) {
                NSDictionary *dic = [listArrNextTask objectAtIndex:index];
                self.txtNextTask.text = [dic objectForKey:DTOSYSCAT_name];
            }
        }
            break;
        case TAG_SELECT_LEVEL:{
            selectLevelIndex = index;
            if (index<listArrLevel.count) {
                NSDictionary *dic = [listArrLevel objectAtIndex:index];
                self.txtLevel.text = [dic objectForKey:DTOSYSCAT_name];
                int value = [[dic objectForKey:DTOSYSCAT_value] intValue];
                self.pgLevel.progress = (float)value / 100;
                
            }
        }
            break;
        case TAG_SELECT_CUSOMTER:{
            
            SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
            
            if(index == 0)
            {
                SELECTED_TAG = TAG_SELECT_CUSTOMER_TYPE_ACCOUNT;
                CUSTOMER_TYPE = TAG_SELECT_CUSTOMER_TYPE_ACCOUNT;
                detail.listData = [listArrAccount valueForKey:DTOACCOUNT_name];
                
               
            }
            else if(index == 1)
            {
                SELECTED_TAG = TAG_SELECT_CUSTOMER_TYPE_LEAD;
                CUSTOMER_TYPE = TAG_SELECT_CUSTOMER_TYPE_LEAD;
                detail.listData = [listArrLead valueForKey:DTOLEAD_name];
            }
            
            detail.selectIndex = selectCustomerIndex;
            self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
            CGRect popoverFrame = self.btnCustomer.frame;
            
            detail.delegate =(id<SelectIndexDelegate>) self;
            self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
            [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
            [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            
        }
            break;
        case TAG_SELECT_CUSTOMER_TYPE_ACCOUNT:{
            selectCustomerIndex = index;
            if (index<listArrAccount.count) {
                NSDictionary *dic = [listArrAccount objectAtIndex:index];
                self.txtCustomer.text = [dic objectForKey:DTOACCOUNT_name];
            }
        }
            break;
        case TAG_SELECT_CUSTOMER_TYPE_LEAD:{
            selectCustomerIndex = index;
            if (index<listArrLead.count) {
                NSDictionary *dic = [listArrLead objectAtIndex:index];
                self.txtCustomer.text = [dic objectForKey:DTOLEAD_name];
            }
        }
            break;
        default:
            break;
    }
    
    
    
}


- (IBAction)actionStartDateSelect:(id)sender {
    if (self.dtStartDate.text.length==0) {
        self.dtStartDate.text = nowStr;
        startDate = [NSDate date];
    }else{
        startDate = [DateUtil getDateFromString:self.dtStartDate.text :@"dd/MM/yyyy"];
    }
    
    selectDatePicker = START_DATE;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = startDate;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.dtStartDate.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
- (IBAction)actionEndDateSelect:(id)sender {
    if (self.dtEndDate.text.length==0) {
        self.dtEndDate.text = nowStr;
        endDate = [NSDate date];
    }else{
        endDate = [DateUtil getDateFromString:self.dtEndDate.text :@"dd/MM/yyyy"];
    }
    
    selectDatePicker = END_DATE;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = endDate;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.dtEndDate.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}

- (IBAction)actionEndDateClear:(id)sender {
    self.dtEndDate.text = @"Ngày kết thúc";
    endDate = nil;
}

- (IBAction)actionStartDateClear:(id)sender {
    self.dtStartDate.text = @"Ngày bắt đầu";
    startDate = nil;
}

-(void) selectDatePickerWithDate:(NSDate *)date
{
    
    switch (selectDatePicker) {
        case START_DATE:
            self.dtStartDate.text = [NSString stringWithFormat:@"%@",
                                     [df stringFromDate:date]];
            startDate = date;
            break;
        case START_DATE_TIME:
            self.txtStartDateTime.text =[NSString stringWithFormat:@"%@",
                                         [dfTime stringFromDate:date]];
            startDate = date;
            break;
        case END_DATE:
            self.dtEndDate.text = [NSString stringWithFormat:@"%@",
                                   [df stringFromDate:date]];
            endDate = date;
            break;
        case END_DATE_TIME:
            self.txtEndDateTime.text = [NSString stringWithFormat:@"%@",
                                   [dfTime stringFromDate:date]];
            endDate = date;
            break;
        default:
            break;
    }
    
	
}
-(void) dismissPopoverView
{
    [self dismissPopover];
}
- (void) dismissPopover
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}
- (IBAction)actionSelectStartDateTime:(id)sender {
    if (self.txtStartDateTime.text.length==0) {
//        self.txtStartDateTime.text = nowTimeStr;
//        startDate = [NSDate date];
    }else{
        NSString *strStartDate = [NSString stringWithFormat:@"%@ %@",self.dtStartDate.text,self.txtStartDateTime.text];
        startDate = [DateUtil getDateFromString:strStartDate :@"dd/MM/yyyy HH:mm"];
    }
    
    selectDatePicker = START_DATE_TIME;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = startDate;
    detail.isTimeMode = true;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.txtStartDateTime.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
- (IBAction)actionSelectEndDateTime:(id)sender {
    if (self.txtEndDateTime.text.length==0) {
        //        self.txtStartDateTime.text = nowTimeStr;
        //        startDate = [NSDate date];
    }else{
        NSString *strEndDate = [NSString stringWithFormat:@"%@ %@",self.dtEndDate.text,self.txtEndDateTime.text];
        endDate = [DateUtil getDateFromString:strEndDate :@"dd/MM/yyyy HH:mm"];
    }
    
    selectDatePicker = END_DATE_TIME;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = endDate;
    detail.isTimeMode = true;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.txtEndDateTime.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.mainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)actionSave:(id)sender {
    //check valid to save
    
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    [dicEntity setObject:[StringUtil trimString:self.txtName.text] forKey:DTOOPPORTUNITY_name];
    [dicEntity setObject:[StringUtil trimString:self.txtCode.text] forKey:DTOOPPORTUNITY_code];
    
    //trang thai
    if(selectStatusIndex >=0){
        [dicEntity setObject:[[listArrStatus objectAtIndex:selectStatusIndex] objectForKey:DTOSYSCAT_value] forKey:DTOOPPORTUNITY_status];
    }
    
    //Viec tiep theo
    if(selectNextTaskIndex >= 0){
         [dicEntity setObject:[[listArrNextTask objectAtIndex:selectNextTaskIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOOPPORTUNITY_nextTask];
    }
    
    //Muc do co hoi
    if(selectLevelIndex >= 0){
        [dicEntity setObject:[[listArrLevel objectAtIndex:selectLevelIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOOPPORTUNITY_opportunityLevelId];
    }
    
    //Khach hang
    if(selectCustomerIndex >= 0)
    {
        if(CUSTOMER_TYPE == TAG_SELECT_CUSTOMER_TYPE_ACCOUNT)
        {
             [dicEntity setObject:[[listArrAccount objectAtIndex:selectCustomerIndex] objectForKey:DTOACCOUNT_accountId] forKey:DTOOPPORTUNITY_accountId];
        }
        else if(CUSTOMER_TYPE == TAG_SELECT_CUSTOMER_TYPE_LEAD)
        {
            [dicEntity setObject:[[listArrLead objectAtIndex:selectCustomerIndex] objectForKey:DTOLEAD_leadId] forKey:DTOOPPORTUNITY_leadId];
        }
    }
   
    if(startDate != nil)
    {
        [dicEntity setObject:[DateUtil formatDate:startDate :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOOPPORTUNITY_startDate];
    }
    
    if(endDate != nil)
    {
        [dicEntity setObject:[DateUtil formatDate:endDate :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOOPPORTUNITY_endDate];
    }
        
    [dicEntity setObject:@"1" forKey:DTOOPPORTUNITY_isActive];
    
    
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOOPPORTUNITY_id] forKey:DTOOPPORTUNITY_id];
    }
    succsess = [dtoOpportunityProcess insertToDBWithEntity:dicEntity];
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
@end
