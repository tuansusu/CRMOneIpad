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
    
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    VTRadio *rdCustomer360; //Radio khach hang 360
    VTRadio *rdCustomerRoot; //radio khach hang dau moi
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
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self initCustomControl];
    
    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];

    
    //
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"dd/MM/yyyy"];
    now = [NSDate date];
    nowStr = [df stringFromDate:now];

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

    //load data from db
    
}

- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    [self.btnSearch setStyleNormalWithOption:smgSelect];
    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    

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
        

//        if ([viewTemp isKindOfClass:[UIButton class]]) {
//            {
//                ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
//                [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
//            }
//        }
//        if ([viewTemp isKindOfClass:[UITextView class]]) {
//            ((UITextView*) viewTemp).textColor = TEXT_COLOR_REPORT;
//            ((UITextView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
//            ((UITextView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
//            ((UITextView*) viewTemp).layer.borderWidth = BORDER_WITH;
//        }
//        if ([viewTemp isKindOfClass:[UITextField class]]) {
//            ((UITextField*) viewTemp).textColor = TEXT_COLOR_REPORT;
//            ((UITextField*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
//            ((UITextField*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
//            ((UITextField*) viewTemp).layer.borderWidth = BORDER_WITH;
//        }
    }
    
    //self.view.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
//    self.lbHeader.textColor = TEXT_COLOR_REPORT;
//    [UILabel setBoldLabel:self.lbHeader];
//    self.lbHeader.selectiveBorderFlag = AUISelectiveBordersFlagBottom;
//    self.lbHeader.selectiveBordersColor = BORDER_COLOR;
//    self.lbHeader.selectiveBordersWidth = BORDER_WITH;
    
    
}


- (IBAction)homeBack:(id)sender {
    [Util backToHome:self];
}



#pragma mark table view

#pragma mark - Table View


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
        static NSString *cellId = @"opportunityCell";
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
    
    NSDictionary *dicData = [dtoOpportunityProcess getDataWithKey:DTOOPPORTUNITY_id withValue:[dicDataTemp objectForKey:DTOOPPORTUNITY_id]];
    

        EditOpportunityViewController *viewController = [[EditOpportunityViewController alloc]initWithNibName:@"EditOpportunityViewController" bundle:nil];
        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
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

@end