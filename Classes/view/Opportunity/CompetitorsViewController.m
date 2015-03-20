//
//  CompetitorsViewController.m
//  OfficeOneStudy
//
//  Created by viettel on 11/7/14.
//
//

#import "CompetitorsViewController.h"
#import "DTOOPPORTUNITYProcess.h"
#import "DTOCOMPETITORProcess.h"
#import "DTOPRODUCTMASTERProcess.h"
#import "DTOACCOUNTProcess.h"
#import "DTOCONTACTProcess.h"
#import "DTOTASKProcess.h"
#import "DTOOPPORTUNITYPRODUCTProcess.h"
#import "DTOOPPORTUNITYCONTACTProcess.h"
#import "DTONOTEProcess.h"

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_PRODUCT @"SẢN PHẨM ĐỀ XUẤT"
#define SELECT_TEXT_ADD_CALENDAR @"SẢN PHẨM ĐÃ BÁN"
#define SELECT_TEXT_ADD_COMPETITOR @"CÔNG VIỆC"
#define SELECT_TEXT_ADD_NOTE @"GHI CHÚ"
#define SELECT_TEXT_ADD_SUPORT @"LỊCH"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_PRODUCT 1
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_NOTE 4
#define SELECT_INDEX_ADD_CALENDAR 5


static NSString* const TaskCalendarNormalCellId   = @"TaskCalendarCellId";
static NSString* const TaskCalendarTimelineCellId = @"TaskCalTLineCellId";
static NSString* const TaskActionCellId           = @"TaskActionCellId";

@interface CompetitorsViewController ()
{
    int smgSelect ; //option layout
    
    NSDictionary *opportunity;
    
    NSArray *arrayData; //mang luu tru du lieu
    
    
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    DTOCOMPETITORProcess *dtoCompetitorProcess;
    DTOPRODUCTMASTERProcess *dtoProductMasterProcess;
    DTOACCOUNTProcess *dtoAccountProcess;
    DTOCONTACTProcess *dtoContactProcess;
    DTOOPPORTUNITYPRODUCTProcess *dtoOpportunityProductProcess;
    DTOTASKProcess *dtoTaskProcess;
    DTOOPPORTUNITYCONTACTProcess *dtoOpportunityContactProcess;
    DTONOTEProcess *dtoNoteProcess;
    
    UIColor *textColorButtonNormal; //mau chu button binh thuong
    UIColor *textColorButtonSelected; //mau chu button select
    UIColor *backgrondButtonSelected; //mau nen button select
    UIColor *backgroundButtonNormal; //Mau nen button binh thuong
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    //item danh dau se xoa
    NSString *deleteItemId;
    BOOL isMainDelete;
    
    //calendar
    BOOL calendarIsTimeline;
    
    NSUserDefaults *defaults ;
 
}
@end

@implementation CompetitorsViewController

@synthesize typeActionEvent,itemId;


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
        
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    
    
    
    
    //Load table cua iphone
    if(self.currentDeviceType == iPhone){
        [self.leftInMainView addSubview: self.viewTableIphone];
        self.viewTableIphone.frame  = CGRectMake(0, self.scrollViewInfo.frame.origin.y, self.viewTableIphone.frame.size.width, self.viewTableIphone.frame.size.height);
    }
    
    self.viewTableIphone.hidden = YES;
    
    [self.tabBarItems setSelectedItem:self.tabBarItems.items[0]];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self loadData];
    [self actionClueContact:self.btnClueContact];
    
    [self.scrollViewInfo setBackGroundNormalColorWithOption:smgSelect];
    [self setBottomLineDetail:self.scrollViewInfo];
    [self.rightInMainView setBorderWithOption:smgSelect];
    //    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];
    
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // calendar
    calendarIsTimeline = YES;
    

    
   
    
    [self setLanguage];
}
-(void) loadData{
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    NSDateFormatter *DateToDisplayFormatter=[[NSDateFormatter alloc] init];
    [DateToDisplayFormatter setDateFormat:@"dd/MM/yyyy"];
    float fyDN=self.lblCode.frame.origin.y;
    //Hien thi chi tiet thong tin co hoi
    //code
    //self.lblCode.text = [opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId];
    fyDN = [self setFrameLabelTitle:self.lblTitleCode withLabelValue:self.lblCode withFY:fyDN :[opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId]];
    //name
    //self.lblName.text = [opportunity objectForKey:DTOOPPORTUNITY_name];
     fyDN = [self setFrameLabelTitle:self.lblTitleName withLabelValue:self.lblName withFY:fyDN :[opportunity objectForKey:DTOOPPORTUNITY_name]];
    //startDate
    NSString *strStartDate= [opportunity objectForKey:DTOOPPORTUNITY_startDate];
    NSDate *startDate =[DateFormatter dateFromString:strStartDate];
    //self.lblStartDateDetail.text = [DateToDisplayFormatter stringFromDate:startDate];
    [self.imgStartDate setFrame:CGRectMake(self.imgStartDate.frame.origin.x,fyDN, self.imgStartDate.frame.size.width, self.imgStartDate.frame.size.height)];
    fyDN = [self setFrameLabelTitle:self.lblStartDateTitle withLabelValue:self.lblStartDateDetail withFY:fyDN :[DateToDisplayFormatter stringFromDate:startDate]];
    
    //endDateReal
    NSString *strEndDateReal = [opportunity objectForKey:DTOOPPORTUNITY_endDateReal];
    NSDate *endDateReal = [DateFormatter dateFromString:strEndDateReal];
    //self.lblEndDateDetail.text = [DateToDisplayFormatter stringFromDate:endDateReal];
    [self.imgEndDateReal setFrame:CGRectMake(self.imgEndDateReal.frame.origin.x,fyDN, self.imgEndDateReal.frame.size.width, self.imgEndDateReal.frame.size.height)];
     fyDN = [self setFrameLabelTitle:self.lblEndDateRealTitle withLabelValue:self.lblEndDateRealDetail withFY:fyDN :[DateToDisplayFormatter stringFromDate:endDateReal]];
    
    //endDate
    NSString *strEndDate = [opportunity objectForKey:DTOOPPORTUNITY_endDate];
    NSDate *endDate = [DateFormatter dateFromString:strEndDate];
    //self.lblEndDateDetail.text = [DateToDisplayFormatter stringFromDate:endDate];
    [self.imgEndDate setFrame:CGRectMake(self.imgEndDate.frame.origin.x,fyDN, self.imgEndDate.frame.size.width, self.imgEndDate.frame.size.height)];
    fyDN = [self setFrameLabelTitle:self.lblEndDateTitle withLabelValue:self.lblEndDateDetail withFY:fyDN :[DateToDisplayFormatter stringFromDate:endDate]];
    
    //Level
    //self.lblOpporttunityLevelDetail.text = [opportunity objectForKey:@"Level"];
    fyDN = [self setFrameLabelTitle:self.lblOpportunityLevelTitle withLabelValue:self.lblOpporttunityLevelDetail withFY:fyDN :[opportunity objectForKey:@"Level"]];
    //NextTask
    //self.lblNextTaskDetail.text = [opportunity objectForKey:@"NextTaskName"];
    fyDN = [self setFrameLabelTitle:self.lblNextTaskTitle withLabelValue:self.lblNextTaskDetail withFY:fyDN :[opportunity objectForKey:@"NextTaskName"]];
    //Type
    //self.lblTypeDetail.text = [opportunity objectForKey:@"Type"];
    fyDN = [self setFrameLabelTitle:self.lblTypeTitle withLabelValue:self.lblTypeDetail withFY:fyDN :[opportunity objectForKey:@"Type"]];
    //Customer
    //self.lblCustomerDetail.text = [opportunity objectForKey:@"Customer"];
    fyDN = [self setFrameLabelTitle:self.lblCustomerTitle withLabelValue:self.lblCustomerDetail withFY:fyDN :[opportunity objectForKey:@"Customer"]];
    //Description
    NSString *description = [opportunity objectForKey:@"Description"];
    if([StringUtil stringIsEmpty:description]){
        description = @"NA";
    }
    fyDN = [self setFrameLabelTitle:self.lblNoteTitle withLabelValue:self.lblNoteDetail withFY:fyDN :description];
    //ResultDescription
    NSString *resultDescription = [opportunity objectForKey:@"ResultDescription"];
    if([StringUtil stringIsEmpty:resultDescription]){
        resultDescription = @"NA";
    }
    fyDN = [self setFrameLabelTitle:self.lblDescriptionTitle withLabelValue:self.lblDescriptionDetail withFY:fyDN :resultDescription];
}

-(void) viewWillAppear:(BOOL)animated{
    // [self viewDidLoad];
    [self loadDataWithTypeAction:typeActionEvent];
}

-(void) viewDidAppear:(BOOL)animated{
    [self initData];
    [self loadData];
    [self loadDataWithTypeAction:typeActionEvent];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_PRODUCT, SELECT_TEXT_ADD_CALENDAR,SELECT_TEXT_ADD_COMPETITOR,SELECT_TEXT_ADD_NOTE,SELECT_TEXT_ADD_SUPORT, nil];
    
   // [self actionClueContact:self.btnClueContact];
    
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    dtoCompetitorProcess = [DTOCOMPETITORProcess new];
    dtoProductMasterProcess = [DTOPRODUCTMASTERProcess new];
    dtoAccountProcess  = [DTOACCOUNTProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    dtoOpportunityProductProcess = [DTOOPPORTUNITYPRODUCTProcess new];
    dtoTaskProcess = [DTOTASKProcess new];
    dtoOpportunityContactProcess = [DTOOPPORTUNITYCONTACTProcess new];
    dtoNoteProcess = [DTONOTEProcess new];
    
    opportunity = [dtoOpportunityProcess getById:itemId];
    
    arrayData  = [NSArray new];
    isMainDelete = NO;
}


-(void) loadDataWithTypeAction : (enum TypeActionEvent) inputTypeActionEvent{
    typeActionEvent = inputTypeActionEvent;
    switch (typeActionEvent) {
        case type_ClueContact:
        {
            //arrayData = [dtoAccountProcess filter];
            arrayData = [dtoContactProcess filterWithClientOpportunityId:[opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId]];
        }break;
        case type_ProposeProduct:
        {
            arrayData = [dtoOpportunityProductProcess filterWithClientOpportunityId:[opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId]];
        }
            break;
        case type_Sale:
        {
            arrayData = [NSArray new];
        }
            break;
        case type_Task:
        {
            //arrayData = [dtoAccountProcess filter];
            arrayData = [dtoTaskProcess filterWithKey:DTOTASK_opportunityId withValue:[opportunity objectForKey:DTOOPPORTUNITY_id]];
        }break;
        case type_Note:
        {
            //load data la ghi chu
            arrayData = [dtoNoteProcess filterWithOpportunityId:[opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId]];
        }break;
        case type_Calendar:
        {
            arrayData = [dtoTaskProcess filterTaskWithClientOpportunityId:[opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId]];
        }
            break;
            
        default:
            break;
    }
    
    [self.tbData reloadData];
}


- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = @"CƠ HỘI BÁN HÀNG"; //TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    //[self.btnSearch setStyleNormalWithOption:smgSelect];
    // [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    // self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    
    textColorButtonNormal = TEXT_BUTTON_COLOR_BLACK_1; //mau chu button binh thuong
    textColorButtonSelected = TEXT_BUTTON_COLOR1; //mau chu button select
    backgrondButtonSelected = BUTTON_ACTIVE_COLOR_1;
    backgroundButtonNormal = BUTTON_REPORT_MAIN_IN_ACTIVE_COLOR_1;
    
    for (UIView *viewTemp in self.scrollViewInfo.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
            [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
        }
        if ([viewTemp isKindOfClass:[UITextView class]]) {
            ((UITextView*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextView*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewTemp isKindOfClass:[UITextField class]]) {
            ((UITextField*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextField*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextField*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextField*) viewTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewTemp) setAlpha:1.0f];
        }

    }
    
    [self.rightViewHeader setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
    self.footeView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
     self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    
    switch (index) {
        case SELECT_INDEX_ADD_CONTACT:
        {
            typeActionEvent = type_ClueContact;
            EditContactOpportunityViewController *viewController = [[EditContactOpportunityViewController alloc]initWithNibName:@"EditContactOpportunityViewController" bundle:nil];
            viewController.dataRoot = opportunity;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_PRODUCT:
        {
            typeActionEvent = type_ProposeProduct;
            EditOpportunityProductViewController *viewController = [[EditOpportunityProductViewController alloc]initWithNibName:@"EditOpportunityProductViewController" bundle:nil];
            viewController.dataRoot = opportunity;
            viewController.delegateOpportunityProduct = (id<OpportunityProductDelegate>)self;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_TASK:
        {
            typeActionEvent = type_Task;
            EditOpportunityTaskViewController *viewController = [[EditOpportunityTaskViewController alloc]initWithNibName:@"EditOpportunityTaskViewController" bundle:nil];
            viewController.dataRoot = opportunity;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_NOTE:
        {
            typeActionEvent = type_Note;
            EditNoteOpportunityViewController *viewController = [[EditNoteOpportunityViewController alloc]initWithNibName:@"EditNoteOpportunityViewController" bundle:nil];
            viewController.dataRoot = opportunity;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_CALENDAR:
        {
            EditCalendarOpportunityViewController *viewController = [[EditCalendarOpportunityViewController alloc]initWithNibName:@"EditCalendarOpportunityViewController" bundle:nil];
            [viewController setDelegate:self];
            viewController.dataRoot = opportunity;
            viewController.isKH360 = YES;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}



#pragma mark action button
- (IBAction)homeBack:(id)sender {
    // [Util backToHome:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)actionClueContact:(UIButton *)sender {
    [self loadDataWithTypeAction:type_ClueContact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionProposeProduct:(UIButton *)sender {
    [self loadDataWithTypeAction:type_ProposeProduct];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionActionSale:(UIButton *)sender {
    [self loadDataWithTypeAction:type_Sale];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionTask:(UIButton *)sender {
    [self loadDataWithTypeAction:type_Task];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionCalendar:(UIButton*)sender {
    if (typeActionEvent == type_Calendar)
    {
        calendarIsTimeline = !calendarIsTimeline;
    }
    [self loadDataWithTypeAction:type_Calendar];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionNote:(id)sender {
    [self loadDataWithTypeAction:type_Note];
    [self displayNormalButtonState:sender];
    
}




#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in self.rightViewHeader.subviews) {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            [((UIButton*) viewTemp) setBackgroundColor:[UIColor whiteColor]];
            [((UIButton*) viewTemp) setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
            [((UIButton*) viewTemp) setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
        }
    }
    [btnSelect setBackgroundColor:[UIColor whiteColor]];
    [btnSelect setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
    [btnSelect setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:5.0f withBorderFlag:AUISelectiveBordersFlagBottom];
}



#pragma mark table view

#pragma mark - Table View

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(arrayData.count == 0)
        return tableView.frame.size.height;
    
    switch (typeActionEvent) {
        case type_ProposeProduct:{
            if(self.currentDeviceType == iPhone){
                return 40.0f;
            }else{
                return 50.0f;
            }
        }break;
            
        case type_ClueContact:{
            if(self.currentDeviceType == iPhone){
                return 60.0f;
            }else{
                return 100.0f;
            }
        }
            break;
        case type_Task:{
            if(self.currentDeviceType == iPhone){
                return 50.0f;
            }else{
                return 80.0f;
            }
        }
            break;
        case type_Note:{
            if(self.currentDeviceType == iPhone){
                return 45.0f;
            }else{
                return 60.0f;
            }
            
        }
            break;
        case type_Calendar:{
            if (calendarIsTimeline)
            {
                return 225.0f;
            }
            else
            {
                return 66.0f;
            }
        }
            break;
        default:
            break;
    }
    return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (arrayData.count == 0) {
        return  1;
    }else{
        return arrayData.count;
    }
    
}
/**
 *  Bat Swipe right de cho phep hien thi button xoa 1 row
 *  @return YES: If you want the specified item to be editable.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/**
 *  Xu ly khi click Button Accessory (tren ios6, xem trong cellForRow co code set AccessoryType cho cell neu khong phai la Header)
 *  TRUONG HOP NAY HIEN TAI KHONG DUNG DEN MA SU DUNG 1 CUSTOM BUTTON VOI ACTION "customButtonAccessoryTapped"
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SYS_KEY_DELETE;
}

/**
 *  Them 1 button "Sua" ben canh button "Xoa" (tren ios7, ios6 su dung accessoryType)
 */
-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  Neu khong phai la Header thi la item level 2
     */
    return SYS_KEY_EDIT;
    //return nil;
}
- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //set empty cell
    if (arrayData.count == 0) {
        static NSString *cellId = @"EmptyCell";
        EmptyCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
        
        
        if (!cell) {
            cell = [EmptyCell initNibCell];
        }
        
        [cell loadDataToCellWithData:@"" withOption:smgSelect];
        
        return cell;
    }
    
    
    
    switch (typeActionEvent) {
        case type_ClueContact:{
            static NSString *cellId = @"ContactOpportunityCell";
            ContactOpportunityCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ContactOpportunityCell initNibCell];
            }
            if (!cell) {
                cell = [EmptyCell initNibCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
            
        }
            break;
        case type_ProposeProduct:
        {
            static NSString *cellId = @"ProposeProductCell";
            ProposeProductCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ProposeProductCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        case type_Sale:
        {
            static NSString *cellId = @"saleCell";
            ProposeProductCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ProposeProductCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
            
            
        case type_Task:
        {
            static NSString *cellId = @"TaskOpportunityCell";
            TaskOpportunityCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [TaskOpportunityCell getNewCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
        case type_Note:
        {
            static NSString *cellId = @"NoteOpportunityCell";
            NoteOpportunityCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [NoteOpportunityCell initNibCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
            
        case type_Calendar:
        {
            if (calendarIsTimeline)
            {
                TaskCalTLineCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskCalendarTimelineCellId];
                
                if (indexPath.row < arrayData.count)
                {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                    if (indexPath.row == 0)
                    {
                        cell.tbv_position = TaskCalTLineCell_Top;
                    }
                    else if (indexPath.row == arrayData.count - 1)
                    {
                        cell.tbv_position = TaskCalTLineCell_Bottom;
                    }
                    else
                    {
                        cell.tbv_position = TaskCalTLineCell_Middle;
                    }
                }
                
                return cell;
            }
            else
            {
                TaskCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskCalendarNormalCellId];
                
                if (indexPath.row < arrayData.count)
                {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }

        }
            break;
        default:
            break;
    }
    
    UITableViewCell *cellNull = [[UITableViewCell alloc] init];
    return cellNull;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    
    
    if(arrayData.count ==0){
        switch (typeActionEvent) {
            case type_ClueContact:
            {
                typeActionEvent = type_ClueContact;
                EditContactOpportunityViewController *viewController = [[EditContactOpportunityViewController alloc]initWithNibName:@"EditContactOpportunityViewController" bundle:nil];
                viewController.dataRoot = opportunity;
                [self presentViewController:viewController animated:YES completion:nil];
            }
                break;
            case type_ProposeProduct:
            {
                typeActionEvent = type_ProposeProduct;
                EditOpportunityProductViewController *viewController = [[EditOpportunityProductViewController alloc]initWithNibName:@"EditOpportunityProductViewController" bundle:nil];
                viewController.dataRoot = opportunity;
                viewController.delegateOpportunityProduct = (id<OpportunityProductDelegate>)self;
                [self presentViewController:viewController animated:YES completion:nil];
            }
                break;
            case type_Task:
            {
                typeActionEvent = type_Task;
                EditOpportunityTaskViewController *viewController = [[EditOpportunityTaskViewController alloc]initWithNibName:@"EditOpportunityTaskViewController" bundle:nil];
                viewController.dataRoot = opportunity;
                [self presentViewController:viewController animated:YES completion:nil];
            }
                break;
            case type_Note:
            {
                typeActionEvent = type_Note;
                EditNoteOpportunityViewController *viewController = [[EditNoteOpportunityViewController alloc]initWithNibName:@"EditNoteOpportunityViewController" bundle:nil];
                viewController.dataRoot = opportunity;
                [self presentViewController:viewController animated:YES completion:nil];
            }
                break;
            case type_Calendar:
            {
                EditCalendarOpportunityViewController *viewController = [[EditCalendarOpportunityViewController alloc]initWithNibName:@"EditCalendarOpportunityViewController" bundle:nil];
                [viewController setDelegate:self];
                viewController.dataRoot = opportunity;
                viewController.isKH360 = YES;
                [self presentViewController:viewController animated:YES completion:nil];
            }

            default:
                break;
        }

    }
    else{
        NSDictionary *dicDataTemp = [arrayData objectAtIndex:indexPath.row];
        NSString *itemId = [dicDataTemp objectForKey:DTOCONTACT_id];

    switch (typeActionEvent) {
        case type_ClueContact:{
            
            NSDictionary *dicData = [dtoContactProcess getDataWithKey:DTOCONTACT_id withValue:itemId];
            
            EditContactOpportunityViewController *viewController = [[EditContactOpportunityViewController alloc]initWithNibName:@"EditContactOpportunityViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case type_ProposeProduct:{
            NSDictionary *dicData = [[dtoOpportunityProductProcess getById:itemId] objectAtIndex:0];
            
            EditOpportunityProductViewController *viewController = [[EditOpportunityProductViewController alloc]initWithNibName:@"EditOpportunityProductViewController" bundle:nil];
            viewController.dataSend = dicData;
            //[self presentViewController:viewController animated:YES completion:nil];
            // viewController.view.frame = CGRectMake(0, 0, 600, 400);
            viewController.delegateOpportunityProduct = (id<OpportunityProductDelegate>)self;
            //[self presentPopupViewController:viewController animationType:YES];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case type_Task:{
            NSDictionary *dicData = [dtoTaskProcess getDataWithKey:DTOTASK_id withValue:itemId];
            
            EditOpportunityTaskViewController *viewController = [[EditOpportunityTaskViewController alloc]initWithNibName:@"EditOpportunityTaskViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case type_Note:{
            NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
            EditNoteOpportunityViewController *viewNoteController = [[EditNoteOpportunityViewController alloc]initWithNibName:@"EditNoteOpportunityViewController" bundle:nil];
            viewNoteController.dataSend = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    }
}

//Thêm phần sửa, xoá hiển thị trên row của table

- (IBAction)actionAdd:(id)sender {
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectIndex;
    
    detail.listData = listArr;
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnAdd.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, HEIGHT_SELECT_INDEX_ROW*listArr.count) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

//
-(void) dismissPopoverView
{
    [self dismissPopover];
    [self dismissPopupViewControllerWithanimationType:nil];
}
- (void) dismissPopover
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}

#pragma mark edit


/**
 *  Delete 1 row tren TableView
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
        
        switch (typeActionEvent) {
            case type_ProposeProduct:
            {
                deleteItemId = [dicData objectForKey:DTOOPPORTUNITYPRODUCT_id];
            }
                break;
            case type_ClueContact:
            {
                deleteItemId = [dicData objectForKey:DTOCONTACT_id];
            }
                break;
            case type_Task:
            {
                deleteItemId = [dicData objectForKey:DTOTASK_id];
            }
                break;
            case type_Note:
            {
                deleteItemId = [dicData objectForKey:DTONOTE_id];
            }
                break;
            default:
                break;
        }
        
        // deleteFile =[dicData objectForKey:DTOATTACHMENT_id];
        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
        isMainDelete = NO;
        mylert.tag = TAG_DELETE_ITEM;
        [mylert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == TAG_DELETE_ITEM) {
        //thuc hien xoa
        BOOL result;
        if(isMainDelete){
            result = [dtoOpportunityProcess deleteEntity:deleteItemId];
        }else{
            switch (typeActionEvent) {
                case type_ProposeProduct:
                {
                    result = [dtoOpportunityProductProcess deleteEntity:deleteItemId];
                    if (result) {
                        
                        [self loadDataWithTypeAction:type_ProposeProduct];
                    }else{
                        NSLog(@"Delete false!");
                    }
                }
                    break;
                case type_ClueContact:
                {
                    result = [dtoContactProcess deleteEntity:deleteItemId];
                    if (result) {
                        //xoa tiep trong bang opportunitycontact
                        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"id = '%@'",deleteItemId]];
                        NSArray *x = [arrayData filteredArrayUsingPredicate:bPredicate];
                        NSDictionary *dicData= [[arrayData filteredArrayUsingPredicate:bPredicate] objectAtIndex:0];
                        NSString *opportunityContactId = [dicData objectForKey:DTOOPPORTUNITYCONTACT_opportunityContactId];
                        result =[dtoOpportunityContactProcess deleteEntity:opportunityContactId];
                        [self loadDataWithTypeAction:type_ClueContact];
                    }else{
                        NSLog(@"Delete false!");
                    }
                }
                    break;
                case type_Task:
                {
                    result = [dtoTaskProcess deleteEntity:deleteItemId];
                    if (result) {
                        
                        [self loadDataWithTypeAction:type_Task];
                    }else{
                        NSLog(@"Delete false!");
                    }
                }
                    break;
                case type_Note:
                {
                    result = [dtoNoteProcess deleteEntity:deleteItemId];
                    if (result) {
                        
                        [self loadDataWithTypeAction:type_Note];
                    }else{
                        NSLog(@"Delete false!");
                    }
                }
                    break;
                default:
                    break;
            }
        }
        //Dua thong bao
        if (result) {
            //thong bao cap nhat thanh cong
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateSuccess delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
            
            [mylert show];
            if(isMainDelete){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }else{
            //thong bao cap nhat that bai
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateFail delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
        }
        
    }
}


/**
 *  Them 1 button "Sua" ben canh button "Xoa" (tren ios7, ios6 su dung accessoryType)
 */
//-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{

/**
 *  Neu khong phai la Header thi la item level 2
 */
//  return SYS_KEY_EDIT;
//return nil;
//}

/**
 *  Xu ly khi chon button "Sua"
 */
-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sua item at index = %d", indexPath.row);
    
    NSDictionary *dicDataTemp = [arrayData objectAtIndex:indexPath.row];
    NSString *itemId = [dicDataTemp objectForKey:DTOCONTACT_id];
    
    switch (typeActionEvent) {
        case type_ClueContact:{
            
            NSDictionary *dicData = [dtoContactProcess getDataWithKey:DTOCONTACT_id withValue:itemId];
            
            EditContactOpportunityViewController *viewController = [[EditContactOpportunityViewController alloc]initWithNibName:@"EditContactOpportunityViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case type_ProposeProduct:{
            NSDictionary *dicData = [[dtoOpportunityProductProcess getById:itemId] objectAtIndex:0];
            
            EditOpportunityProductViewController *viewController = [[EditOpportunityProductViewController alloc]initWithNibName:@"EditOpportunityProductViewController" bundle:nil];
            viewController.dataSend = dicData;
            //[self presentViewController:viewController animated:YES completion:nil];
            // viewController.view.frame = CGRectMake(0, 0, 600, 400);
            viewController.delegateOpportunityProduct = (id<OpportunityProductDelegate>)self;
            //[self presentPopupViewController:viewController animationType:YES];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case type_Task:{
            NSDictionary *dicData = [dtoTaskProcess getDataWithKey:DTOTASK_id withValue:itemId];
            
            EditOpportunityTaskViewController *viewController = [[EditOpportunityTaskViewController alloc]initWithNibName:@"EditOpportunityTaskViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case type_Note:{
            NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
            EditNoteOpportunityViewController *viewNoteController = [[EditNoteOpportunityViewController alloc]initWithNibName:@"EditNoteOpportunityViewController" bundle:nil];
            viewNoteController.dataSend = dicData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
    
}

- (IBAction)actionDelete:(id)sender {
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
    mylert.tag = TAG_DELETE_ITEM;
    [mylert show];
    isMainDelete = YES;
    deleteItemId = [opportunity objectForKey:DTOOPPORTUNITY_id];
}
- (IBAction)actionEdit:(id)sender {
    EditOpportunityViewController *viewController = [[EditOpportunityViewController alloc]initWithNibName:@"EditOpportunityViewController" bundle:nil];
    viewController.dataSend = opportunity;
    [self presentViewController:viewController animated:YES completion:nil];
}
#pragma mark set bottom
/*set bottom line*/
-(void) setBottomLineDetail: (UIScrollView*) scrollViewTemp {
    //NSArray *arrayLabelToSetBottomLine = [scrollViewTemp vi]
    
    for (UIView *viewSub in [scrollViewTemp subviews]) {
        if (viewSub.tag == TAG_CONTROL_LINE) {
            [self addBottomLineWithBottomControl:viewSub.frame withInControl:scrollViewTemp];
        }
    }
}

-(void) addBottomLineWithBottomControl : (CGRect) bottomViewFrame withInControl : (UIView*) containView {
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, bottomViewFrame.origin.y + bottomViewFrame.size.height + 4, containView.frame.size.width, BORDER_WITH)];
    viewLine.backgroundColor = BORDER_COLOR;
    [viewLine setBorderWithOption:smgSelect];
    [containView addSubview:viewLine];
    
}
#pragma mark set frame label
-(void) setFrameLabelTitle : (UILabel*) labelTitle withLabelValue : (UILabel*) lableValue withFY : (float) fY {
    
    CGRect frame = labelTitle.frame;
    labelTitle.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
    frame =lableValue.frame;
    lableValue.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
}


-(float) setFrameLabelTitle : (UILabel*) labelTitle withLabelValue : (UILabel*) lableValue withFY : (float) fY : (NSString*) strValue {
    
    CGRect frame = labelTitle.frame;
    labelTitle.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
    frame =lableValue.frame;
    lableValue.frame = CGRectMake(frame.origin.x,fY, frame.size.width, frame.size.height);
    
    float heightLabelCN = 25.0f;
    
    if (![StringUtil stringIsEmpty:strValue]) {
        lableValue.text=strValue;
        heightLabelCN =  [self getHeightLabel:strValue];
        
        if (heightLabelCN>25) {
            [UILabel setMultiline:lableValue];}
    }
    else{
        lableValue.text=@"";
    }
    return  lableValue.frame.origin.y + lableValue.frame.size.height + 15;
}
-(CGFloat) getHeightLabel : (NSString*) strMessage{
    
    CGSize maximumSize =CGSizeMake(185, 9999);
    
    CGFloat heightLabel = 0;
    
    UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:16];
    CGSize myStringSize = [strMessage sizeWithFont:myFont
                                 constrainedToSize:maximumSize
                                     lineBreakMode:UILineBreakModeWordWrap];
    
    if( myStringSize.height>25){
        heightLabel = myStringSize.height;
    }
    else
        heightLabel =  25;
    
    
    return heightLabel;
}
#pragma mark - Phan tab bar tren iphone
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    switch (item.tag) {
        case 0: //Thong tin
            self.scrollViewInfo.hidden = NO;
            self.viewTableIphone.hidden =YES;
            break;
        case 1://Lien he
            self.scrollViewInfo.hidden = YES;
            self.viewTableIphone.hidden = NO;
            
            [self loadDataWithTypeAction:type_ClueContact];
            
            break;
        case 2: //Sản phẩm
            self.scrollViewInfo.hidden = YES;
            self.viewTableIphone.hidden = NO;
            
            [self loadDataWithTypeAction:type_ProposeProduct];
            
            break;
        case 3: //Công việc
            self.scrollViewInfo.hidden = YES;
            self.viewTableIphone.hidden = NO;
            
            [self loadDataWithTypeAction:type_Task];
            
            break;
        case 4: //Ghi chú
            self.scrollViewInfo.hidden = YES;
            self.viewTableIphone.hidden = NO;
            
            [self loadDataWithTypeAction:type_Note];
            
            break;
        case 5: //Lịch
            self.scrollViewInfo.hidden = YES;
            self.viewTableIphone.hidden = NO;
            
            [self loadDataWithTypeAction:type_Calendar];
            
            break;
        default:
            break;
    }
}

-(void)setLanguage{
    [_fullNameLB setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TITLE")];
    [_leftLabelHeader setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_HEADER")];
    [_lblTitleCode setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_CODE")];
    [_lblTitleName setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_NAME")];
    [_lblStartDateTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_STARTDATE")];
    [_lblEndDateRealTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_ENDDATEREAD")];
    [_lblEndDateTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_ENDDATE")];
    [_lblOpportunityLevelTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_LEVEL")];
    [_lblNextTaskTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_NEXT_TASK")];
    [_lblTypeTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TYPE")];
    [_lblCustomerTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_CUSTOMER")];
    [_lblNoteTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_NOTE")];
    [_lblDescriptionTitle setText:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_DESCRIPTION")];
    [_btnClueContact setTitle:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TAB_CONTACT") forState:UIControlStateNormal];
    [_btnProposeProduct setTitle:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TAB_PROPOSE_PRODUCT") forState:UIControlStateNormal];
    [_btnActionSale setTitle:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TAB_PRODUCT_SALE") forState:UIControlStateNormal];
    [_btnTask setTitle:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TAB_TASK") forState:UIControlStateNormal];
    [_btnNote setTitle:LocalizedString(@"KEY_OPPORTUNITY_DETAIL_TAB_NOTE") forState:UIControlStateNormal];
    [_btnCalendar setTitle:LocalizedString(@"KEY_OPPORTUNTIY_DETAIL_TAB_CALENDAR") forState:UIControlStateNormal];
}
@end
