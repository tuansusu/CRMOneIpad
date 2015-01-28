//
//  DashboardTaskViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/28/15.
//
//

#import "DashboardTaskViewController.h"

#import "DTOTASKProcess.h"
#import "TaskActionCell.h"
#import "EditTaskLeadViewController.h"

static NSString* const TaskActionCellId           = @"TaskActionCellId";

@interface DashboardTaskViewController ()<UISearchBarDelegate, UISearchDisplayDelegate,TaskActionCellDelegate,EditTaskLeadViewControllerDelegate>
{
     __weak IBOutlet UIButton *btnAdd;
    int smgSelect ; //option layout

    NSUserDefaults *defaults;

     NSString *strSearchText ;
     NSArray *arrayData; //mang luu tru du lieu

    DTOTASKProcess *dtoProcess;
}
//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UITextField *lbTypeCustomer;
- (IBAction)actionChoiceTypeOfCustomer:(id)sender;

- (IBAction)actionAdd:(id)sender;
- (IBAction)actionAdvanceSearch:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *leftInMainView;

@property (weak, nonatomic) IBOutlet UIView *leftViewHeader;

@property (weak, nonatomic) IBOutlet UILabel *leftLabelHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet UIView *rightInMainView;

@property (weak, nonatomic) IBOutlet UITableView *tbData;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;


@end

@implementation DashboardTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];

        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }

    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];

    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];

    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
//    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self initData];

    [self.tbData registerNib:[TaskActionCell   nib] forCellReuseIdentifier:TaskActionCellId];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) initData {

    dtoProcess = [DTOTASKProcess new];
    arrayData  = [NSArray new];

    [self filterData];

//    [SVProgressHUD dismiss];
}

#pragma mark custom view

- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = @"KHÁCH HÀNG 360";
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    self.lbTotal.textColor = TEXT_COLOR_HEADER_APP;
    [self.lbTypeCustomer setBorderWithOption:option];

    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;

    [self.btnSearch setStyleNormalWithOption:smgSelect];
    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    self.txtSearchBar.barTintColor = HEADER_VIEW_COLOR1;


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
}

#pragma mark Button action

//Home button
- (IBAction)homeBack:(id)sender {
    [self.view endEditing:YES];
    [Util backToHome:self];
}
//Add action
- (IBAction)actionChoiceTypeOfCustomer:(id)sender {
}

- (IBAction)actionAdd:(id)sender {

    EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
    [viewController setDelegate:self];
    [self presentViewController:viewController animated:YES completion:nil];
}


- (IBAction)actionAdvanceSearch:(id)sender {

    //hidden keyboard
    [self.txtSearchBar resignFirstResponder];

    //tim kiem nang cao
   
}

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

    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){

        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
    EditTaskLeadViewController *viewController = [[EditTaskLeadViewController alloc]initWithNibName:@"EditTaskLeadViewController" bundle:nil];
    viewController.dataSend = dicData;
    [viewController setDelegate:self];
    [self presentViewController:viewController animated:YES completion:nil];

}

#pragma mark UISearach bar delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    NSLog(@"searchOption %d", searchOption);
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    NSLog(@"text did change %@", searchText);
    strSearchText = searchText;
    arrayData=[dtoProcess filterTaskWithKey:DTOTASK_title withValue:searchText];
    // _lbTotal.text=arrayData.count;
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    [_tbData reloadData];
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBarCancelButtonClicked");
    strSearchText = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    NSLog(@"seach click");
    [SVProgressHUD show];
    [self filterData];

    [searchBar resignFirstResponder];

}

//ham loc du lieu
-(void) filterData {

    if ([StringUtil stringIsEmpty:strSearchText]) {
        arrayData = [dtoProcess filterTaskWithKey:DTOTASK_title withValue:@""];
    }else{
        arrayData = [dtoProcess filterTaskWithKey:DTOTASK_title withValue:strSearchText];
    }
    //load data from db
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];

    //NSLog(@"list data = %@", arrayData);
    [self.tbData reloadData];
    [SVProgressHUD dismiss];
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


//        NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
//        deleteLeadId = [dicData objectForKey:DTOACCOUNT_id];
//
//        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
//        mylert.tag = TAG_DELETE_ITEM;
//        [mylert show];


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
    NSLog(@"sua item at index = %d", indexPath.row);

    NSDictionary *dicDataTemp = [arrayData objectAtIndex:indexPath.row];

    NSDictionary *dicData = [dtoProcess getDataWithKey:DTOACCOUNT_id withValue:[dicDataTemp objectForKey:DTOACCOUNT_id]];
    
}

#pragma mark EditTaskLeadViewController delegate

- (void)closeEditTaskLeadViewController:(EditTaskLeadViewController*)editTaskLeadViewController{
    [self filterData];
}



@end
