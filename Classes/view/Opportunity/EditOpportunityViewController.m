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

#define TAG_SELECT_TYPE 1
#define TAG_SELECT_NEXT_JOB 2
#define TAG_SELECT_LEVEL 3
#define TAG_SELECT_CUSOMTER 4

#define TAG_SELECT_CUSTOMER_TYPE_ACCOUNT 5 //KH360
#define TAG_SELECT_CUSTOMER_TYPE_LEAD 6 //KHDM

#define START_DATE 1
#define START_DATE_TIME 2
#define END_DATE 3
#define END_DATE_TIME 4

@interface EditOpportunityViewController ()<UITableViewDelegate>
{
    int smgSelect ; //option layout
    NSArray *listArrType;
    NSArray *listArrNextTask;
    NSArray *listArrLevel;
    NSMutableArray *listCustomerType;
    NSArray *listArrLead;
    NSArray *listArrAccount;
    NSMutableArray *listArrCustomerFilter;
    
    NSString *nowStr;
    NSString*nowTimeStr;
    NSDate *now,*startDate,*endDate ;
    NSDateFormatter *df;
    NSDateFormatter *dfTime;
    NSInteger selectDatePicker;
    
    NSUserDefaults *defaults ;
    
    DTOSYSCATProcess *dtoSyscatProcess;
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    DTOACCOUNTProcess *dtoAccountProcess;
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    int SELECTED_TAG;
    int CUSTOMER_TYPE;
    
    NSInteger selectTypeIndex;
    NSInteger selectNextTaskIndex;
    NSInteger selectLevelIndex;
    NSInteger selectCustomerIndex;
    NSDictionary *selectedCustomer;
    
    BOOL succsess;//Trang thai acap nhat
    
    MDSearchBarController *searchBarController;
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
    
    searchBarController = [MDSearchBarController new];
    searchBarController.searchBarView.frame = self.txtSearchCustomer.frame;
    [self.txtSearchCustomer.superview addSubview:searchBarController.searchBarView];
    [self.txtSearchCustomer removeFromSuperview];
    searchBarController.delegate= self;
    
    self.txtSearchCustomer = searchBarController.searchBarView;
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    
    searchBarController.isValid = NO;
    
    if (self.dataSend) {
        
        self.fullNameLB.text = @"CHỈNH SỬA CƠ HỘI";
    }
    else{
        self.fullNameLB.text = @"THÊM MỚI CƠ HỘI";
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    UITapGestureRecognizer *tapImageRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissPopUp)];
    [self.view addGestureRecognizer:tapImageRecognizer];
}

-(void)dismissPopUp
{
    //your dimiss code here
    if(!searchBarController.isValid){
        self.txtCustomer.text = @"";
    }
    searchBarController.active = NO;
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
    listArrType = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_OPPORTTUNITY_TYPE];
    listArrNextTask = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_OPPORTTUNITY_NEXT_TASK];
    listArrLevel = [dtoSyscatProcess filterWithCatType:FIX_SYS_CAT_TYPE_OPPORTTUNITY_LEVEL];
    listArrLead = [dtoLeadProcess filter];
    listArrAccount = [dtoAccountProcess filter];
    listArrCustomerFilter = (NSMutableArray*)listArrAccount;
    
    NSDictionary *typeAccount = [NSDictionary dictionaryWithObject:@"Khách hàng 360" forKey:@"Name"];
    NSDictionary *typeLead = [NSDictionary dictionaryWithObject:@"Khách hàng đầu mối" forKey:@"Name"];
    listCustomerType = [NSMutableArray array];
    [listCustomerType addObject:typeAccount];
    [listCustomerType addObject:typeLead];
    
    
    selectTypeIndex = -1;
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
    
    
    
    //Customer
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_accountId]]) {
        NSString *customerId = [_dataSend objectForKey:@"accountId"];
        if([StringUtil stringIsEmpty:customerId])
        {
            customerId = [_dataSend objectForKey:@"clientAccountId"];
        }
        NSArray *arrayAccountID = [listArrAccount valueForKey:DTOACCOUNT_accountId];
        selectCustomerIndex = [arrayAccountID indexOfObject:customerId];
        if (selectCustomerIndex>=0 && selectCustomerIndex < 2147483647) {
            selectedCustomer = [listArrAccount objectAtIndex:selectCustomerIndex];
            self.txtSearchCustomer.textField.text = [selectedCustomer objectForKey:DTOACCOUNT_name];
            searchBarController.isValid = YES;
        }
    } else if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITY_leadId]]) {
        NSString *customerId = [_dataSend objectForKey:@"leadId"];
        if([StringUtil stringIsEmpty:customerId])
        {
            customerId = [_dataSend objectForKey:@"clientLeadId"];
        }
        NSArray *arrayLeadID = [listArrLead valueForKey:DTOLEAD_leadId];
        selectCustomerIndex = [arrayLeadID indexOfObject:customerId];
        if (selectCustomerIndex>=0 && selectCustomerIndex < 2147483647) {
            selectedCustomer = [listArrLead objectAtIndex:selectCustomerIndex];
            self.txtSearchCustomer.textField.text = [selectedCustomer objectForKey:DTOLEAD_name];
            searchBarController.isValid = YES;

        }
    }
    
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
    
    //Kiểu cơ hội
    NSString *strType = [_dataSend objectForKey:@"TypeCode"];
    if (![StringUtil stringIsEmpty:strType]) {
        NSArray *arrayTypeID = [listArrType valueForKey:DTOSYSCAT_value];
        selectTypeIndex = [arrayTypeID indexOfObject:strType];
        if (selectTypeIndex>=0) {
            NSDictionary *dataType = [listArrType objectAtIndex:selectTypeIndex];
            self.txtType.text = [dataType objectForKey:DTOSYSCAT_name];
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
    
    //Description
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:@"Description"]]) {
        self.txtNote.text =[_dataSend objectForKey:@"Description"];
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
    selectTypeIndex = -1;
    succsess = false;
    
    [self hiddenKeyBoard];
    
}

-(void) hiddenKeyBoard {
    for (UIView *viewTemp in _bodyMainView.subviews) {
        for (UIView *subViewTemp in viewTemp.subviews) {
            
            if (([subViewTemp isKindOfClass:[UITextField class]])) {
                [(UITextField *)subViewTemp resignFirstResponder];
            }
            
            if ((([subViewTemp isKindOfClass:[MDSearchBar class]]))) {
                [(MDSearchBar *)subViewTemp resignFirstResponder];
            }
            
            
        }
    }
    
    [self.txtSearchCustomer resignFirstResponder];
    [self.txtSearchCustomer endEditing:YES];
    
    for (UIView *viewTemp in self.txtSearchCustomer.subviews) {
        [viewTemp endEditing:YES];
    }
    
    
}
- (IBAction)actionChooseType:(id)sender {
    
    [self hiddenKeyBoard];
    
    SELECTED_TAG = TAG_SELECT_TYPE;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectTypeIndex;
    
    detail.listData = [listArrType valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnType.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (IBAction)actionCustomerQuerySearch:(id)sender {
    
    for (UIView *subView in self.viewMainBodyInfo.subviews){
        //if (subView.tag == 80) {
        if([subView isKindOfClass:[UITableView class]]){
            [subView removeFromSuperview];
            //subView.hidden = NO;
            break;
        }
    }
    //
    //    QuickSearchViewcontroller *detail = [[QuickSearchViewcontroller alloc] initWithNibName:@"QuickSearchViewcontroller" bundle:nil];
    //    detail.delegate =(id<SelectIdDelegate>) self;
    //    //self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    //
    //    NSPredicate *keyPred = [NSPredicate predicateWithFormat: [NSString stringWithFormat:@"name contains[c] '%@'",self.txtCustomer.text]];
    //
    //    detail.listData = [[listArrAccount filteredArrayUsingPredicate: keyPred] valueForKey:DTOACCOUNT_name];
    //
    //
    //
    ////    detail.view.frame = CGRectMake(self.txtCustomer.frame.origin.x -20, self.txtCustomer.frame.origin.y + self.txtCustomer.frame.size.height, self.txtCustomer.frame.size.width + 20, 400);
    ////    [self.viewMainBodyInfo addSubview:detail.view];
    //
    //
    //    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.txtCustomer.frame;
    
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
}

- (IBAction)actionChooseNextTask:(id)sender {
    
    [self hiddenKeyBoard];
    
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
    
    [self hiddenKeyBoard];
    
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

#pragma mark SelectIdDelegate
-(void) selectAtId:(NSInteger)id{
    NSPredicate *keyPred = [NSPredicate predicateWithFormat: [NSString stringWithFormat:@"id =  %d",id]];
    
    
    NSDictionary *selected = [[listArrAccount filteredArrayUsingPredicate: keyPred] firstObject];
    self.txtCustomer.text = [selected objectForKey:@"name"];
}


#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    switch (SELECTED_TAG) {
        case TAG_SELECT_TYPE:
        {
            selectTypeIndex = index;
            if (index<listArrType.count) {
                NSDictionary *dic = [listArrType objectAtIndex:index];
                self.txtType.text = [dic objectForKey:DTOSYSCAT_name];
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
        default:
            break;
    }
    
    
    
}


- (IBAction)actionStartDateSelect:(id)sender {
    [self hiddenKeyBoard];
    
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
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
- (IBAction)actionEndDateSelect:(id)sender {
    
    [self hiddenKeyBoard];
    
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
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.viewMainBodyInfo permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (IBAction)actionEndDateClear:(id)sender {
    
    [self hiddenKeyBoard];
    
    
    self.dtEndDate.text = @"";
    endDate = nil;
}

- (IBAction)actionStartDateClear:(id)sender {
    
    [self hiddenKeyBoard];
    
    self.dtStartDate.text = @"";
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


- (IBAction)actionSave:(id)sender {
    //check valid to save
    if(![self checkValidToSave]){
        return;
    }
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    if(selectedCustomer > 0){
    if(selectTypeIndex >= 0){
        if([[[listArrType objectAtIndex:selectTypeIndex] objectForKey:@"code"] isEqualToString:@"NEW"]){
            //Luu la khach hang dau moi
            //clientLeadId
            [dicEntity setObject:[selectedCustomer objectForKey:@"clientLeadId"] forKey:@"clientLeadId"];
            //leadId
            [dicEntity setObject:[selectedCustomer objectForKey:@"leadId"] forKey:@"leadId"];
        }else{
            //accountId
            [dicEntity setObject:[selectedCustomer objectForKey:@"accountId"] forKey:DTOOPPORTUNITY_accountId];
        }
    }
    }
    //client
    [dicEntity setObject:@"1" forKey:DTOOPPORTUNITY_client];
     //clientOpportunityId
    if(self.dataSend){
        [dicEntity setObject:[self.dataSend objectForKey:DTOOPPORTUNITY_clientOpportunityId] forKey:DTOOPPORTUNITY_clientOpportunityId];
    }else{
   
        NSString *strClientOpportunityId = IntToStr(([dtoOpportunityProcess getClientId]));
        [dicEntity setObject:strClientOpportunityId forKey:DTOOPPORTUNITY_clientOpportunityId];
    }
    //description
    [dicEntity setObject:[StringUtil trimString:self.txtNote.text] forKey:DTOOPPORTUNITY_description];
    //employeeId - Ma cua RM tao CHBH
    [dicEntity setObject:@"0" forKey:DTOOPPORTUNITY_employeeId]; //Hien tai chua lam phan dang nhap nen truogn nay tam thoi de trong
    //endDate
    if(endDate != nil)
    {
        [dicEntity setObject:[DateUtil formatDate:endDate :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOOPPORTUNITY_endDate];
    }
    //isActive
    [dicEntity setObject:@"1" forKey:DTOOPPORTUNITY_isActive];
    //languageId
    [dicEntity setObject:@"1" forKey:DTOOPPORTUNITY_languageId];
    //name
    [dicEntity setObject:[StringUtil trimString:self.txtName.text] forKey:DTOOPPORTUNITY_name];
    //needSupport
    [dicEntity setObject:@"1" forKey:DTOOPPORTUNITY_needSupport];
    //nextTask
    if(selectNextTaskIndex >= 0){
        [dicEntity setObject:[[listArrNextTask objectAtIndex:selectNextTaskIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOOPPORTUNITY_nextTask];
    }
    //opportunityLevelId
    if(selectLevelIndex >= 0){
        [dicEntity setObject:[[listArrLevel objectAtIndex:selectLevelIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOOPPORTUNITY_opportunityLevelId];
    }
    //startDate
    if(startDate != nil)
    {
        [dicEntity setObject:[DateUtil formatDate:startDate :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOOPPORTUNITY_startDate];
    }
    //status
    [dicEntity setObject:@"3" forKey:DTOOPPORTUNITY_status];//Da duyet
    //successPercent
    if (selectLevelIndex>=0) {
        NSDictionary *dataLevel = [listArrLevel objectAtIndex:selectLevelIndex];
        [dicEntity setObject:[dataLevel objectForKey:DTOSYSCAT_value] forKey:DTOOPPORTUNITY_successPercent];
    }
    //sysOrganizationId - Id don  vi thao CHBH
    [dicEntity setObject:@"0" forKey:DTOOPPORTUNITY_successPercent];
    //type
    if(selectTypeIndex >=0){
        [dicEntity setObject:[[listArrType objectAtIndex:selectTypeIndex] objectForKey:DTOSYSCAT_value] forKey:DTOOPPORTUNITY_type];
    }
    
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
        [self showTooltip:self.txtName withText:@"Anh/Chị chưa nhập tên cơ hội"];
        [self.txtName becomeFirstResponder];
        [self setBorder:self.txtName];
        return NO;
    }
    if(startDate == nil){
        [self showTooltip:self.dtStartDate withText:@"Anh/Chị chưa nhập ngày bắt đầu"];
        [self.dtStartDate becomeFirstResponder];
        [self setBorder:self.dtStartDate];
        return NO;

    }
    if(endDate == nil){
        [self showTooltip:self.dtEndDate withText:@"Anh/Chị chưa nhập ngày kết thúc"];
        [self.dtEndDate becomeFirstResponder];
        [self setBorder:self.dtEndDate];
        return NO;
        
    }
    
    
    NSDateComponents *componentsStartDate = [[NSCalendar currentCalendar]
                                    components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                    fromDate:startDate];
    startDate = [[NSCalendar currentCalendar]
                 dateFromComponents:componentsStartDate];
    
    NSDateComponents *componentsEndDate = [[NSCalendar currentCalendar]
                                             components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                             fromDate:endDate];
    endDate = [[NSCalendar currentCalendar]
                 dateFromComponents:componentsEndDate];
    
    NSComparisonResult result = [startDate compare:endDate];
    
    if(result==NSOrderedDescending){
        [self showTooltip:self.dtEndDate withText:@"Ngày kết thúc không được nhỏ hơn ngày bắt đầu"];
        [self.dtEndDate becomeFirstResponder];
        [self setBorder:self.dtEndDate];
        return NO;
    }
    
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArrCustomerFilter.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return 80;
    return 40;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [[listArrCustomerFilter objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
    
    
//    static NSString *cellId = @"CustomerCell";
//    CustomerCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
//    
//    
//    if (!cell) {
//        cell = [CustomerCell initNibCell];
//    }
//    
//    NSDictionary *customer = [listArrCustomerFilter objectAtIndex:indexPath.row];
//    
//    cell.lblName.text = [customer objectForKey:@"name"];
//    cell.lblMobile.text = [customer objectForKey:@"mobile"];
//    cell.lblCode.text =[customer objectForKey:@"code"];
//    return cell;

}


-(void)searchBar:(MDSearchBarController *)searchBarController searchWithText:(NSString *)text{
    if(selectTypeIndex < 0)
    {
        listArrCustomerFilter = [NSMutableArray new];
        [self showTooltip:self.txtSearchCustomer withText:@"Bạn cần chọn loại cơ hội trước khi chọn khách hàng"];
        [self.txtType becomeFirstResponder];
        return;
    }
    
    NSPredicate *keyPred = [NSPredicate predicateWithFormat: [NSString stringWithFormat:@"name contains[c] '%@'",text]];
    NSDictionary *oppType = [listArrType objectAtIndex:selectTypeIndex];
    if([[oppType objectForKey:@"code"] isEqualToString:@"NEW"])
    {
        listArrCustomerFilter = [listArrLead filteredArrayUsingPredicate: keyPred];
    }
    else
    {
        listArrCustomerFilter = [listArrAccount filteredArrayUsingPredicate: keyPred];
    }
    [searchBarController reloadData];
    searchBarController.isValid = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedCustomer = [listArrCustomerFilter objectAtIndex:indexPath.row];
    self.txtSearchCustomer.textField.text = [selectedCustomer objectForKey:@"name"];
    searchBarController.active = NO;
    searchBarController.isValid = YES;
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
@end
