//
//  ListAccountLeadViewController.m
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "ListAccountLeadViewController.h"
#import "DTOACCOUNTLEADProcess.h"





#define SELECT_INDEX_ADD_PERSON 0
#define SELECT_INDEX_ADD_BUSSINESS 1



#define SCOPE_CODE 0
#define SCOPE_NAME 1
#define SCOPE_PHONE 2
#define SCOPE_EMAIL 3
#define SCOPE_ALL 4

#define SELECT_INDEX_TYPE_ALL 0
#define SELECT_INDEX_TYPE_PERSON 1
#define SELECT_INDEX_TYPE_BUSSINESS 2

#define SELECT_TEXT_TYPE_ALL @"Tất cả"
#define SELECT_TEXT_TYPE_PERSON @"Cá nhân"
#define SELECT_TEXT_TYPE_BUSSINESS @"Doanh nghiệp"



@interface ListAccountLeadViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    
    //Chọn loại khách hàng
    NSInteger selectTypeIndex;
    NSArray *listTypeArr;
    
    //controll
    NSString *deleteLeadId ;
    
    __weak IBOutlet UIButton *btnAdd;
    
    //tu khoa dang tim kiem
    NSString *strSearchText ;
    NSInteger iSearchOption;
    
    NSUserDefaults *defaults;
    
}
@end

@implementation ListAccountLeadViewController

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
    
    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];
    [SVProgressHUD show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    [self filterData];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    listTypeArr = [NSArray arrayWithObjects:SELECT_TEXT_TYPE_ALL, SELECT_TEXT_TYPE_PERSON, SELECT_TEXT_TYPE_BUSSINESS, nil];
    selectTypeIndex = 0;
    self.lbTypeCustomer.text = [listTypeArr objectAtIndex:selectTypeIndex];
    

    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_PERSON, SELECT_TEXT_ADD_BUSSINESS, nil];
    iSearchOption = SCOPE_CODE; //
    strSearchText = @"";
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    arrayData  = [NSArray new];
    
    //[self filterData];
    
    [SVProgressHUD dismiss];
}

- (void) updateInterFaceWithOption : (int) option
{
    //self.fullNameLB.text = TITLE_APPLICATION;
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
    static NSString *cellId = @"AccountLeadCell";
    AccountLeadCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [AccountLeadCell initNibCell];
    }
    
    if (arrayData.count>0) {
        [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
        cell.delegate = (id<AccountLeadCellDelegate>) self;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
    
    
    
    DetailLeadViewController *viewController = [[DetailLeadViewController alloc]initWithNibName:@"DetailLeadViewController" bundle:nil];
    viewController.dataSend = dicData;
    [self presentViewController:viewController animated:YES completion:nil];
    
}

#pragma mark SelectIndexDelegate

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    
    switch (index) {
        case SELECT_INDEX_ADD_PERSON:
        {
            EditAccountLeadViewController *viewController = [[EditAccountLeadViewController alloc]initWithNibName:@"EditAccountLeadViewController" bundle:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            case SELECT_INDEX_ADD_BUSSINESS:
        {
            EditBussinessLeadViewController *viewController = [[EditBussinessLeadViewController alloc]initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark Button action

//Home button
- (IBAction)homeBack:(id)sender {
    [Util backToHome:self];
}
//Add action
- (IBAction)actionChoiceTypeOfCustomer:(id)sender {
}

- (IBAction)actionAdd:(id)sender {
    
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

- (IBAction)actionAdvanceSearch:(id)sender {
    
    //hidden keyboard
    [self.txtSearchBar resignFirstResponder];
    
    //tim kiem nang cao
    SearchAdvanceLeadViewController *detail = [[SearchAdvanceLeadViewController alloc]initWithNibName:@"SearchAdvanceLeadViewController" bundle:nil];
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = ((UIButton*) sender).frame;
    
    detail.advanceSearchDelegate =(id<SearchAdvanceDelegate>) self;
    
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(250, 370) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"selectedScopeButtonIndexDidChange = %d", selectedScope);
    iSearchOption = selectedScope;
}
//ham loc du lieu
-(void) filterData {
    
    if ([StringUtil stringIsEmpty:strSearchText]) {
        arrayData = [dtoLeadProcess filter];
    }else{
    
//    switch (iSearchOption) {
//        case SCOPE_ALL:
//            break;
//        case SCOPE_CODE:{
//            arrayData = [dtoLeadProcess filterWithKey:DTOLEAD_code withValue: strSearchText];
//        }
//            break;
//        case SCOPE_EMAIL:{
//            arrayData = [dtoLeadProcess filterWithKey:DTOLEAD_email withValue: strSearchText];
//        }
//            break;
//        case SCOPE_NAME:
//        {
//            arrayData = [dtoLeadProcess filterWithKey:DTOLEAD_name withValue: strSearchText];
//        }
//            break;
//        case SCOPE_PHONE:
//        {
//            arrayData = [dtoLeadProcess filterWithKey:DTOLEAD_mobile withValue: strSearchText];
//        }
//            break;
//        default:
//            break;
//    }
    
    
        NSMutableDictionary *dicCondition = [[NSMutableDictionary alloc]init];
        
            [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_code];
        
        
        
            [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_name];
        
        
        
            [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_mobile];
        
        
        
            [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_email];
        
        
        
        arrayData = [dtoLeadProcess filterWithOrArrayCondition:dicCondition];
        
    }
    //load data from db
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    
    //NSLog(@"list data = %@", arrayData);
    [self.tbData reloadData];
    [SVProgressHUD dismiss];
}

#pragma mark UISearch bar 

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    searchBar.showsScopeBar = YES;
//    [searchBar sizeToFit];
//    
//    NSLog(@"start search");
//    
//    CGRect frame = self.tbData.frame;
//    frame.origin.y = frame.origin.y + searchBar.bounds.size.height;
//    self.tbData.frame = frame;
//    
//    
//    [searchBar setShowsCancelButton:NO animated:YES];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//    CGRect frame = self.tbData.frame;
//    frame.origin.y = frame.origin.y - searchBar.bounds.size.height;
//    self.tbData.frame = frame;
//    
//    NSLog(@"end search");
//    
//    searchBar.showsScopeBar = NO;
//    [searchBar sizeToFit];
//    
//    [searchBar setShowsCancelButton:NO animated:YES];
//    
//    
//    NSLog(@"");
    
    return YES;
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
        
        
        NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
        deleteLeadId = [dicData objectForKey:DTOLEAD_id];
        
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
    
    NSDictionary *dicData = [dtoLeadProcess getDataWithKey:DTOLEAD_id withValue:[dicDataTemp objectForKey:DTOLEAD_id]];
    
    if ([ObjectToStr([dicDataTemp objectForKey:DTOLEAD_leadType]) isEqualToString:FIX_LEADTYPE_PERSON]) {
        
        EditAccountLeadViewController *viewController = [[EditAccountLeadViewController alloc]initWithNibName:@"EditAccountLeadViewController" bundle:nil];
        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }else{
        EditBussinessLeadViewController *viewController = [[EditBussinessLeadViewController alloc]initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
        viewController.dataSend = dicDataTemp;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    

}



#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}

#pragma mark alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == TAG_DELETE_ITEM) {
        //thuc hien xoa
        
     BOOL result =    [dtoLeadProcess deleteEntity:deleteLeadId];
        //reload lai csdl
        if (result) {
            
            [self filterData];
            //thong bao cap nhat thanh cong
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateSuccess delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
            
            [mylert show];
        }else{
            //thong bao cap nhat that bai
            UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:SYS_Notification_UpdateFail delegate:self cancelButtonTitle:KEY_NOTIFICATION_ACCEPT otherButtonTitles:  nil];
        }
        
    }
}

#pragma mark Account lead cell delegate

- (void) AccountLeadCellDelegate_ActionSendMailWithData : (NSDictionary*) dicData {
    [Util sendMail:self withEmail:[dicData objectForKey:DTOLEAD_email]];
}
- (void) AccountLeadCellDelegate_ActionViewMapWithData : (NSDictionary*) dicData {
    //lon lan
    NSLog(@"VIEW ADDRESS = %@", dicData);
    
//    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
//        return;
//    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_lon]]) {
        float fLon = [[dicData objectForKey:DTOLEAD_lon] floatValue];
        float fLan =[[dicData objectForKey:DTOLEAD_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
            viewController.address = [dicData objectForKey:DTOLEAD_address];
        }else{
            viewController.address = @"";
        }

        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    
//    TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
//    
//    
//    [self presentViewController:viewController animated:YES completion:nil];
}
- (void) AccountLeadCellDelegate_ActionChangeFlowWithData : (NSDictionary*) dicData {
    
    //Tạm thời hiển thị form thêm mới theo dõi
    //sau hỏi rõ giải pháp tính sau
    FlowLeadViewController *detail = [[FlowLeadViewController alloc] initWithNibName:@"FlowLeadViewController" bundle:nil];
    detail.dataSend=dicData;
    detail.view.frame = CGRectMake(0, 0, 600, 500);
    //[InterfaceUtil setBorderWithCornerAndBorder:detail.view :6 :0.2 :nil];
    [self presentPopupViewController:detail animationType:1];
}

#pragma mark ADVANCE SEARCH
-(void) actionSearchAdvanceWithCode:(NSString *)strCode withName:(NSString *)strName withMobile:(NSString *)strMobile withEmail:(NSString *)strEmail{
    
    NSMutableDictionary *dicCondition = [[NSMutableDictionary alloc]init];
    if (![StringUtil stringIsEmpty:strCode]) {
        [dicCondition setObject:[StringUtil trimString:strCode] forKey:DTOLEAD_code];
    }
    
    if (![StringUtil stringIsEmpty:strName]) {
        [dicCondition setObject:[StringUtil trimString:strName] forKey:DTOLEAD_name];
    }
    
    if (![StringUtil stringIsEmpty:strMobile]) {
        [dicCondition setObject:[StringUtil trimString:strMobile] forKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:strEmail]) {
        [dicCondition setObject:[StringUtil trimString:strEmail] forKey:DTOLEAD_email];
    }
    
    
    arrayData = [dtoLeadProcess filterWithArrayCondition:dicCondition];
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    
    [self.tbData reloadData];
}
-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}

#pragma mark sendTime

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    switch (result)
	{
		case MFMailComposeResultCancelled:
			//NSLog(@"Cancelled");
			break;
		case MFMailComposeResultSaved:
			//NSLog(@"Saved");
			break;
		case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"Gửi email thành công!"];
            [alert setMessage:nil];
            [alert setDelegate:self];
            [alert addButtonWithTitle:@"Thoát"];
            
            [alert show];
            
        }
			break;
		case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc] init];
            [alert setTitle:@"Không gửi được email!"];
            [alert setMessage:nil];
            [alert setDelegate:self];
            [alert addButtonWithTitle:@"Thoát"];
            
            [alert show];
            
        }
			break;
            
			//NSLog(@"Not send");
    }
	[self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
