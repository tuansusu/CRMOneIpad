//
//  ListAccountLeadViewController.m
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "ListAccountLeadViewController.h"
#import "DTOACCOUNTLEADProcess.h"
#import "DTOFLLOWUPProcess.h"
#import "UIMenuItem+CXAImageSupport.h"
#import "EnumClass.h"
#import "Util.h"

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
    NSUserDefaults *defaults;
    int smgSelect ; //option layout
    NSMutableArray *arrayData; //mang luu tru du lieu
    
    DTOACCOUNTLEADProcess *dtoLeadProcess;
    Util *util;
    
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
    
    NSDictionary *dataDetail;
    NSString *followId;
    
    Language *obj;
    
    
    //them phan phan trang
    BOOL loading, noMoreResultsAvail;
    UIActivityIndicatorView *spinner;
    
    int loaded,perload, totalCount;
    
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
        
        
    }
    
    obj=[Language getInstance];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    obj.str =[defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    util=[Util new];
    
    [self initData];
    
    [self.tbData registerNib:[UINib nibWithNibName:@"OpportunityCell" bundle:nil] forCellReuseIdentifier:@"opportunityCell"];
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [SVProgressHUD show];
    [self setLanguage];
    //set menu
    UIMenuController *menuControler =  [UIMenuController sharedMenuController];
    
    
    UIMenuItem *viewMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Xem", nil) action:@selector(view:) image:[UIImage imageNamed:@"menuview.png"]];
    
    UIMenuItem *editMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Sửa", nil) action:@selector(edit:) image:[UIImage imageNamed:@"menuedit.png"]];
    
    UIMenuItem *delMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Xoá", nil) action:@selector(del:) image:[UIImage imageNamed:@"menudelete.png"]];
    
    UIMenuItem *emailMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Email", nil) action:@selector(email:) image:[UIImage imageNamed:@"menuemail.png"]];
    
    UIMenuItem *fowlMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Theo dõi", nil) action:@selector(follow:) image:[UIImage imageNamed:@"menuflag.png"]];
    
    
    UIMenuItem *mapMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Bản đồ", nil) action:@selector(map:) image:[UIImage imageNamed:@"menumap.png"]];
    
    
    if([self currentDeviceType]==iPad){
        [menuControler setMenuItems: @[viewMenu,editMenu,delMenu,emailMenu,fowlMenu,mapMenu]];
        [[UIMenuController sharedMenuController] update];
    }
    if ([self currentDeviceType]==iPhone) {
        UIMenuItem *callMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"Gọi điện", nil) action:@selector(call:) image:[UIImage imageNamed:@"menuphone.png"]];
        
        UIMenuItem *smsMenu = [[UIMenuItem alloc] cxa_initWithTitle:NSLocalizedString(@"SMS", nil) action:@selector(sms:) image:[UIImage imageNamed:@"menumessage.png"]];
        [menuControler setMenuItems: @[viewMenu,editMenu,delMenu,callMenu,smsMenu,emailMenu,fowlMenu,mapMenu]];
        [menuControler update];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    [self resetLoadData];
    [self filterData];
}

//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    listTypeArr = [NSArray arrayWithObjects:SELECT_TEXT_TYPE_ALL, SELECT_TEXT_TYPE_PERSON, SELECT_TEXT_TYPE_BUSSINESS, nil];
    selectTypeIndex = 0;
    self.lbTypeCustomer.text = [listTypeArr objectAtIndex:selectTypeIndex];
    
    
    listArr  = [NSArray arrayWithObjects:LocalizedString(@"KEY_LEAD_ADD_CN"), LocalizedString(@"KEY_LEAD_ADD_DN"), nil];
    iSearchOption = SCOPE_CODE; //
    strSearchText = @"";
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    arrayData  = [NSMutableArray new];
    
    
    
    [SVProgressHUD dismiss];
}

//phan trang
-(void) resetLoadData {
    loaded = 0;
    arrayData  = [NSMutableArray new];
    self.lbTotal.text = @"";
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
    
    
    if([self currentDeviceType]==iPad){
        self.txtSearchBar.barTintColor = HEADER_VIEW_COLOR1;
    }
    
    
    for (UIView *viewTemp in self.leftInMainView.subviews) {
        if ([viewTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            continue;
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            ((UIButton*) viewTemp).backgroundColor = BUTTON_IN_ACTIVE_COLOR_1;
            [((UIButton*) viewTemp) setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
            continue;
        }
        if ([viewTemp isKindOfClass:[UITextView class]]) {
            ((UITextView*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextView*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextView*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextView*) viewTemp).layer.borderWidth = BORDER_WITH;
            continue;
        }
        if ([viewTemp isKindOfClass:[UITextField class]]) {
            ((UITextField*) viewTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextField*) viewTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextField*) viewTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextField*) viewTemp).layer.borderWidth = BORDER_WITH;
            continue;
        }
        if ([viewTemp isKindOfClass:[UIImageView class]]) {
            
            [((UIImageView*) viewTemp) setAlpha:1.0f];
            continue;
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
    if((arrayData.count) == indexPath.row){
        
        return 50.0f;
    }
    else {
        
        NSString  *currentDevice = [UIDevice currentDevice].model;
        if([currentDevice isEqualToString:@"iPhone"] || [currentDevice isEqualToString:@"iPhone Simulator"]){
            return 50.0f;
        }
        else{
            return 100.0f;
        }
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(arrayData.count >= totalCount){
        return arrayData.count;
    }
    else {
        return arrayData.count +1;
    }
    
    
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
            
            if (arrayData.count >= 10 && arrayData.count !=0) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *arrayTable = [arrayData objectAtIndex:indexPath.row];
    NSString *name=[arrayTable objectForKey:DTOLEAD_name];
    //    NSString  *currentDevice = [UIDevice currentDevice].model;
    //    if([currentDevice isEqualToString:@"iPhone"] || [currentDevice isEqualToString:@"iPhone Simulator"]){
    //
    //        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:name
    //                                                                 delegate:self
    //                                                        cancelButtonTitle:LocalizedString(@"KEY_CANCEL")
    //                                                   destructiveButtonTitle:LocalizedString(@"MENU_ACTIONSHEET_VIEW")
    //                                                        otherButtonTitles:LocalizedString(@"MENU_ACTIONSHEET_EDIT"),LocalizedString(@"MENU_ACTIONSHEET_DEL"),LocalizedString(@"MENU_ACTIONSHEET_CALL"),LocalizedString(@"MENU_ACTIONSHEET_SMS"),LocalizedString(@"MENU_ACTIONSHEET_Email"),LocalizedString(@"MENU_ACTIONSHEET_FOLLOW"),LocalizedString(@"MENU_ACTIONSHEET_MAPS"), nil];
    //        // [actionSheet showFromRect:cellRect inView:[UIApplication sharedApplication].keyWindow animated:YES];
    //        actionSheet.tag=11;
    //        dataDetail =[arrayData objectAtIndex:indexPath.row];
    //        [actionSheet showInView:self.view];
    //    }
    //    else{
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
    
    
    
    DetailLeadViewController *viewController = [[DetailLeadViewController alloc]initWithNibName:@"DetailLeadViewController" bundle:nil];
    viewController.dataSend = dicData;
    
    [self presentViewController:viewController animated:YES completion:nil];
    //}
    
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
    [self.listPopover setPopoverContentSize:CGSizeMake(500, 320) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.headerViewBar permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


#pragma mark UISearach bar delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    NSString *safeSearchString = [[searchText componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]] componentsJoinedByString:@""];
//    searchBar.text=safeSearchString;
}
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    strSearchText = @"";
    searchBar.text=@"";
    [SVProgressHUD show];
    [self resetLoadData];
    [self filterData];
    [searchBar resignFirstResponder];
}
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton=YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton=NO;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    strSearchText = searchBar.text;
    [SVProgressHUD show];
    [self resetLoadData];
    [self filterData];
    [searchBar resignFirstResponder];
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    
    iSearchOption = selectedScope;
}
//ham loc du lieu
-(void) filterData {
    
    if ([StringUtil stringIsEmpty:strSearchText]) {
        //arrayData = [dtoLeadProcess filter];
        //arrayData =  [dtoLeadProcess filterWithStart:loaded withLimit:PAGESIZE withOutTotal:&totalCount];
        [arrayData addObjectsFromArray:[dtoLeadProcess filterWithStart:loaded withLimit:PAGESIZE withOutTotal:&totalCount]];
    }else{
        
        NSMutableDictionary *dicCondition = [[NSMutableDictionary alloc]init];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_code];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_name];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_mobile];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOLEAD_email];
        [dicCondition setObject:[StringUtil trimString:strSearchText] forKey:DTOACCOUNT_address];
        //arrayData = [dtoLeadProcess filterWithOrArrayCondition:dicCondition];
        [arrayData addObjectsFromArray:[dtoLeadProcess filterWithOrArrayCondition:dicCondition withStart:loaded withLimit:PAGESIZE withOutTotal:&totalCount]];
        
    }
    //load data from db
    //_lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    self.lbTotal.text = [NSString stringWithFormat:@"%@ %d / %d",LocalizedString(@"KEY_LIST_360_TOTAL"), arrayData.count, totalCount ];
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
        
        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_DEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles: LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
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
            [self resetLoadData];
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
        NSLog(@"id:%@",followId);
        DTOFLLOWUPProcess *followProcess=[DTOFLLOWUPProcess new];
        NSMutableDictionary *dicEntity=[NSMutableDictionary new];
        [dicEntity setObject:followId forKey:DTOFOLLOWUP_id];
        [dicEntity setObject:@"3" forKey:DTOFOLLOWUP_followUpState];
        BOOL success=[followProcess insertToDBWithEntity:dicEntity];
        if(success){
            [self resetLoadData];
            [self filterData];
        }
        else{
            NSLog(@"Error");
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
        viewController.typeMapView = typeMapView_View;
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
    detail.delegate = self;
    detail.view.frame = CGRectMake(0, 0, 600, 500);
    //[InterfaceUtil setBorderWithCornerAndBorder:detail.view :6 :0.2 :nil];
    [self presentPopupViewController:detail animationType:1];
}

#pragma mark ADVANCE SEARCH
-(void) actionSearchAdvanceWithCode:(NSString *)strCode withName:(NSString *)strName withMobile:(NSString *)strMobile withEmail:(NSString *)strEmail   withmsthue:(NSString *)strMSthue withCMT: (NSString *) strCMT withDKKD:(NSString *)soDKKD{
    
    
    NSMutableDictionary *dicCondition = [[NSMutableDictionary alloc]init];
    if (![StringUtil stringIsEmpty:strCode]) {
        [dicCondition setObject:[StringUtil trimString:strCode] forKey:DTOLEAD_code];
    }
    
    if (![StringUtil stringIsEmpty:strName] && [util CharacterNoEnter:strName]) {
        [dicCondition setObject:[StringUtil trimString:strName] forKey:DTOLEAD_name];
    }
    
    if (![StringUtil stringIsEmpty:strMobile]) {
        [dicCondition setObject:[StringUtil trimString:strMobile] forKey:DTOLEAD_mobile];
    }
    
    if (![StringUtil stringIsEmpty:strEmail]) {
        [dicCondition setObject:[StringUtil trimString:strEmail] forKey:DTOLEAD_email];
    }
    if (![StringUtil stringIsEmpty:strCMT]) {
        [dicCondition setObject:[StringUtil trimString:strCMT] forKey:DTOLEAD_identifiedNumber];
    }
    if (![StringUtil stringIsEmpty:strMSthue]) {
        [dicCondition setObject:[StringUtil trimString:strMSthue] forKey:DTOLEAD_taxCode];
    }
    if (![StringUtil stringIsEmpty:soDKKD]) {
        [dicCondition setObject:[StringUtil trimString:soDKKD] forKey:DTOLEAD_registrationNumber];
    }
    
    arrayData = [dtoLeadProcess filterWithArrayCondition:dicCondition];
    _lbTotal.text = [NSString stringWithFormat:@"Tổng số %d", arrayData.count];
    totalCount = arrayData.count;
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

//phần chọn của menu

- (void) delegate_view : (NSDictionary*) dicData {
    DetailLeadViewController *detail = [[DetailLeadViewController alloc] initWithNibName:@"DetailLeadViewController" bundle:nil];
    detail.dataSend=dicData;
    [self presentViewController:detail animated:YES completion:nil];
}
-(void) delegate_edit:(NSDictionary *)dicData{
    
    if ([ObjectToStr([dicData objectForKey:DTOLEAD_leadType]) isEqualToString:FIX_LEADTYPE_PERSON]) {
        
        EditAccountLeadViewController *viewController = [[EditAccountLeadViewController alloc]initWithNibName:@"EditAccountLeadViewController" bundle:nil];
        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }else{
        EditBussinessLeadViewController *viewController = [[EditBussinessLeadViewController alloc]initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
        viewController.dataSend = dicData;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}
-(void) delegate_del:(NSDictionary *)dicData{
    
    deleteLeadId = [dicData objectForKey:DTOACCOUNT_id];
    
    UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_DEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles: LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
    mylert.tag = TAG_DELETE_ITEM;
    [mylert show];
    
}

#pragma mark change status follow
-(void) delegate_changeStatusFollow:(NSString *)followid{
    
    followId=followid;
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_INFO_CONFIRM_MESSAGE_1") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles: LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
    aler.tag=22;
    [aler show];
}

-(void) delegate_call:(NSDictionary *)dicData{
    NSString *mobile = [dicData objectForKey:DTOLEAD_mobile];
    if(![StringUtil stringIsEmpty:mobile]){
        NSString *callnumber=[NSString stringWithFormat:@"telprompt://%@",mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callnumber]];
    }
}
-(void) delegate_sms:(NSDictionary *)dicData{
    if(![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_mobile]]){
        NSString *sendSMS=[NSString stringWithFormat:@"sms://%@",[dicData objectForKey:DTOLEAD_mobile]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sendSMS]];
    }
}
-(void) delegate_email:(NSDictionary *)dicData{
    [Util sendMail:self withEmail:[dicData objectForKey:DTOLEAD_email]];
}
-(void) delegate_follow:(NSDictionary *)dicData{
    FlowLeadViewController *detail = [[FlowLeadViewController alloc] initWithNibName:@"FlowLeadViewController" bundle:nil];
    detail.dataSend=dicData;
    detail.delegate=self;
    if([self currentDeviceType]==iPhone){
        [self presentViewController:detail animated:YES completion:nil];
    }
    else{
        detail.view.frame = CGRectMake(0, 0, 600, 500);
        [self presentPopupViewController:detail animationType:1];
    }
    //[InterfaceUtil setBorderWithCornerAndBorder:detail.view :6 :0.2 :nil];
    
}
-(void) delegate_maps:(NSDictionary *)dicData{
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_lat]]) {
        float fLon = [[dicData objectForKey:DTOLEAD_lon] floatValue];
        float fLan =[[dicData objectForKey:DTOLEAD_lat] floatValue];
        
        TestMapViewController *viewController = [[TestMapViewController alloc]initWithNibName:@"TestMapViewController" bundle:nil];
        viewController.typeMapView = typeMapView_View;
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
}
-(void)delegate_dismisFollow:(int)item{
    NSLog(@"abc");
    if(item==0){
        [self dismissPopupViewControllerWithanimationType:nil];
    }
    else{
        [self dismissPopupViewControllerWithanimationType:nil];
        [self resetLoadData];
        [self filterData];
    }
}
-(void) setLanguage{
    [_lbTotal setText:LocalizedString(@"KEY_LIST_360_TOTAL")];
    _fullNameLB.text=LocalizedString(@"KEY_LEAD_TITLE");
    [_txtSearchBar setPlaceholder:LocalizedString(@"KEY_LIST_360_TITLE_SEARCH")];
    
    
}
- (IBAction)actionAdd_IP:(id)sender {
    UIActionSheet *actionSheer=[[UIActionSheet alloc] initWithTitle:LocalizedString(@"KEY_LEAD_ADD_TITEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL")destructiveButtonTitle:LocalizedString(@"KEY_LEAD_ADD_CN") otherButtonTitles:LocalizedString(@"KEY_LEAD_ADD_DN"), nil];
    [actionSheer showInView:self.view];
}
//ham thuc thi cua actiosheet tren IP
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Index = %d - Title = %@", buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    if(actionSheet.tag==11)
    {
        if(buttonIndex==0){
            DetailLeadViewController *detail=[[DetailLeadViewController alloc] initWithNibName:@"DetailLeadViewController" bundle:nil];
            detail.dataSend=dataDetail;
            [self presentViewController:detail animated:YES completion:nil];
        }
        else if(buttonIndex == 1){
            if( [[dataDetail objectForKey:DTOLEAD_leadType] isEqualToString:@"0"]){
                EditAccountLeadViewController *edit=[[EditAccountLeadViewController alloc] initWithNibName:@"EditAccountLeadViewController"
                                                                                                    bundle:nil];
                edit.dataSend = dataDetail;
                [self presentViewController:edit animated:YES completion:nil];
            }
            else{
                EditBussinessLeadViewController *edit=[[EditBussinessLeadViewController alloc] initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
                edit.dataSend=dataDetail;
                [self presentViewController:edit animated:YES completion:nil];
            }
        }
        else if(buttonIndex==2){
            [self delegate_del:dataDetail];
        }
        else if(buttonIndex==3){
            [self delegate_call:dataDetail];
        }
        else if(buttonIndex==4){
            [self delegate_sms:dataDetail];
        }
        else if(buttonIndex==5){
            [self delegate_email:dataDetail];
        }
        else if(buttonIndex==6){
            [self delegate_follow:dataDetail];
        }
        else if(buttonIndex==7){
            [self delegate_maps:dataDetail];
        }
    }
    else{
        if(buttonIndex==0){
            EditAccountLeadViewController *viewController=[[EditAccountLeadViewController alloc] initWithNibName:@"EditAccountLeadViewController" bundle:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else if (buttonIndex ==1){
            
            EditBussinessLeadViewController *viewController=[[EditBussinessLeadViewController alloc] initWithNibName:@"EditBussinessLeadViewController" bundle:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        }
    }
}
@end
