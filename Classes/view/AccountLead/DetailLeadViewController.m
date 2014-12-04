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

@interface DetailLeadViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    
    DTOCONTACTProcess *dtoContactProcess; //lay danh sach du lieu theo clientLeadId
    
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
    
    //controll
    
    __weak IBOutlet UIButton *btnAdd;
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
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    [self actionExpandInfo:self.btnExpandInfo];
}


//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    //khoi tao du lieu!
    listArr  = [NSArray arrayWithObjects:SELECT_TEXT_ADD_CONTACT,SELECT_TEXT_ADD_NOTE, SELECT_TEXT_ADD_CALENDAR, SELECT_TEXT_ADD_TASK, SELECT_TEXT_ADD_OPPORTUNITY, nil];
    
    dtoLeadProcess = [DTOACCOUNTLEADProcess new];
    dtoContactProcess = [DTOCONTACTProcess new];
    
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
        case typeLeaderView_Calendar:
        {
            
        }
            break;
        case typeLeaderView_Contact:
        {
            arrayData = [dtoContactProcess filterWithClientLeaderId:[dicData objectForKey:DTOLEAD_clientLeadId]];
            NSLog(@"get detail data = %d", arrayData.count);
        }break;
        case typeLeaderView_Note:
        {
            
        }break;
        case typeLeaderView_Opportunity:{
            
        }break;
        case typeLeaderView_Task:{
            
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
            
        }
            break;
            
        case SELECT_INDEX_ADD_OPPORTUNITY:
        {
            
        }
            break;
            
        case SELECT_INDEX_ADD_TASK:
        {
            
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
        case typeLeaderView_Calendar:{
            return 50.0f;
        }break;
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (typeActionEvent) {
        case typeLeaderView_Calendar:
        {
            //            static NSString *cellId = @"proposeProductCell";
            //            ProposeProductCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            //
            //
            //            if (!cell) {
            //                cell = [ProposeProductCell getNewCell];
            //            }
            //
            //            if (arrayData.count>0) {
            //                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            //            }
            //
            //            return cell;
        }
            break;
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
            //            static NSString *cellId = @"competionorCell";
            //            CompetionorCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
            //
            //
            //            if (!cell) {
            //                cell = [CompetionorCell getNewCell];
            //            }
            //
            //            if (arrayData.count>0) {
            //                [cell loadDataToCellWithData:[arrayData objectAtIndex:indexPath.row] withOption:smgSelect];
            //            }
            //            
            //            return cell;
        }
            break;
        case typeLeaderView_Opportunity:
        {
        }
            break;
            
        case typeLeaderView_Task:
            {
                
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
        case typeLeaderView_Task:
            break;
        case typeLeaderView_Opportunity:
            break;
        case typeLeaderView_Note:
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
        default:
            break;
    }
}


@end
