//
//  DetailLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/20/14.
//
//

#import "DetailLeadViewController.h"
#import "DTOACCOUNTLEADProcess.h"
#import "DTOCONTACTProcess.h"
#import "DTOTASKProcess.h"
#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"

#import "TaskCalendarCell.h"
#import "TaskCalTLineCell.h"
#import "TaskActionCell.h"

////remove
#import "StringUtil.h"

#define TITLE_APP @"KHÁCH HÀNG TIỀM NĂNG"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_NOTE 1
#define SELECT_INDEX_ADD_CALENDAR 2
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_OPPORTUNITY 4

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_NOTE @"GHI CHÚ"
#define SELECT_TEXT_ADD_CALENDAR @"LỊCH"
#define SELECT_TEXT_ADD_TASK @"NHIỆM VỤ"
#define SELECT_TEXT_ADD_OPPORTUNITY @"CƠ HỘI"

static NSString* const TaskCalendarNormalCellId   = @"TaskCalendarCellId";
static NSString* const TaskCalendarTimelineCellId = @"TaskCalTLineCellId";
static NSString* const TaskActionCellId           = @"TaskActionCellId";

@interface DetailLeadViewController ()
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
    
    //controll
    
    __weak IBOutlet UIButton *btnAdd;
    
    //calendar
    BOOL calendarIsTimeline;
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
    [self.tbData registerNib:[TaskActionCell nib]   forCellReuseIdentifier:TaskActionCellId];
    
    // calendar
    calendarIsTimeline = NO;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionExpandInfo:self.btnExpandInfo];
}

-(void) viewWillAppear:(BOOL)animated{
    //cu quay lai la no load
    NSLog(@"quay lai form");
    [self viewDidLoad];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR, SELECT_TEXT_ADD_TASK, SELECT_TEXT_ADD_OPPORTUNITY, nil];
    
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
            //arrayData =[dtoNoteProcess filter];
            //arrayData = [dtoNoteProcess filterWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
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
    
    
    
    //    self.viewHeaderExpandInfo.layer.borderWidth = BORDER_WITH;
    //    self.viewHeaderExpandInfo.layer.borderColor = [BORDER_COLOR CGColor];
    
    [self.tbData setBorderWithOption:smgSelect];
    [self.viewBodyExpandInfo setBorderWithOption:smgSelect];
    
    self.fullNameLB.text = TITLE_APP;
    
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    //[self.btnSearch setStyleNormalWithOption:smgSelect];
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
        case SELECT_INDEX_ADD_CALENDAR:
        {
            EditCalendarLeadViewController *viewController = [[EditCalendarLeadViewController alloc]initWithNibName:@"EditCalendarLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
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
            
        case SELECT_INDEX_ADD_TASK:
        {
            EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
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
    //    self.viewBodyExpandInfo.hidden = NO;
    //    self.tbData.hidden  = YES;
    //    [self displayNormalButtonState:sender];
    [self loadDataWithTypeAction:typeLeaderView_Contact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionNote:(UIButton *)sender {
    [self loadDataWithTypeAction:typeLeaderView_Note];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionCalendar:(UIButton *)sender {
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

#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in self.viewHeaderExpandInfo.subviews) {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            //            [((UIButton*) viewTemp) setBackgroundColor:backgroundButtonNormal];
            //            [((UIButton*) viewTemp) setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
            
            
            [((UIButton*) viewTemp) setBackgroundColor:[UIColor whiteColor]];
            [((UIButton*) viewTemp) setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
            
            //[((UIButton*) viewTemp) setBorderWithOption:1 withBorderFlag:AUISelectiveBordersFlagBottom];
            
            [((UIButton*) viewTemp) setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
        }
    }
    
    //    [btnSelect setBackgroundColor:backgrondButtonSelected];
    //[btnSelect setTitleColor:textColorButtonSelected forState:UIControlStateNormal];
    
    [btnSelect setBackgroundColor:[UIColor whiteColor]];
    [btnSelect setTitleColor:textColorButtonNormal forState:UIControlStateNormal];
    
    //[btnSelect setBorderWithOption:1 withBorderFlag:AUISelectiveBordersFlagBottom];
    
    [btnSelect setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:5.0f withBorderFlag:AUISelectiveBordersFlagBottom];
}



#pragma mark - Table View


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (typeActionEvent) {
        case typeLeaderView_Note:
            return 60.0f;
            break;
        case typeLeaderView_Calendar:
            return 43.0f;
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
            
        case typeLeaderView_Calendar:
        {
            TaskCalendarCell *cell= [tableView dequeueReusableCellWithIdentifier:TaskCalendarNormalCellId];
            
            if (indexPath.row < arrayData.count)
            {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
        }
            break;
        case typeLeaderView_Task:
        {
            TaskActionCell *cell= [tableView dequeueReusableCellWithIdentifier:TaskActionCellId];
            
            if (indexPath.row < arrayData.count)
            {
                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            }
            
            return cell;
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
            //lay chi tiet doi tuong nhet vao datasend
            DetailContactLeadViewController *viewController = [[DetailContactLeadViewController alloc]initWithNibName:@"DetailContactLeadViewController" bundle:nil];
            viewController.dataSend = dicTempData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case typeLeaderView_Calendar:
            break;
        case typeLeaderView_Task:
            break;
        default:
            break;
    }
}

#pragma mark taskaction Cell
- (void) AccountLeadCellDelegate_ActionChangeTaskStatusWithData : (NSMutableDictionary*) inputDicData {
    //change status
    //dtoTaskProcess
    
    NSMutableDictionary *dicTaskUpdate = [[NSMutableDictionary alloc] init];
    
    [dicTaskUpdate setObject:[inputDicData objectForKey:DTOTASK_id] forKey:DTOTASK_id];
    
    if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_COMPLETE) {
        [dicTaskUpdate setObject:ObjectToStr(FIX_TASK_STATUS_NOT_COMPLETE) forKey:DTOTASK_taskStatus];
        
    }else if ([[inputDicData objectForKey:DTOTASK_taskStatus] intValue] == FIX_TASK_STATUS_NOT_COMPLETE){
        [dicTaskUpdate setObject:ObjectToStr(FIX_TASK_STATUS_COMPLETE) forKey:DTOTASK_taskStatus];
    }else{
        //qua han
        //chua mau do
        
    }
    [dtoTaskProcess insertToDBWithEntity:dicTaskUpdate];
    [inputDicData setObject:[dicTaskUpdate objectForKey:DTOTASK_taskStatus] forKey:DTOTASK_taskStatus];
    
    [self.tbData reloadData];
    
    
    
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
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = TAG_DELETE_ITEM;
                [mylert show];
            }
                break;
            case typeLeaderView_Opportunity:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = TAG_DELETE_ITEM;
                [mylert show];
            }
                break;
            case typeLeaderView_Note:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                deleteNoteId =[dicDataItem objectForKey:DTONOTE_id];
                deleteFileClienWithClientNoteID=[dicDataItem objectForKey:DTONOTE_clientNoteId];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận xoá ghi chú?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = 20;
                [mylert show];
            }
                break;
            case typeLeaderView_Contact:
            {
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = TAG_DELETE_ITEM;
                [mylert show];
            }
                break;
            case typeLeaderView_Calendar:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = TAG_DELETE_ITEM;
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
            //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
            mylert.tag = TAG_DELETE_ITEM;
            [mylert show];
        }
            break;
        case typeLeaderView_Opportunity:{
            //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
            mylert.tag = TAG_DELETE_ITEM;
            [mylert show];
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
            //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
            mylert.tag = TAG_DELETE_ITEM;
            [mylert show];
        }
            break;
        case typeLeaderView_Calendar:{
            //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
            mylert.tag = TAG_DELETE_ITEM;
            [mylert show];
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

#pragma -mark xử lý thông báo
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==20) {
        NSLog(@"chọn xoá ghi chú");
        if(buttonIndex==0){
            NSLog(@"Xoa file dinh kem");
            NSLog(@"noteID:%@",deleteFileClienWithClientNoteID);
            NSLog(@"ID:%@",deleteNoteId);
            @try {
                BOOL resultNote  =  [dtoNoteProcess deleteEntity:deleteNoteId];
                BOOL resultFile = [dtoAttachProcess deleteEntity:deleteFileClienWithClientNoteID];
                if (resultNote) {
                    NSLog(@"Xoa ghi chu thanh cong");
                }
                if (resultFile) {
                    NSLog(@"Xo file thanh cong");
                }
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
            @finally {
                
            }
            
            // [self.tbData reloadData];
            NSLog(@"delelete thanh cong");
        }
        else if(buttonIndex==1){
            
            NSLog(@"Khong  xoa file");
        }
    }else{
        if(buttonIndex==0){
            //            NSLog(@"Ban khong tiep tuc");
            //            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        else if(buttonIndex==1){
            //            NSLog(@"Ban co tiep tuc");
            //            [arrayData removeAllObjects];
            //            [self.tbData reloadData];
            //            txtContent.text=@"";
            //            txtTitle.text=@"";
            
        }
    }
    
}

@end
