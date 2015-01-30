//
//  ListOpportunityViewController.m
//  OfficeOneStudy
//
//  Created by ADMIN on 10/31/14.
//
//

#import "ListOpportunityViewController.h"
#import "DTOOPPORTUNITYProcess.h"
#import "VTCheckBox.h"
#import "CalendarPickerViewController.h"
#import "SearchAdvanceOpportunityViewController.h"


#define START_DATE 1
#define END_DATE 2


@interface ListOpportunityViewController ()
{
    int smgSelect ; //option layout
    
    NSString *userType;
    NSArray *arrayData; //mang luu tru du lieu
    NSString *nowStr;
    NSDate *now,*startDate,*endDate ;
    NSDateFormatter *df;
    NSInteger selectDatePicker;
    NSString *deleteOpportunityId;
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    VTRadio *rdCustomer360; //Radio khach hang 360
    VTRadio *rdCustomerRoot; //radio khach hang dau moi
    
    NSUserDefaults *defaults;
}
@end

@implementation ListOpportunityViewController

@synthesize listPopover;

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
    [self initCustomControl];
    
    //
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"dd/MM/yyyy"];
    now = [NSDate date];
    nowStr = [df stringFromDate:now];
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

/*
 *Khởi tạo danh sách control
 */
-(void) initCustomControl
{
    
    
    
    [self.tbData registerNib:[UINib nibWithNibName:@"AttachFileCell" bundle:nil] forCellReuseIdentifier:@"AttachFileCell"];
    
    rdCustomer360 = [[VTRadio alloc]init];
    rdCustomer360.index = 0;
    [rdCustomer360 setCheck:NO];
    rdCustomer360.delegate = self;
    [self.viewRdCustomer360 addSubview:rdCustomer360];
    
    rdCustomerRoot = [[VTRadio alloc]init];
    rdCustomerRoot.index = 1;
    [rdCustomerRoot setCheck:NO];
    rdCustomerRoot.delegate = self;
    [self.viewRdCustomerRoot addSubview:rdCustomerRoot];

}


#pragma mark check radio
-(void) checkBoxClick:(id)sender withIndex:(NSInteger)index{

//    if (index == 0) {
//        userType = @"1";
//    }else if (index == 1){
//        userType = @"2";
//    }
    
    if(rdCustomer360.getCheck && !rdCustomerRoot.getCheck)
    {
        userType=@"1";
    }
    else if(!rdCustomer360.getCheck && rdCustomerRoot.getCheck)
    {
        userType = @"2";
    }
    else
    {
        userType = nil;
    }
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    
    
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    arrayData  = [NSArray new];

    arrayData = [dtoOpportunityProcess filterOpportunity:nil addStartDate:nil addEndDate:nil userType:nil];
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    //load data from db
    
}

- (void) updateInterFaceWithOption : (int) option
{
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    //self.fullNameLB.text =  TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    self.lbTotal.textColor = TEXT_COLOR_HEADER_APP;
    
    
    [self.btnSearch setStyleNormalWithOption:smgSelect];
    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    
    self.txtSearchBar.barTintColor = HEADER_VIEW_COLOR1;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;

    //
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    //Start date
    self.dtStartDate.enabled = false;
    self.dtStartDate.leftView = paddingView;
    self.dtStartDate.leftViewMode = UITextFieldViewModeAlways;
    
    //End date
    self.dtEndDate.enabled = false;
    paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.dtEndDate.leftView = paddingView;
    self.dtEndDate.leftViewMode = UITextFieldViewModeAlways;
    
    
    //Nut tim kiem
    self.btnSearch.backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
    [self.btnSearch setTitleColor: TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
    
    
    
    for (UIView *viewTemp in self.leftInMainView.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
        


    }
    
    
}


- (IBAction)homeBack:(id)sender {
    [Util backToHome:self];
}



#pragma mark table view

#pragma mark - Table View

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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
        return  arrayData.count;
        
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *cellId = @"OpportunityCell";
        OpportunityCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    if (!cell) {
        cell = [OpportunityCell getNewCell];
    }
    
    if (arrayData.count>0) {
            [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
        }
        
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    
    NSDictionary *selectedItem = [arrayData objectAtIndex:indexPath.row];
    
    if (selection){
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    CompetitorsViewController *viewController = [[CompetitorsViewController alloc] initWithNibName:@"CompetitorsViewController" bundle:nil];
    viewController.itemId = [selectedItem objectForKey:DTOOPPORTUNITY_id];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void) viewDidAppear:(BOOL)animated{
    arrayData = [dtoOpportunityProcess filterOpportunity:nil addStartDate:nil addEndDate:nil userType:nil];
    
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    [self.tbData reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
        
        NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
        deleteOpportunityId = [dicData objectForKey:DTOOPPORTUNITY_id];
        
        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
        mylert.tag = TAG_DELETE_ITEM;
        [mylert show];
        
        //        switch (objDelTemp.level) {
        //            case 0:
        //                [AlertViewUtils showAlertViewWithTitle:ALERTVIEW_BUTTON_TEXT_002 message: CONFIRM_DELETE_LEVEL0_CALENDAR(objDelTemp.level0Name) delegate:self withTag:11 withTitleButtonCancel:ALERTVIEW_BUTTON_TEXT_006 withTitleButtonOther:KEY_NOTIFICATION_CANCEL];
        //                break;
        //            case 1:
        //                [AlertViewUtils showAlertViewWithTitle:ALERTVIEW_BUTTON_TEXT_002 message: CONFIRM_DELETE_LEVEL1_CALENDAR(objDelTemp.level1Name) delegate:self withTag:11 withTitleButtonCancel:ALERTVIEW_BUTTON_TEXT_006 withTitleButtonOther:KEY_NOTIFICATION_CANCEL];
        //                break;
        //            case 2:
        //                [AlertViewUtils showAlertViewWithTitle:ALERTVIEW_BUTTON_TEXT_002 message: CONFIRM_DELETE_LEVEL2_CALENDAR delegate:self withTag:11 withTitleButtonCancel:ALERTVIEW_BUTTON_TEXT_006 withTitleButtonOther:KEY_NOTIFICATION_CANCEL];
        //                break;
        //        }
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
    
    return @"Xóa";
}

/**
 *  Them 1 button "Sua" ben canh button "Xoa" (tren ios7, ios6 su dung accessoryType)
 */
-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  Neu khong phai la Header thi la item level 2
     */
    return @"Sửa";
    //return nil;
}

/**
 *  Xu ly khi chon button "Sua"
 */
-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sua item at index = %d", indexPath.row);
    
    NSDictionary *dicDataTemp = [arrayData objectAtIndex:indexPath.row];
    
    //NSDictionary *dicData = [dtoOpportunityProcess getDataWithKey:DTOOPPORTUNITY_id withValue:[dicDataTemp objectForKey:DTOOPPORTUNITY_id]];
    NSDictionary *dicData = [dtoOpportunityProcess getById:[dicDataTemp objectForKey:DTOOPPORTUNITY_id]];

        EditOpportunityViewController *viewController = [[EditOpportunityViewController alloc]initWithNibName:@"EditOpportunityViewController" bundle:nil];
        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
}
#pragma mark alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == TAG_DELETE_ITEM) {
        //thuc hien xoa
        
        BOOL result = [dtoOpportunityProcess deleteEntity:deleteOpportunityId];
        //reload lai csdl
        if (result) {
            
            arrayData = [dtoOpportunityProcess filterOpportunity:nil addStartDate:nil addEndDate:nil userType:nil];
            [self.tbData reloadData];
            //thong bao cap nhat thanh cong
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateSuccess delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
            
            [mylert show];
        }else{
            //thong bao cap nhat that bai
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateFail delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
        }
        
    }
}


#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}


- (IBAction)startDateSelect:(id)sender {
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

- (IBAction)startDateClear:(id)sender {
    self.dtStartDate.text = @"Ngày bắt đầu";
    startDate = nil;
}


- (IBAction)endDateSelect:(id)sender {
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

- (IBAction)endDateClear:(id)sender {
    self.dtEndDate.text = @"Ngày kết thúc";
    endDate = nil;
}

- (IBAction)search:(id)sender {
    NSString *keyword = self.txtKeyword.text;
    arrayData = [dtoOpportunityProcess filterOpportunity:keyword addStartDate:startDate addEndDate:endDate userType:userType];
    [self.tbData reloadData];
}

-(void) actionSearchAdvance:(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(int)type{
    
    arrayData = [dtoOpportunityProcess filterOpportunity:keyword addStartDate:startDate addEndDate:endDate userType:type];
    //_lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    
    [self.tbData reloadData];
}

- (IBAction)actionAdvanceSearch:(id)sender {
    //hidden keyboard
    [self.txtSearchBar resignFirstResponder];
    
    //tim kiem nang cao
    SearchAdvanceOpportunityViewController *detail = [[SearchAdvanceOpportunityViewController alloc]initWithNibName:@"SearchAdvanceOpportunityViewController" bundle:nil];
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = ((UIButton*) sender).frame;
    
    detail.advanceSearchDelegate =(id<SearchAdvanceDelegate>) self;
    
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(286, 405) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void) selectDatePickerWithDate:(NSDate *)date
{
    
    switch (selectDatePicker) {
        case START_DATE:
            self.dtStartDate.text = [NSString stringWithFormat:@"%@",
                                     [df stringFromDate:date]];
            startDate = date;
            break;
        case END_DATE:
            self.dtEndDate.text = [NSString stringWithFormat:@"%@",
                                            [df stringFromDate:date]];
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
- (IBAction)actionAdd:(id)sender {
    EditOpportunityViewController *viewController = [[EditOpportunityViewController alloc]initWithNibName:@"EditOpportunityViewController" bundle:nil];
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark -  phần tìm kiếm
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    NSLog(@"searchOption %d", searchOption);
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    NSLog(@"text did change %@", searchText);
    //strSearchText = searchText;
    if(self.txtSearchBar.text.length == 0){
        arrayData = [dtoOpportunityProcess filterOpportunity:self.txtSearchBar.text addStartDate:nil addEndDate:nil userType:nil];
        _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
        
        [self.tbData reloadData];

    }
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBarCancelButtonClicked");
    //strSearchText = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    NSLog(@"seach click");
    //[SVProgressHUD show];
    
    arrayData = [dtoOpportunityProcess filterOpportunity:self.txtSearchBar.text addStartDate:nil addEndDate:nil userType:nil];
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    [self.tbData reloadData];
    [searchBar resignFirstResponder];
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"selectedScopeButtonIndexDidChange = %d", selectedScope);
    //iSearchOption = selectedScope;
}

@end
