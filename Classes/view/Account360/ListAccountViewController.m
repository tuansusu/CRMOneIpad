//
//  ListAccountViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/4/14.
//
//

#import "ListAccountViewController.h"
#import "DTOACCOUNTProcess.h"
#import "EditAccount360ViewController.h"
#import "DTOFLLOWUPProcess.h"
#import "UIMenuItem+CXAImageSupport.h"
//Xoa
#import "DataField.h"


#define SELECT_INDEX_ADD_PERSON 0
#define SELECT_INDEX_ADD_BUSSINESS 1

#define SELECT_TEXT_ADD_PERSON @"Khách hàng cá nhân"
#define SELECT_TEXT_ADD_BUSSINESS @"Khách hàng doanh nghiệp"

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

@interface ListAccountViewController ()
{
    int smgSelect ; //option layout
    NSMutableArray *arrayData; //mang luu tru du lieu
    
    DTOACCOUNTProcess *dtoProcess;
    
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
    NSString *accountfollowId;
    int loaded,perload, totalCount;
    //them phan phan trang
    BOOL loading, noMoreResultsAvail;
    UIActivityIndicatorView *spinner;
}
@end

@implementation ListAccountViewController

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
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self initData];
    
    [SVProgressHUD show];
    //set menu
    //    UIMenuItem *viewMenu = [[UIMenuItem alloc] initWithTitle:@"Xem" action:@selector(view:)];
    //
    //
    //    UIMenuItem *editMenu = [[UIMenuItem alloc] initWithTitle:@"Sửa" action:@selector(edit:)];
    //
    //
    //    UIMenuItem *delMenu = [[UIMenuItem alloc] initWithTitle:@"Xoá" action:@selector(del:)];
    //
    //    UIMenuItem *callMenu = [[UIMenuItem alloc] initWithTitle:@"Gọi điện" action:@selector(call:)];
    //
    //    UIMenuItem *smsMenu = [[UIMenuItem alloc] initWithTitle:@"SMS" action:@selector(sms:)];
    //
    //    UIMenuItem *emailMenu = [[UIMenuItem alloc] initWithTitle:@"Email" action:@selector(email:)];
    //
    //    UIMenuItem *fowlMenu = [[UIMenuItem alloc] initWithTitle:@"Theo dõi" action:@selector(follow:)];
    //
    //    UIMenuItem *mapMenu = [[UIMenuItem alloc] initWithTitle:@"Bản đồ" action:@selector(map:)];
    //    [[UIMenuController sharedMenuController] setMenuItems: @[viewMenu,editMenu,delMenu,callMenu,smsMenu,emailMenu,fowlMenu,mapMenu]];
    //    [[UIMenuController sharedMenuController] update];
    
    UIMenuItem *viewMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Xem", nil) action:@selector(view:) image:[UIImage imageNamed:@"menuview.png"]];
    
    UIMenuItem *editMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Sửa", nil) action:@selector(edit:) image:[UIImage imageNamed:@"menuedit.png"]];
    
    UIMenuItem *delMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Xoá", nil) action:@selector(del:) image:[UIImage imageNamed:@"menudelete.png"]];
    
    UIMenuItem *callMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Gọi điện", nil) action:@selector(call:) image:[UIImage imageNamed:@"menuphone.png"]];
    
    UIMenuItem *smsMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"SMS", nil) action:@selector(sms:) image:[UIImage imageNamed:@"menumessage.png"]];
    
    UIMenuItem *emailMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Email", nil) action:@selector(email:) image:[UIImage imageNamed:@"menuemail.png"]];
    
    UIMenuItem *fowlMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Theo dõi", nil) action:@selector(follow:) image:[UIImage imageNamed:@"menuflag.png"]];
    
    
    UIMenuItem *mapMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Bản đồ", nil) action:@selector(map:) image:[UIImage imageNamed:@"menumap.png"]];
    
    [[UIMenuController sharedMenuController] setMenuItems: @[viewMenu,editMenu,delMenu,callMenu,smsMenu,emailMenu,fowlMenu,mapMenu]];
    [[UIMenuController sharedMenuController] update];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) viewDidAppear:(BOOL)animated{
    //[self initData];
    [self filterData];
    [SVProgressHUD dismiss];
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
    
    dtoProcess = [DTOACCOUNTProcess new];
    arrayData  = [NSMutableArray new];
    
    //[self filterData];
    
    
}

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
    
    //Cell loading
    if((arrayData.count) == indexPath.row){
        static NSString *cellIndentifier =@"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil){
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        if (!noMoreResultsAvail) {
            
            NSLog(@"VT1");
            spinner.hidden =NO;
            cell.textLabel.text=nil;
            
            
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinner.frame = CGRectMake(tableView.frame.size.width/2-12, 0, 24, 50);
            [cell addSubview:spinner];
            
            if (arrayData.count >= 10) {
                [spinner startAnimating];
            }
        }
        else{
            NSLog(@"VT2");
            [spinner stopAnimating];
            spinner.hidden=YES;
            
            cell.textLabel.text=nil;
            
            UILabel* loadingLabel = [[UILabel alloc]init];
            loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
            loadingLabel.textAlignment = UITextAlignmentLeft;
            loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
            loadingLabel.numberOfLines = 0;
            loadingLabel.text=@"No More data Available";
            loadingLabel.frame=CGRectMake(85,20, 302,25);
            [cell addSubview:loadingLabel];
        }
        
        return cell;
    }
    
    
    static NSString *cellId = @"Account360Cell";
    Account360Cell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [Account360Cell initNibCell];
    }
    
    if (arrayData.count>0) {
        [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
        cell.delegate = (id<Account360CellDelegate>) self;
    }
    return cell;
    
}
//phan trang
-(void) resetLoadData {
    loaded = 0;
    arrayData  = [NSMutableArray new];
    self.lbTotal.text = @"";
}
//phân trang
#pragma UIScroll View Method::
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (arrayData.count<totalCount) {
        loaded = loaded + PAGESIZE;
        
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self performSelector:@selector(filterData) withObject:nil afterDelay:1];
            
        }
    }
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return (action == @selector(view:)||action == @selector(edit:)||action == @selector(del:)||action == @selector(call:)||action == @selector(sms:)||action == @selector(email:)||action == @selector(follow:)||action == @selector(map:));
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    
    if (action == @selector(view:)){
        NSLog(@"xem");}
    
    if (action == @selector(edit:)){
        NSLog(@"sua");}
    
    if (action == @selector(del:)){
        NSLog(@"ixoa");}
    
    if (action == @selector(call:)){
        NSLog(@"goi");}
    
    if (action == @selector(sms:)){
        NSLog(@"sms");}
    
    if (action == @selector(email:)){
        NSLog(@"email");}
    if (action == @selector(follow:)){
        NSLog(@"tho doi");}
    if (action == @selector(map:)){
        NSLog(@"ban do");}
}

-(void)view:(id)sender{
    
    Detail360ViewController *viewController = [[Detail360ViewController alloc]initWithNibName:@"Detail360ViewController" bundle:nil];
    //viewController.dataSend = _dicData;
    [self presentViewController:viewController animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
    
    
    
    Detail360ViewController *viewController = [[Detail360ViewController alloc]initWithNibName:@"Detail360ViewController" bundle:nil];
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
            EditAccount360ViewController *viewController = [[EditAccount360ViewController alloc]initWithNibName:@"EditAccount360ViewController" bundle:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        }
            break;
        case SELECT_INDEX_ADD_BUSSINESS:
        {
            EditBussiness360ViewController *viewController = [[EditBussiness360ViewController alloc]initWithNibName:@"EditBussiness360ViewController" bundle:nil];
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
    [self.view endEditing:YES];
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
    CGRect popoverFrame = _btnAdd.frame;
    
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
    //NSLog(@"text did change %@", searchText);
    strSearchText = searchText;
    //strSearchText = @"1010";
    //arrayData=[dtoLeadProcess filterWithKey:DTOLEAD_name withValue:searchText];
    //_lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    [self resetLoadData];
    [self filterData];
    //[_tbData reloadData];
}


-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchBarCancelButtonClicked");
    strSearchText = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    NSLog(@"seach click");
    [SVProgressHUD show];
    [self resetLoadData];
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
        //arrayData = [dtoLeadProcess filter];
        //arrayData =  [dtoLeadProcess filterWithStart:loaded withLimit:PAGESIZE withOutTotal:&totalCount];
        [arrayData addObjectsFromArray:[dtoProcess filterWithStart:loaded withLimit:PAGESIZE withOutTotal:&totalCount]];
    }else{
        
        NSMutableDictionary *dicCondition = [[NSMutableDictionary alloc]init];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOACCOUNT_code];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOACCOUNT_name];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOACCOUNT_mobile];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOACCOUNT_email];
        //arrayData = [dtoLeadProcess filterWithOrArrayCondition:dicCondition];
        [arrayData addObjectsFromArray:[dtoProcess filterWithOrArrayCondition:dicCondition withStart:loaded withLimit:PAGESIZE withOutTotal:&totalCount]];
        
    }
    //load data from db
    //_lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    self.lbTotal.text = [NSString stringWithFormat:@"Tổng số %d / %d", arrayData.count, totalCount ];
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
    //
    //    [searchBar setShowsCancelButton:NO animated:YES];
    //
    
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
        deleteLeadId = [dicData objectForKey:DTOACCOUNT_id];
        
        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
        mylert.tag = TAG_DELETE_ITEM;
        [mylert show];
        
        
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
    //    NSLog(@"sua item at index = %d", indexPath.row);
    //
    //    NSDictionary *dicDataTemp = [arrayData objectAtIndex:indexPath.row];
    //
    //    NSDictionary *dicData = [dtoProcess getDataWithKey:DTOACCOUNT_id withValue:[dicDataTemp objectForKey:DTOACCOUNT_id]];
    //
    //    if ([ObjectToStr([dicDataTemp objectForKey:DTOACCOUNT_accountType]) isEqualToString:FIX_LEADTYPE_PERSON]) {
    //
    //        EditAccount360ViewController *viewController = [[EditAccount360ViewController alloc]initWithNibName:@"EditAccount360ViewController" bundle:nil];
    //        viewController.dataSend = dicData;
    //        [self presentViewController:viewController animated:YES completion:nil];
    //    }else{
    //        EditBussiness360ViewController *viewController = [[EditBussiness360ViewController alloc]initWithNibName:@"EditBussiness360ViewController" bundle:nil];
    //        // viewController.dataSend = dicDataTemp;
    //        [self presentViewController:viewController animated:YES completion:nil];
    //    }
    
    
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
        
        BOOL result =    [dtoProcess deleteEntity:deleteLeadId];
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
    
    else if(buttonIndex==0 && alertView.tag==22){
        NSLog(@"id:%@",accountfollowId);
        DTOFLLOWUPProcess *followProcess=[DTOFLLOWUPProcess new];
        NSMutableDictionary *dicEntity=[NSMutableDictionary new];
        [dicEntity setObject:accountfollowId forKey:DTOFOLLOWUP_id];
        [dicEntity setObject:@"3" forKey:DTOFOLLOWUP_followUpState];
        BOOL success=[followProcess insertToDBWithEntity:dicEntity];
        if(success){
            [self filterData];
        }
        else{
            NSLog(@"Error");
        }
    }
}

#pragma mark Account lead cell delegate

- (void) Account360CellDelegate_ActionSendMailWithData : (NSDictionary*) dicData {
    
    [Util sendMail:self withEmail:[dicData objectForKey:DTOACCOUNT_email]];
    
}
- (void) Account360CellDelegate_ActionViewMapWithData : (NSDictionary*) dicData {
    //lon lan
    NSLog(@"VIEW ADDRESS = %@", dicData);
    
    //    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
    //        return;
    //    }
    
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_lat]]) {
        float fLon = [[dicData objectForKey:DTOACCOUNT_lon] floatValue];
        float fLan =[[dicData objectForKey:DTOACCOUNT_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
            viewController.address = [dicData objectForKey:DTOACCOUNT_address];
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
- (void) Account360CellDelegate_ActionChangeFlowWithData : (NSDictionary*) dicData {
    
    //Tạm thời hiển thị form thêm mới theo dõi
    //sau hỏi rõ giải pháp tính sau
    Follow360ViewController *detail = [[Follow360ViewController alloc] initWithNibName:@"Follow360ViewController" bundle:nil];
    detail.dataSend=dicData;
    detail.delegate=self;
    detail.view.frame = CGRectMake(0, 0, 600, 500);
    //[InterfaceUtil setBorderWithCornerAndBorder:detail.view :6 :0.2 :nil];
    [self presentPopupViewController:detail animationType:1];
}


#pragma mark ADVANCE SEARCH
-(void) actionSearchAdvanceWithCode:(NSString *)strCode withName:(NSString *)strName withMobile:(NSString *)strMobile withEmail:(NSString *)strEmail{
    
    NSMutableDictionary *dicCondition = [[NSMutableDictionary alloc]init];
    if (![StringUtil stringIsEmpty:strCode]) {
        [dicCondition setObject:[StringUtil trimString:strCode] forKey:DTOACCOUNT_code];
    }
    
    if (![StringUtil stringIsEmpty:strName]) {
        [dicCondition setObject:[StringUtil trimString:strName] forKey:DTOACCOUNT_name];
    }
    
    if (![StringUtil stringIsEmpty:strMobile]) {
        [dicCondition setObject:[StringUtil trimString:strMobile] forKey:DTOACCOUNT_mobile];
    }
    
    if (![StringUtil stringIsEmpty:strEmail]) {
        [dicCondition setObject:[StringUtil trimString:strEmail] forKey:DTOACCOUNT_email];
    }
    
    
    //arrayData = [dtoProcess filterWithArrayCondition:dicCondition];
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    
    [self.tbData reloadData];
}
-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}
//phần chọn của menu

- (void) delegate_view : (NSDictionary*) dicData {
    Detail360ViewController *detail = [[Detail360ViewController alloc] initWithNibName:@"Detail360ViewController" bundle:nil];
    detail.dataSend=dicData;
    [self presentViewController:detail animated:YES completion:nil];
}
-(void) delegate_edit:(NSDictionary *)dicData{
    NSLog(@"Chuaw cos");
}
-(void) delegate_del:(NSDictionary *)dicData{
    
    deleteLeadId = [dicData objectForKey:DTOACCOUNT_id];
    
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Xác nhận đồng ý xoá?" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles: @"Huỷ", nil];
    mylert.tag = TAG_DELETE_ITEM;
    [mylert show];
    
}
-(void) delegate_call:(NSDictionary *)dicData{
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_phone]]){
        NSString *callnumber=[NSString stringWithFormat:@"telprompt://%@",[dicData objectForKey:DTOACCOUNT_phone]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callnumber]];
    }
}
-(void) delegate_sms:(NSDictionary *)dicData{
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_phone]]){
        NSString *sendSMS=[NSString stringWithFormat:@"sms://%@",[dicData objectForKey:DTOACCOUNT_phone]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sendSMS]];
    }
}
-(void) delegate_email:(NSDictionary *)dicData{
    [Util sendMail:self withEmail:[dicData objectForKey:DTOACCOUNT_email]];
}
-(void) delegate_follow:(NSDictionary *)dicData{
    Follow360ViewController *detail = [[Follow360ViewController alloc] initWithNibName:@"Follow360ViewController" bundle:nil];
    detail.dataSend=dicData;
    detail.view.frame = CGRectMake(0, 0, 600, 500);
    //[InterfaceUtil setBorderWithCornerAndBorder:detail.view :6 :0.2 :nil];
    [self presentPopupViewController:detail animationType:1];
}
-(void) delegate_maps:(NSDictionary *)dicData{
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_lat]]) {
        float fLon = [[dicData objectForKey:DTOACCOUNT_lon] floatValue];
        float fLan =[[dicData objectForKey:DTOACCOUNT_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
        viewController.lan = fLan;
        viewController.lon = fLon;
        //viewController.address = [dicData objectForKey:DTOLEAD_address];
        if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOACCOUNT_address]]) {
            viewController.address = [dicData objectForKey:DTOACCOUNT_address];
        }else{
            viewController.address = @"";
        }
        
        
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
}
#pragma mark change status follow
-(void) delegate_changeStatusFollow:(NSString *)followid{
    
    accountfollowId=followid;
    UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Hoàn thành theo dõi" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:@"Huỷ", nil];
    aler.tag=22;
    [aler show];
}
-(void)delegate_dismisFollow:(int)item{
    NSLog(@"abc");
    if(item==0){
        [self dismissPopupViewControllerWithanimationType:nil];
    }
    else{
        [self dismissPopupViewControllerWithanimationType:nil];
        [self filterData];
    }
}



#pragma mark sendmail

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
