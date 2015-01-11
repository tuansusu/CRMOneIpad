//
//  DetailLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/20/14.
//
//

#import "DetailLeadViewController.h"

#import <EventKit/EventKit.h>

#import "DTOACCOUNTLEADProcess.h"
#import "DTOCONTACTProcess.h"
#import "DTOTASKProcess.h"
#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"


#import "TaskCalendarCell.h"
#import "TaskCalTLineCell.h"
#import "TaskActionCell.h"
#import "ProductsLeadView.h"
#import "ComplainsView.h"
#import "ComplainDetailViewController.h"
#import "ComplainModel.h"
////remove
#import "StringUtil.h"
#import "Validator.h"

#define TITLE_APP @"KHÁCH HÀNG TIỀM NĂNG"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_NOTE 1
#define SELECT_INDEX_ADD_CALENDAR 2
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_OPPORTUNITY 4
#define SELECT_INDEX_ADD_COMPLAIN 5

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_NOTE @"GHI CHÚ"
#define SELECT_TEXT_ADD_CALENDAR @"LỊCH"
#define SELECT_TEXT_ADD_TASK @"NHIỆM VỤ"
#define SELECT_TEXT_ADD_OPPORTUNITY @"CƠ HỘI"
#define SELECT_TEXT_ADD_COMPLAIN @"Ý KIẾN PHẢN HỒI"

#define DELETE_CONTAC 11
#define DELETE_NOTE 22
#define DELETE_CALENDAR 33
#define DELETE_TASK 44
#define DELETE_COHOI 55
#define DELETE_LEAD 66
#define WIDTH_HEADER_EXPAND_INFO 930

static NSString* const TaskCalendarNormalCellId   = @"TaskCalendarCellId";
static NSString* const TaskCalendarTimelineCellId = @"TaskCalTLineCellId";
static NSString* const TaskActionCellId           = @"TaskActionCellId";

@interface DetailLeadViewController () <TaskActionCellDelegate,ComplainDetailViewControllerDelegate,EditCalendarLeadViewControllerDelegate,ComplainsViewDelegate>
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOCONTACTProcess *dtoContactProcess; //lay danh sach du lieu theo clientLeadId
    DTOTASKProcess *dtoTaskProcess;
    DTONOTEProcess *dtoNoteProcess;
    DTOATTACHMENTProcess *dtoAttachProcess;
    
    NSUserDefaults *defaults ;
    
    
    UIColor *textColorButtonNormal; //mau chu button binh thuong
    UIColor *textColorButtonSelected; //mau chu button select
    UIColor *backgrondButtonSelected; //mau nen button select
    UIColor *backgroundButtonNormal; //Mau nen button binh thuong
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    NSDictionary *dicData; //Data cua thang xem chi tiet
    NSString *leadType ; //
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    //delete note
    NSString *deleteNoteId;
    //delete file
    NSString *deleteFileClienWithClientNoteID;
    NSString *deleteItem;
    NSString *deleteContact;
    NSString *deleteCalenda;
    NSString *delTask;
    
    //controll
    
    __weak IBOutlet UIButton *btnAdd;
    
    //calendar
    BOOL calendarIsTimeline;

    IBOutlet UIScrollView *scrollViewHeaderExpandInfo;

    IBOutlet  ProductsLeadView* viewProductsLead;
    IBOutlet  ComplainsView* viewComplain;
}
@end

@implementation DetailLeadViewController
@synthesize typeActionEvent;

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
    
    /* set defaults cell for Task Calendar */
    [self.tbData registerNib:[TaskCalendarCell nib] forCellReuseIdentifier:TaskCalendarNormalCellId];
    [self.tbData registerNib:[TaskCalTLineCell nib] forCellReuseIdentifier:TaskCalendarTimelineCellId];
    [self.tbData registerNib:[TaskActionCell   nib] forCellReuseIdentifier:TaskActionCellId];
    
    // calendar
    calendarIsTimeline = YES;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionExpandInfo:self.btnExpandInfo];
    [scrollViewHeaderExpandInfo setContentSize:CGSizeMake(WIDTH_HEADER_EXPAND_INFO, scrollViewHeaderExpandInfo.frame.size.height)];
}

-(void) viewWillAppear:(BOOL)animated{
    //cu quay lai la no load
    NSLog(@"quay lai form");
    // [self viewDidLoad];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR, SELECT_TEXT_ADD_TASK, SELECT_TEXT_ADD_OPPORTUNITY,SELECT_TEXT_ADD_COMPLAIN, nil];
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    dtoTaskProcess= [DTOTASKProcess new];
    dtoNoteProcess = [DTONOTEProcess new];
    dtoAttachProcess=[DTOATTACHMENTProcess new];
    NSLog(@"datasend detail lead = %@", self.dataSend);
    dicData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[self.dataSend objectForKey:DTOLEAD_id]];
    NSLog(@"Get detail = %@", dicData);
    
    if ([dicData isKindOfClass:[NSNull class]] || dicData==nil ) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    if ([dicData objectForKey:DTOLEAD_leadType]) {
        leadType = ObjectToStr([dicData objectForKey:DTOLEAD_leadType]);
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        self.lbName.text =[dicData objectForKey:DTOLEAD_name];
    }
    if ([leadType isEqualToString:FIX_LEADTYPE_BUSSINESS]) {
        NSLog(@"KHACH HANG DOAN NGHIEP");
        
        self.scrollViewPersonal.hidden = YES;
        self.scrollViewBussiness.hidden = NO;
        
        [self loadDetailCustomerBussinessData];
        //        DetailCustomBussinessViewController *viewDetailController = [[DetailCustomBussinessViewController alloc]initWithNibName:@"DetailCustomBussinessViewController" bundle:nil];
        //        viewDetailController.dataSend = dicData;
        //        [self.viewBodyExpandInfo addSubview:viewDetailController.view];
        
        self.lbDescription.text = @"";
        
    }else{
        NSLog(@"KHACH HANG CA NHAN");
        
        self.scrollViewPersonal.hidden = NO;
        self.scrollViewBussiness.hidden = YES;
        
        self.scrollViewPersonal.contentSize = CGSizeMake(self.scrollViewPersonal.frame.size.width, 630.0f);
        
        
        [self loadDetailCustomerPersonalData];
        
        
        //        DetailCustomPersonViewController *viewDetailController = [[DetailCustomPersonViewController alloc]initWithNibName:@"DetailCustomPersonViewController" bundle:nil];
        //        viewDetailController.dataSend = dicData;
        //        [self.viewBodyExpandInfo addSubview:viewDetailController.view];
        
    }
    
    
    
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    [self actionExpandInfo:self.btnExpandInfo];
    arrayData  = [NSArray new];
}

/*
 *Load danh sach khach hang ca nhan
 */
-(void) loadDetailCustomerPersonalData {
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_code]]) {
        _lbCode.text =[dicData objectForKey:DTOLEAD_code];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        _lbName.text =[dicData objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
        _lbAddress.text =[dicData objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_mobile]]) {
        _lbPhone.text =[dicData objectForKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_email]]) {
        _lbEmail.text =[dicData objectForKey:DTOLEAD_email];
    }
    
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_sex]]) {
        _lbSex.text =[dicData objectForKey:DTOLEAD_sex];
        
        if ([ObjectToStr([dicData objectForKey:DTOLEAD_sex]) isEqualToString:@"0"]) {
            _lbSex.text = @"Nữ";
        }else if ([ObjectToStr([dicData objectForKey:DTOLEAD_sex]) isEqualToString:@"1"]){
            _lbSex.text = @"Nam";
        }
        
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_marialStatus]]) {
        _lbMarialStatus.text =[dicData objectForKey:DTOLEAD_marialStatus];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_birthday]]) {
        _lbBirthDay.text =[dicData objectForKey:DTOLEAD_birthday];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_sector]]) {
        _lbSector.text =[dicData objectForKey:DTOLEAD_sector];
    }
    
    _lbAlias.text = @"";
    
}


/*
 *Load danh sach khach hang doanh nghiep
 */
-(void) loadDetailCustomerBussinessData {
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        _lbBussinessName.text =[dicData objectForKey:DTOLEAD_name];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
        _lbBussinessAddress.text =[dicData objectForKey:DTOLEAD_address];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_mobile]]) {
        _lbBussinessPhone.text =[dicData objectForKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_email]]) {
        _lbBussinessEmail.text =[dicData objectForKey:DTOLEAD_email];
    }
    
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_taxCode]]) {
        _lbBussinessTaxCode.text =[dicData objectForKey:DTOLEAD_taxCode];
    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_code]]) {
        _lbBussinessCode.text =[dicData objectForKey:DTOLEAD_code];
    }
    
    
}


-(void) loadDataWithTypeAction : (enum TypeLeaderView) inputTypeActionEvent{
    
    self.viewBodyExpandInfo.hidden = YES;
    self.tbData.hidden  = NO;
    
    typeActionEvent = inputTypeActionEvent;
    switch (typeActionEvent) {
        case typeLeaderView_ExpandInfo:{
            
        }
            break;
        case typeLeaderView_Contact:
        {
            arrayData = [dtoContactProcess filterWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"get detail data = %d", arrayData.count);
        }break;
        case typeLeaderView_Note:
        {
            //load data la ghi chu
            
            NSLog(@"DTOLEAD_ClientLeadID:%@", [dicData objectForKey:DTOLEAD_clientLeadId]);
            arrayData = [dtoNoteProcess filterWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"total: %i", arrayData.count);
            
        }break;
        case typeLeaderView_Opportunity:{
            
        }break;
        case typeLeaderView_Calendar:
        {
            arrayData = [dtoTaskProcess filterCalendarWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"calendar count = %ld", (unsigned long)arrayData.count);
        }
            break;
        case typeLeaderView_Task:
        {
            arrayData = [dtoTaskProcess filterTaskWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"task count = %ld", (unsigned long)arrayData.count);
        }
            break;

        case typeLeaderView_Complains:
        {
            self.viewBodyExpandInfo.hidden = NO;
            self.tbData.hidden  = YES;
            [viewProductsLead setHidden:YES];
            [viewComplain setHidden:NO];
            [viewComplain setDelegate:self];
            [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOLEAD_clientLeadId] description]];
        }
            break;
        case typeLeaderView_ProductsLead:
        {
            self.viewBodyExpandInfo.hidden = NO;
            self.tbData.hidden  = YES;
            [viewComplain setHidden:YES];
            [viewProductsLead setHidden:NO];
            [viewProductsLead initDataWithLeaderId:[[dicData objectForKey:DTOLEAD_clientLeadId] description]];
        }
            break;
        default:
            break;
    }
    
    [self.tbData reloadData];
}


- (void) updateInterFaceWithOption : (int) option
{
    
    
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    self.viewBodyMainInfo.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.viewBodyMainInfo.layer.borderWidth = BORDER_WITH;
    self.viewBodyMainInfo.layer.borderColor = [BORDER_COLOR CGColor];
    
    
    self.viewHeaderExpandInfo.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    [self.tbData setBorderWithOption:smgSelect];
    [self.viewBodyExpandInfo setBorderWithOption:smgSelect];
    
    self.fullNameLB.text = TITLE_APP;
    
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    
    textColorButtonNormal = TEXT_BUTTON_COLOR_BLACK_1; //mau chu button binh thuong
    textColorButtonSelected = TEXT_BUTTON_COLOR1; //mau chu button select
    backgrondButtonSelected = BUTTON_ACTIVE_COLOR_1;
    backgroundButtonNormal = BUTTON_REPORT_MAIN_IN_ACTIVE_COLOR_1;
    
    for (UIView *viewTemp in self.viewBodyMainInfo.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    [self.viewHeaderExpandInfo setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
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
            EditContactLeadViewController *viewController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_NOTE:
        {
            NSLog(@"data send note %@", dicData);
            EditNoteLeadViewController *viewController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        case SELECT_INDEX_ADD_OPPORTUNITY:
        {
            
        }
            break;
        // calendar+task
        case SELECT_INDEX_ADD_CALENDAR:
        {
            EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewController setDelegate:self];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_TASK:
        {
            EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_COMPLAIN:
        {
            ComplainDetailViewController *viewController = [[ComplainDetailViewController alloc]initWithNibName:@"ComplainDetailViewController" bundle:nil];
            viewController.delegate= self;
//            viewController.dataRoot = dicData;
            viewController.leadId = [[dicData objectForKey:DTOLEAD_clientLeadId] description];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;

        default:
            break;
    }
}
- (void)closeComplainDetailView:(ComplainDetailViewController*)complainDetailViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)updateComplainDetailViewWithComplainOB:(DTOComplainObject*)complainOB
{
    ComplainModel *complainModel = [[ComplainModel alloc] init];
    if ([complainModel updateComplainWithComplainOB:complainOB]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [viewComplain initDataWithLeaderId:[[dicData objectForKey:DTOLEAD_clientLeadId] description]];
    }
}

#pragma mark action button - normal
- (IBAction)homeBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionAdd:(id)sender{
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectIndex;
    
    detail.listData = listArr;
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = btnAdd.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, HEIGHT_SELECT_INDEX_ROW*listArr.count) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
#pragma mark action button - action tab


- (IBAction)actionExpandInfo:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Contact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionNote:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Note];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionCalendar:(UIButton *)sender {
    if (typeActionEvent == typeLeaderView_Calendar)
    {
        calendarIsTimeline = !calendarIsTimeline;
    }
    [self loadDataWithTypeAction:typeLeaderView_Calendar];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionTask:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Task];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionOpportunity:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Opportunity];
    [self displayNormalButtonState:sender];
}

- (IBAction)btnComplainsTaped:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Complains];
    [self displayNormalButtonState:sender];
}

- (IBAction)btnProductsTaped:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_ProductsLead];
    [self displayNormalButtonState:sender];
}


#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in scrollViewHeaderExpandInfo.subviews)
    {
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



#pragma mark - Table View Datasource


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (typeActionEvent) {
        case typeLeaderView_Note:
            return 60.0f;
            break;
        case typeLeaderView_Calendar:
        {
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
        case typeLeaderView_Task:
            return 60.0f;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    NSLog(@"numberofrows = %ld", (unsigned long)arrayData.count);
    return  arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (typeActionEvent) {
        case typeLeaderView_Contact:{
            static NSString *cellId = @"ContactLeadCell";
            ContactLeadCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ContactLeadCell initNibCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        case typeLeaderView_Note:
        {
            static NSString *cellId = @"NoteLeadCell";
            NoteLeadCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [NoteLeadCell initNibCell];
            }
            
            if (arrayData.count>0) {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        case typeLeaderView_Opportunity:
        {
        }
            break;
        // calendar + task
        case typeLeaderView_Calendar:
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
        case typeLeaderView_Task:
        {
            TaskActionCell *cell= [tableView dequeueReusableCellWithIdentifier:TaskActionCellId];
            
            if (cell !=nil)
            {
                cell.delegate = self;
                
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
    
    NSDictionary *dicTempData = [arrayData objectAtIndex:indexPath.row];
    
    
    switch (typeActionEvent) {
        case typeLeaderView_Task:{
            
            EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Opportunity:
            break;
        case typeLeaderView_Note:{
            EditNoteLeadViewController *viewNoteController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Contact:
        {
            EditContactLeadViewController *viewNoteController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Calendar:{
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewCalendarController setDelegate:self];
            viewCalendarController.dataSend = dicTempData;
            [self presentViewController:viewCalendarController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - TaskActionCellDelegate
- (void)taskActionCell:(TaskActionCell *)taskActionCell changeStatusWithData:(NSMutableDictionary *)inputDicData
{
    //change status
    //dtoTaskProcess
    
    NSMutableDictionary *dicTaskUpdate = [[NSMutableDictionary alloc] init];
    
    [dicTaskUpdate setObject:[inputDicData objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    
    if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE)
    {
        [dicTaskUpdate setObject:IntToStr(FIX_TASK_STATUS_NOT_COMPLETE) forKey:DTOTASK_taskStatus];
    }
    else //if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE)
    {
        [dicTaskUpdate setObject:IntToStr(FIX_TASK_STATUS_COMPLETE) forKey:DTOTASK_taskStatus];
    }
    
    if ([dtoTaskProcess insertToDBWithEntity:dicTaskUpdate])
    {
        NSIndexPath *indexPathToReload = [self.tbData indexPathForCell:taskActionCell];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            arrayData = [dtoTaskProcess filterTaskWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"task count = %ld", (unsigned long)arrayData.count);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tbData reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPathToReload] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        });
    }
}

#pragma mark ComplainsView Delegate
- (void)selectedComplainOB:(DTOComplainObject*)complainOB{
    ComplainDetailViewController *complainDetailVC = [[ComplainDetailViewController alloc] init];
    complainDetailVC.delegate = self;
    complainDetailVC.leadId = [[dicData objectForKey:DTOLEAD_clientLeadId] description];
    [self presentViewController:complainDetailVC animated:YES completion:nil];
    [complainDetailVC loadDataWithComplainOB:complainOB];
}

//Thêm phần sửa, xoá hiển thị trên row của table

#pragma mark edit
/**
 *  Bat Swipe right de cho phep hien thi button xoa 1 row
 *  @return YES: If you want the specified item to be editable.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *deletePermission =@"1";
    if ([deletePermission isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

/**
 *  Delete 1 row tren TableView
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dicDataItem = [arrayData objectAtIndex:indexPath.row];
        
        switch (typeActionEvent) {
            case typeLeaderView_Task:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                delTask = [dicDataItem objectForKey:DTOTASK_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá công việc?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag =DELETE_TASK;
                [mylert show];
            }
                break;
            case typeLeaderView_Opportunity:{
                deleteNoteId = [dicData objectForKey:DTOOPPORTUNITY_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá cơ hội?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_COHOI;
                [mylert show];
            }
                break;
            case typeLeaderView_Note:{
                deleteNoteId =[dicDataItem objectForKey:DTONOTE_id];
                deleteFileClienWithClientNoteID=[dicDataItem objectForKey:DTONOTE_clientNoteId];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá ghi chú?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_NOTE;
                [mylert show];
            }
                break;
            case typeLeaderView_Contact:
            {
                deleteContact = [dicDataItem objectForKey:DTOCONTACT_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá liên hệ?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_CONTAC;
                [mylert show];
            }
                break;
            case typeLeaderView_Calendar:{
                // deleteCalenda = [dicData objectForKey:DToCa];
                delTask = [dicDataItem objectForKey:DTOTASK_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá lịch?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_CALENDAR;
                [mylert show];
            }
                break;
            default:
                break;
        }
        
    }
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

/**
 *  Xu ly khi chon button "Sua"
 */
-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"o day");
    NSDictionary *dicTempData = [arrayData objectAtIndex:indexPath.row];
    switch (typeActionEvent) {
        case typeLeaderView_Task:{
            EditTaskLeadViewController *viewNoteController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Opportunity:{
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            viewCalendarController.dataSend = dicTempData;
            [viewCalendarController setDelegate:self];
            [self presentViewController:viewCalendarController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Note:{
            EditNoteLeadViewController *viewNoteController = [[EditNoteLeadViewController alloc]initWithNibName:@"EditNoteLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Contact:
        {
            EditContactLeadViewController *viewNoteController = [[EditContactLeadViewController alloc]initWithNibName:@"EditContactLeadViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case typeLeaderView_Calendar:{
            EditCalendarLeadViewController *viewCalendarController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            [viewCalendarController setDelegate:self];
            viewCalendarController.dataSend = dicTempData;
            [self presentViewController:viewCalendarController animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
    
    
}



#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}

#pragma mark Edit Calendar Lead ViewController Delegate
- (void)reloadListCalendarTask{
    [self loadDataWithTypeAction:typeLeaderView_Calendar];
    [_tbData reloadData];
}

#pragma -mark xử lý thông báo
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    BOOL item;
  
    if (alertView.tag==DELETE_NOTE) {
        if(buttonIndex==0){
            NSLog(@"chọn xoá ghi chú");
              NSLog(@"deleteItem:%@",deleteNoteId);
            item=[dtoNoteProcess deleteEntity:deleteNoteId];
            if(item){
                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:typeLeaderView_Note];
               // [self displayNormalButtonState:sender];
            }
            else{
                NSLog(@"Xoa that bai");
            }
        }
        else if(buttonIndex==1){
            
            NSLog(@"Khong  xoa file");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }else if(alertView.tag==DELETE_TASK){
        if(buttonIndex==0){
            NSLog(@"Delete task");
            item=[dtoTaskProcess deleteEntity:delTask];
            if(item){
                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:typeLeaderView_Task];
            }
            else{
                NSLog(@"Loi");
            }
        }
        else if(buttonIndex==1){
            NSLog(@"No del task");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }else if(alertView.tag==DELETE_LEAD){
    
        if(buttonIndex==0){
            NSLog(@"Xoa khach hang dau moi");
        }
        else{
            NSLog(@"Khong xoa khach hang dau moi");
        }
    }else if(alertView.tag==DELETE_CONTAC){
        if(buttonIndex==0){
            NSLog(@"Xoa lien he");
            item=[dtoContactProcess deleteEntity:deleteContact];
            if (item) {
                [self loadDataWithTypeAction:typeLeaderView_Contact];
            }
            else{
                NSLog(@"Loi");
            }
        }
        else{
            NSLog(@"Khong xoa lien he");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }else if(alertView.tag==DELETE_COHOI){
        if(buttonIndex==0){
            NSLog(@"xoa co hoi");
        }
        else{
            NSLog(@"Khong xoa co hoi");
        }
    }else if(alertView.tag==DELETE_CALENDAR){
        if(buttonIndex==0){
            item=[dtoTaskProcess deleteEntity:delTask];
            if(item){
                NSString* eventIden = [Validator getSafeString:[[NSUserDefaults standardUserDefaults]  valueForKey:delTask]];

                EKEventStore *eventStore = [[EKEventStore alloc] init];
                [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    if(granted)
                    {
                        EKEvent *event = [eventStore eventWithIdentifier:eventIden];
                        [eventStore removeEvent:event span:EKSpanFutureEvents error:&error];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:delTask];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }];

                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:typeLeaderView_Calendar];
            }
            else{
                NSLog(@"Loi");
            }
            NSLog(@"xoa lich");
        }
        else{
        NSLog(@"khong xoa lich");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }
    
}

- (IBAction)actionEdit:(id)sender {
    
    
    if([[self.dataSend objectForKey:DTOLEAD_leadType] isEqualToString:@"0"]){
        
        EditAccountLeadViewController *viewController = [[EditAccountLeadViewController alloc]initWithNibName:@"EditAccountLeadViewController" bundle:nil];
        viewController.dataSend=dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else{
        EditBussinessLeadViewController *viewController = [[EditBussinessLeadViewController alloc]initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
        viewController.dataSend=dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
}

- (IBAction)actionDel:(id)sender {
    deleteItem=[self.dataSend objectForKey:DTOLEAD_id];
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá khách hàng?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
    mylert.tag = DELETE_LEAD;
    [mylert show];
    
}
@end
