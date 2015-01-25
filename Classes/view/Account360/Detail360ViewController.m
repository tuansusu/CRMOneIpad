//
//  Detail360ViewController.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import "Detail360ViewController.h"
#import "DTOACCOUNTProcess.h"
#import "DTOCONTACTProcess.h"
#import "DTOTASKProcess.h"
#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"
#import "DTOOPPORTUNITYProcess.h"


////remove
#import "StringUtil.h"

#define TITLE_APP @"KHÁCH HÀNG 360"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_NOTE 1
#define SELECT_INDEX_ADD_CALENDAR 2
#define SELECT_INDEX_ADD_TASK 3
#define SELECT_INDEX_ADD_OPPORTUNITY 4

#define WIDTH_HEADER_EXPAND_INFO 930

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_NOTE @"GHI CHÚ"
#define SELECT_TEXT_ADD_CALENDAR @"LỊCH"
#define SELECT_TEXT_ADD_TASK @"NHIỆM VỤ"
#define SELECT_TEXT_ADD_OPPORTUNITY @"CƠ HỘI"


#define DELETE_CONTAC 11
#define DELETE_NOTE 22
#define DELETE_CALENDAR 33
#define DELETE_TASK 44
#define DELETE_COHOI 55
#define DELETE_LEAD 66

@interface Detail360ViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOCONTACTProcess *dtoContactProcess; //lay danh sach du lieu theo clientLeadId
    DTOTASKProcess *dtoTaskProcess;
    DTONOTEProcess *dtoNoteProcess;
    DTOATTACHMENTProcess *dtoAttachProcess;
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    NSUserDefaults *defaults ;
    
    
    UIColor *textColorButtonNormal; //mau chu button binh thuong
    UIColor *textColorButtonSelected; //mau chu button select
    UIColor *backgrondButtonSelected; //mau nen button select
    UIColor *backgroundButtonNormal; //Mau nen button binh thuong
    
    DTOACCOUNTProcess *dtoAccoutProcess;
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
}
@end

@implementation Detail360ViewController
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
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionExpandInfo:self.btnExpandInfo];
    [self.scrollViewHeaderExpandInfo setContentSize:CGSizeMake(WIDTH_HEADER_EXPAND_INFO, self.scrollViewHeaderExpandInfo.frame.size.height)];
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    //cu quay lai la no load
    NSLog(@"quay lai form");
    // [self viewDidLoad];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    _fullNameLB.text=@"KHÁCH HÀNG 360";
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR, SELECT_TEXT_ADD_TASK, SELECT_TEXT_ADD_OPPORTUNITY, nil];
    
    dtoAccoutProcess = [DTOACCOUNTProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    dtoTaskProcess= [DTOTASKProcess new];
    dtoNoteProcess = [DTONOTEProcess new];
    dtoAttachProcess=[DTOATTACHMENTProcess new];
    dtoOpportunityProcess =[DTOOPPORTUNITYProcess new];
    NSLog(@"datasend detail lead = %@", self.dataSend);
    dicData = [dtoAccoutProcess getDataWithKey:DTOACCOUNT_id withValue:[_dataSend objectForKey:DTOACCOUNT_id]];
    //dicData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[self.dataSend objectForKey:DTOLEAD_id]];
    NSLog(@"Get detail = %@", dicData);
    
    if ([dicData isKindOfClass:[NSNull class]] || dicData==nil ) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    [self actionExpandInfo:self.btnExpandInfo];
    arrayData  = [NSArray new];
    [self loadDetailCustomerPersonalData];
    
}

/*
 *Load danh sach khach hang ca nhan
 */
-(void) loadDetailCustomerPersonalData {
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_code]]){
        _lbCode.text=[dicData objectForKey:DTOACCOUNT_code];
    }
    else{
    _lbCode.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_name]]) {
        _lbName.text=[dicData objectForKey:DTOACCOUNT_name];
    }
    else{
    _lbName.text=@"N/A";
    }
    if([[dicData objectForKey:DTOACCOUNT_sex] isEqualToValue:@"1"]){
        _lbSex.text=@"Nam";
    }
    else{
        _lbSex.text=@"Nữ";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_mobile]]) {
        _lbMobile.text=[dicData objectForKey:DTOACCOUNT_mobile];
    }
    else{
        _lbMobile.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_email]]) {
        _lbEmail.text=[dicData objectForKey:DTOACCOUNT_email];
    }
    else{
        _lbEmail.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
        _lbDiaChi.text=[dicData objectForKey:DTOACCOUNT_address];
    }
    else{
    _lbDiaChi.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_sector]]) {
        _lbSector.text=[dicData objectForKey:DTOACCOUNT_sector];
    }
    else{
    _lbSector.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_personalIndustry]]) {
        _lbJob.text=[dicData objectForKey:DTOACCOUNT_personalIndustry];
    }
    else {
    _lbJob.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_branchCode]]) {
        _lbCompany.text=[dicData objectForKey:DTOACCOUNT_branchCode];
    }
    else{
    _lbCompany.text=@"N/A";
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_openCodeDate]]) {
        _ldDateOpenCode.text=[dicData objectForKey:DTOACCOUNT_openCodeDate];
    }
    else{
    _ldDateOpenCode.text=@"N/A";
    }
    _lbQuocGia.text=@"N/A";
    _lbQuanHuyen.text=@"N/A";
    _lbPhuonXa.text=@"N/A";
    NSString *sms =@"";
    NSString *disableSms = [dicData objectForKey:DTOACCOUNT_disableSms];
    if([disableSms isEqualToString:@"0"])
    {
        sms=@"SMS";
    }
    NSString *phone=@"";
    NSString *disablePhone = [dicData objectForKey:DTOACCOUNT_disablePhone];
    if ([disablePhone isEqualToString:@"0"]) {
        phone=@"Phone";
    }
    NSString *email=@"";
    NSString *disableEmail= [dicData objectForKey:DTOACCOUNT_disableEmail];
    if([disableEmail isEqualToString:@"0"]){
    email=@"Email";
    }
    NSString *metting=@"";
    NSString *disableMetting = [dicData objectForKey:DTOACCOUNT_disableMeeting];
    if ([disableMetting isEqualToString:@"0"]) {
        metting=@"Metting";
    }
    _lbKhongLienLacQua.text=[NSString stringWithFormat:@"%@,%@,%@,%@",sms,phone,email,metting];
    
    
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


-(void) loadDataWithTypeAction : (enum Type360View) inputTypeActionEvent{
    
    self.viewBodyExpandInfo.hidden = YES;
    self.tbData.hidden  = NO;
    
    typeActionEvent = inputTypeActionEvent;
    switch (typeActionEvent) {
        case type360View_ExpandInfo:{
            
        }
            break;
        case type360View_Calendar:
        {
            arrayData = [dtoTaskProcess filterWith360Id:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            
        }
            break;
        case type360View_Contact:
        {
            arrayData = [dtoContactProcess filterWithClientLeaderId:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            //  NSLog(@"get detail data = %d", );
        }break;
        case type360View_Note:
        {
            arrayData = [dtoNoteProcess filterWithClient360Id:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            
        }break;
        case type360View_Opportunity:{
            arrayData = [dtoOpportunityProcess filterWith360Id:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
        }break;
        case type360View_Task:{
            arrayData = [dtoTaskProcess filterWith360Id:[dicData objectForKey:DTOACCOUNT_clientAccountId]];
            NSLog(@"get detail data = %d", arrayData.count);
            
        }break;
  
            
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
        case SELECT_INDEX_ADD_CALENDAR:
        {
            EditCalendar360ViewController *viewController = [[EditCalendar360ViewController alloc]initWithNibName:@"EditCalendar360ViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_CONTACT:
        {
            EditContact360ViewController *viewController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_NOTE:
        {
            NSLog(@"data send note %@", dicData);
            EditNote360ViewController *viewController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
            viewController.dataRoot = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        case SELECT_INDEX_ADD_OPPORTUNITY:
        {
            EditOpportunity360ViewController *viewController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];

        }
            break;
            
        case SELECT_INDEX_ADD_TASK:
        {
            EditTask360ViewController *viewController = [[EditTask360ViewController alloc]initWithNibName:@"EditTask360ViewController" bundle:nil];
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
    CGRect popoverFrame = _btnAdd.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, HEIGHT_SELECT_INDEX_ROW*listArr.count) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
#pragma mark action button - action tab


- (IBAction)actionExpandInfo:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Contact];
    [self displayNormalButtonState:sender];
    
}

- (IBAction)actionNote:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Note];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionCalendar:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Calendar];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionTask:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Task];
    [self displayNormalButtonState:sender];
}

- (IBAction)actionOpportunity:(UIButton *)sender {
    [self loadDataWithTypeAction:type360View_Opportunity];
    [self displayNormalButtonState:sender];
}

#pragma mark display color button
-(void) displayNormalButtonState : (UIButton*) btnSelect {
    
    for (UIView *viewTemp in self.scrollViewHeaderExpandInfo.subviews) {
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



#pragma mark - Table View


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (typeActionEvent) {
        case type360View_Calendar:
            return 40.0f;
            break;
        case type360View_Task:
            return 60.0f;
            break;
        case type360View_Note:
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberofrows = %d", arrayData.count);
    
    return  arrayData.count;
    
    
}
//thêm cái line đến tận left margin
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tbData) {
        
        
        switch (typeActionEvent) {
            case type360View_Calendar:
            {
                static NSString *cellId = @"Calendar360Cell";
                Calendar360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Calendar360Cell initNibCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
                
            }
                break;
            case type360View_Contact:{
                static NSString *cellId = @"Contact360Cell";
                Contact360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Contact360Cell initNibCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
                break;
            case type360View_Note:
            {
                static NSString *cellId = @"Note360Cell";
                Note360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Note360Cell initNibCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
                break;
            case type360View_Opportunity:
            {
                static NSString *cellId = @"Opportunity360Cell";
                Opportunity360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Opportunity360Cell getNewCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;

            }
                break;
                
            case type360View_Task:
            {
                static NSString *cellId = @"Task360Cell";
                Task360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
                
                
                if (!cell) {
                    cell = [Task360Cell initNibCell];
                }
                
                if (arrayData.count>0) {
                    [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
                }
                
                return cell;
            }
                break;
            default:
                break;
        }
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
        case type360View_Task:{
            
            EditTask360ViewController *viewNoteController = [[EditTask360ViewController alloc]initWithNibName:@"EditTask360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Opportunity:
        {
            EditOpportunity360ViewController *viewNoteController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
            viewNoteController.dataRoot = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Note:{
            EditNote360ViewController *viewNoteController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Contact:
        {
            EditContact360ViewController *viewNoteController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Calendar:{
            EditCalendar360ViewController *viewNoteController = [[EditCalendar360ViewController alloc]initWithNibName:@"EditCalendar360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
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
            case type360View_Task:{
                //deleteLeadId = [dicData objectForKey:DTOLEAD_id];
                delTask = [dicDataItem objectForKey:DTOTASK_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá công việc?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag =DELETE_TASK;
                [mylert show];
            }
                break;
            case type360View_Opportunity:{
                deleteNoteId = [dicData objectForKey:DTOOPPORTUNITY_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá cơ hội?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_COHOI;
                [mylert show];
            }
                break;
            case type360View_Note:{
                deleteNoteId =[dicDataItem objectForKey:DTONOTE_id];
                deleteFileClienWithClientNoteID=[dicDataItem objectForKey:DTONOTE_clientNoteId];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá ghi chú?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_NOTE;
                [mylert show];
            }
                break;
            case type360View_Contact:
            {
                deleteContact = [dicDataItem objectForKey:DTOCONTACT_id];
                UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá liên hệ?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
                mylert.tag = DELETE_CONTAC;
                [mylert show];
            }
                break;
            case type360View_Calendar:{
                // deleteCalenda = [dicData objectForKey:DToCa];
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
        case type360View_Task:{
            EditTask360ViewController *viewNoteController = [[EditTask360ViewController alloc]initWithNibName:@"EditTask360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Opportunity:{
            
            EditOpportunity360ViewController *viewNoteController = [[EditOpportunity360ViewController alloc]initWithNibName:@"EditOpportunity360ViewController" bundle:nil];
            viewNoteController.dataRoot = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Note:{
            EditNote360ViewController *viewNoteController = [[EditNote360ViewController alloc]initWithNibName:@"EditNote360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
        }
            break;
        case type360View_Contact:
        {
            EditContact360ViewController *viewNoteController = [[EditContact360ViewController alloc]initWithNibName:@"EditContact360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
        }
            break;
        case type360View_Calendar:{
            EditCalendar360ViewController *viewNoteController = [[EditCalendar360ViewController alloc]initWithNibName:@"EditCalendar360ViewController" bundle:nil];
            viewNoteController.dataSend = dicTempData;
            [self presentViewController:viewNoteController animated:YES completion:nil];
            
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
    BOOL item;
    
    if (alertView.tag==DELETE_NOTE) {
        if(buttonIndex==0){
            NSLog(@"chọn xoá ghi chú");
            NSLog(@"deleteItem:%@",deleteNoteId);
            item=[dtoNoteProcess deleteEntity:deleteNoteId];
            if(item){
                NSLog(@"Xoa thanh cong");
                [self loadDataWithTypeAction:type360View_Note];
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
                [self loadDataWithTypeAction:type360View_Task];
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
                [self loadDataWithTypeAction:type360View_Contact];
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
            NSLog(@"xoa lich");
        }
        else{
            NSLog(@"khong xoa lich");
            [alertView dismissWithClickedButtonIndex:nil animated:YES];
        }
    }
    
}

- (IBAction)actionEdit:(id)sender {
        
        EditAccount360ViewController *viewController = [[EditAccount360ViewController alloc]initWithNibName:@"EditAccount360ViewController" bundle:nil];
        viewController.dataSend=dicData;
        [self presentViewController:viewController animated:YES completion:nil];

    
}

- (IBAction)actionDel:(id)sender {
    deleteItem=[self.dataSend objectForKey:DTOLEAD_id];
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Bạn có muốn xoá khách hàng?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
    mylert.tag = DELETE_LEAD;
    [mylert show];
    
}
@end
