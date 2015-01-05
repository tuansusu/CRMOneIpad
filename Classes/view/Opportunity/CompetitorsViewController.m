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

#define SELECT_TEXT_ADD_CONTACT @"LIÊN HỆ"
#define SELECT_TEXT_ADD_NOTE @"SẢN PHẨM ĐỀ XUẤT"
#define SELECT_TEXT_ADD_CALENDAR @"SẢN PHẨM ĐÃ BÁN"
#define SELECT_TEXT_ADD_COMPETITOR @"CÔNG VIỆC"
#define SELECT_TEXT_ADD_SUPORT @"LỊCH"

#define SELECT_INDEX_ADD_CONTACT 0
#define SELECT_INDEX_ADD_PRODUCT 1
#define SELECT_INDEX_ADD_TASK 3




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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionClueContact:self.btnClueContact];
    
//    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];

    [self loadData];
}
-(void) loadData{
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    NSDateFormatter *DateToDisplayFormatter=[[NSDateFormatter alloc] init];
    [DateToDisplayFormatter setDateFormat:@"dd/MM/yyyy"];
    
    //Hien thi chi tiet thong tin co hoi
    //code
    self.lblCode.text = [opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId];
    //name
    self.lblName.text = [opportunity objectForKey:DTOOPPORTUNITY_name];
    //startDate
    NSString *strStartDate= [opportunity objectForKey:DTOOPPORTUNITY_startDate];
    NSDate *startDate =[DateFormatter dateFromString:strStartDate];
    self.lblStartDateDetail.text = [DateToDisplayFormatter stringFromDate:startDate];
    //endDateReal
    NSString *strEndDateReal = [opportunity objectForKey:DTOOPPORTUNITY_endDateReal];
    NSDate *endDateReal = [DateFormatter dateFromString:strEndDateReal];
    self.lblEndDateDetail.text = [DateToDisplayFormatter stringFromDate:endDateReal];
    //endDate
    NSString *strEndDate = [opportunity objectForKey:DTOOPPORTUNITY_endDate];
    NSDate *endDate = [DateFormatter dateFromString:strEndDate];
    self.lblEndDateDetail.text = [DateToDisplayFormatter stringFromDate:endDate];
    //Level
    self.lblOpporttunityLevelDetail.text = [opportunity objectForKey:@"Level"];
    //NextTask
    self.lblNextTaskDetail.text = [opportunity objectForKey:@"NextTaskName"];
    //Type
    self.lblTypeDetail.text = [opportunity objectForKey:@"Type"];
    //Customer
    self.lblCustomerDetail.text = [opportunity objectForKey:@"Customer"];
    //Description
    NSString *description = [opportunity objectForKey:@"Description"];
    if(![StringUtil stringIsEmpty:description]){
        self.lblNoteDetail.text = [opportunity objectForKey:@"Description"];
    }else{
        self.lblNoteDetail.text = @"NA";
    }
    //ResultDescription
    NSString *resultDescription = [opportunity objectForKey:@"ResultDescription"];
    if(![StringUtil stringIsEmpty:resultDescription]){
        self.lblDescriptionDetail.text = resultDescription;
    }else{
        self.lblDescriptionDetail.text = @"NA";
    }
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
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR,SELECT_TEXT_ADD_COMPETITOR,SELECT_TEXT_ADD_SUPORT, nil];
    
    [self actionClueContact:self.btnClueContact];
    
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    dtoCompetitorProcess = [DTOCOMPETITORProcess new];
    dtoProductMasterProcess = [DTOPRODUCTMASTERProcess new];
    dtoAccountProcess  = [DTOACCOUNTProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    dtoOpportunityProductProcess = [DTOOPPORTUNITYPRODUCTProcess new];
    dtoTaskProcess = [DTOTASKProcess new];
    dtoOpportunityContactProcess = [DTOOPPORTUNITYCONTACTProcess new];
    
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
        case type_Calendar:
        {
            arrayData = [NSArray new];
        }
            break;
            
        default:
            break;
    }
    
    [self.tbData reloadData];
}


- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    //[self.btnSearch setStyleNormalWithOption:smgSelect];
   // [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
   // self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    
    textColorButtonNormal = TEXT_BUTTON_COLOR_BLACK_1; //mau chu button binh thuong
    textColorButtonSelected = TEXT_BUTTON_COLOR1; //mau chu button select
    backgrondButtonSelected = BUTTON_ACTIVE_COLOR_1;
    backgroundButtonNormal = BUTTON_REPORT_MAIN_IN_ACTIVE_COLOR_1;
    
    for (UIView *viewTemp in self.leftInMainView.subviews) {
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
    }
    
    [self.rightViewHeader setSelectiveBorderWithColor:backgrondButtonSelected withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
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
            EditContactOpportunityViewController *viewController = [[EditContactOpportunityViewController alloc]initWithNibName:@"EditContactOpportunityViewController" bundle:nil];
            viewController.dataRoot = opportunity;
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_PRODUCT:
        {
            EditOpportunityProductViewController *viewController = [[EditOpportunityProductViewController alloc]initWithNibName:@"EditOpportunityProductViewController" bundle:nil];
            viewController.dataRoot = opportunity;
            //[self presentViewController:viewController animated:YES completion:nil];
            viewController.view.frame = CGRectMake(0, 0, 600, 400);
            viewController.delegateOpportunityProduct = (id<OpportunityProductDelegate>)self;
            [self presentPopupViewController:viewController animationType:YES];
        }
            break;
        case SELECT_INDEX_ADD_TASK:
        {
            EditOpportunityTaskViewController *viewController = [[EditOpportunityTaskViewController alloc]initWithNibName:@"EditOpportunityTaskViewController" bundle:nil];
            viewController.dataRoot = opportunity;
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
    [self loadDataWithTypeAction:type_Calendar];
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


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (typeActionEvent) {
        case type_ProposeProduct:{
            return 50.0f;
        }break;
        
        case type_ClueContact:{
            return 100.0f;
        }
            break;
        case type_Task:{
            return 80.0f;
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
    NSLog(@"numberofrows = %d", arrayData.count);
    
    return  arrayData.count;
    
    
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
    switch (typeActionEvent) {
        case type_ClueContact:{
            static NSString *cellId = @"ContactOpportunityCell";
            ContactOpportunityCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            
            
            if (!cell) {
                cell = [ContactOpportunityCell initNibCell];
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
        case type_Calendar:
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
    
    switch (typeActionEvent) {
        case type_Sale:
            
            break;
            case type_ClueContact:
            break;
//            case type_Competionor:
//            break;
            case type_ProposeProduct:
            break;
//            case type_Support:
//            break;
        default:
            break;
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
        deleteItemId = [dicData objectForKey:DTOOPPORTUNITYPRODUCT_id];
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
                }
                    break;
                default:
                    break;
            }
        }
        //reload lai csdl
        if (result) {
            if(isMainDelete){
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                arrayData = [dtoOpportunityProductProcess filterWithClientOpportunityId:[opportunity objectForKey:DTOOPPORTUNITY_clientOpportunityId]];
                [self.tbData reloadData];
            }
            //thong bao cap nhat thanh cong
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateSuccess delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
            
                [mylert show];
            
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
            viewController.view.frame = CGRectMake(0, 0, 600, 400);
            viewController.delegateOpportunityProduct = (id<OpportunityProductDelegate>)self;
            [self presentPopupViewController:viewController animationType:YES];
        }
            break;
        case type_Task:{
            NSDictionary *dicData = [dtoTaskProcess getDataWithKey:DTOTASK_id withValue:itemId];
            
            EditOpportunityTaskViewController *viewController = [[EditOpportunityTaskViewController alloc]initWithNibName:@"EditOpportunityTaskViewController" bundle:nil];
            viewController.dataSend = dicData;
            [self presentViewController:viewController animated:YES completion:nil];
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
@end
