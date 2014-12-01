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


@interface ListOpportunityViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOOPPORTUNITYProcess *dtoOpportunityProcess;
    
    VTRadio *rdCustomer360; //Radio khach hang 360
    VTRadio *rdCustomerRoot; //radio khach hang dau moi
}
@end

@implementation ListOpportunityViewController

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
    if (index == 0) {
        
    }else if (index == 1){
        
    }
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    dtoOpportunityProcess = [DTOOPPORTUNITYProcess new];
    arrayData  = [NSArray new];
    arrayData = [dtoOpportunityProcess filterOpportunity];
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
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    CompetitorsViewController *viewController = [[CompetitorsViewController alloc] initWithNibName:@"CompetitorsViewController" bundle:nil];
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
}



#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}


@end
