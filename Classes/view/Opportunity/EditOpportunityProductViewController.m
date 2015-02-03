//
//  EditOpportunityProductViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/25/14.
//
//

#import "EditOpportunityProductViewController.h"
#import "DTOOPPORTUNITYPRODUCTProcess.h"
#import "DTOPRODUCTMASTERProcess.h"
#import "DTOSYSCATProcess.h"
#import "Util.h"

@interface EditOpportunityProductViewController ()
{
    int smgSelect ; //option layout
    NSArray *arrayData; //mang luu tru du lieu
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTOOPPORTUNITYPRODUCTProcess *dtoOpportunityProductProcess;
    DTOPRODUCTMASTERProcess *dtoProductMasterProcess;
    DTOSYSCATProcess *dtoSysCatProcess;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    //Danh sach san pham
    NSArray *listProduct;
    //Phan hien thi danh sach  san pham da loc dung theo tieu tri
    NSMutableArray *listProductFilter;
    
    //Product da duoc chon
    NSDictionary *selectedProduct;

    //thong tin chon cho loai tien te
    NSInteger selectCurrencyIndex;
    NSArray *listArrCurrency;
    
    BOOL succsess;//Trang thai acap nhat
    
    //key board
    float heightKeyboard;
    UITextField *_txt;
    
    MDSearchBarController *searchBarController;
}
@end

@implementation EditOpportunityProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    
    searchBarController = [MDSearchBarController new];
    searchBarController.searchBarView.frame = self.txtSearchCustomer.frame;
    [self.txtSearchCustomer.superview addSubview:searchBarController.searchBarView];
    [self.txtSearchCustomer removeFromSuperview];
    searchBarController.delegate= self;
    
    self.txtSearchCustomer = searchBarController.searchBarView;
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    
    searchBarController.isValid = NO;
    
    self.txtQuantity.delegate = self;
    self.txtRevenue.delegate = self;
}
-(void)dismissPopUp
{
    //your dimiss code here
    if(!searchBarController.isValid){
       // self.txtCustomer.text = @"";
    }
    searchBarController.active = NO;
}
//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    selectCurrencyIndex = -1;
    succsess = NO;
    
    dtoOpportunityProductProcess = [DTOOPPORTUNITYPRODUCTProcess new];
    dtoProductMasterProcess = [DTOPRODUCTMASTERProcess new];
    dtoSysCatProcess = [DTOSYSCATProcess new];
    
    listProduct = [dtoProductMasterProcess filter];
    listProductFilter = (NSMutableArray*)listProduct;
    
    listArrCurrency = [dtoSysCatProcess filterWithCatType:FIX_SYS_CAT_TYPE_CURRENCY];
    
    dataId = 0;
    if (self.dataSend) {
        [self loadEditData];
    }else{
        
    }
    
}

//Load thong tin len form sua
-(void) loadEditData {
    
    if (self.dataSend) {
        
        self.lblFormTitle.text = @"CHỈNH SỬA SẢN PHẨM ĐỀ XUẤT";
    }
    
    //product
    NSString *productMasterId = [_dataSend objectForKey:DTOOPPORTUNITYPRODUCT_productMasterId];

        NSArray *arrayProductMasterID = [listProduct valueForKey:DTOOPPORTUNITYPRODUCT_productMasterId];
        NSInteger selectProductIndex = [arrayProductMasterID indexOfObject:productMasterId];
        if (selectProductIndex>=0) {
            selectedProduct = [listProduct objectAtIndex:selectProductIndex];
            self.txtSearchCustomer.textField.text = [selectedProduct objectForKey:DTOPRODUCTMASTER_name];
            searchBarController.isValid = YES;
        }
  
    //quantity
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITYPRODUCT_quantity]]) {
        self.txtQuantity.text =[_dataSend objectForKey:DTOOPPORTUNITYPRODUCT_quantity];
    }
    //revenue
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTOOPPORTUNITYPRODUCT_revenue]]) {
        self.txtRevenue.text =[_dataSend objectForKey:DTOOPPORTUNITYPRODUCT_revenue];
    }
    
    //Currency
    NSString *currencyId = [_dataSend objectForKey:DTOOPPORTUNITYPRODUCT_currencyId];
    if (![StringUtil stringIsEmpty:currencyId]) {
        NSArray *arrayCurrencyID = [listArrCurrency valueForKey:DTOSYSCAT_sysCatId];
        selectCurrencyIndex = [arrayCurrencyID indexOfObject:currencyId];
        if (selectCurrencyIndex>=0) {
            NSDictionary *dataCurrency = [listArrCurrency objectAtIndex:selectCurrencyIndex];
            self.txtCurrency.text = [dataCurrency objectForKey:DTOSYSCAT_name];
        }
    }
}

- (void) updateInterFaceWithOption : (int) option
{
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    self.lblFormTitle.text =  TITLE_APPLICATION;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    
    
    //[self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    
    [self.viewheader setBackgroundColor:HEADER_VIEW_COLOR1];
    
    [self.viewheader setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    
    [self.bodyMainView setBackgroundColor:BACKGROUND_NORMAL_COLOR1];
    
    [self.bodyMainView setBorderWithOption:smgSelect];
    
    self.viewinfo.backgroundColor = HEADER_SUB_VIEW_COLOR1;
    
    self.viewinfo.layer.borderWidth = BORDER_WITH;
    self.viewinfo.layer.borderColor = [BORDER_COLOR CGColor];
    
    
    [self.btnSave setStyleNormalWithOption:smgSelect];
    
    for (UIView *viewTemp in self.viewmaininfo.subviews) {
        
        for (UIView *viewSubTemp in [viewTemp subviews]) {
            
            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
            }
            
            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                
                [((UITextField*) viewSubTemp) setPaddingLeft];
                [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
                
            }
            
        }
        
//        if ([viewTemp isKindOfClass:[UIButton class]]) {
//            if(viewTemp.tag!=10){
//                [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
//            }
//        }
        
    }
    
    
    ///////
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark action button
- (IBAction)actionHome:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}

-(IBAction)actionSave:(id)sender{
    //check valid to save
    if (![self checkValidToSave]) {
        return;
    }
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    //clientOpportunityProductId
    NSString *clientOpportunityProductId = IntToStr([dtoOpportunityProductProcess getClientId]);
    [dicEntity setObject:clientOpportunityProductId forKey:DTOOPPORTUNITYPRODUCT_clientOpportunityProductId];
    //currencyId
    if(selectCurrencyIndex >= 0){
        [dicEntity setObject:[[listArrCurrency objectAtIndex:selectCurrencyIndex] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOOPPORTUNITYPRODUCT_currencyId];
    }
    else{//Lấy mặc định là đồng việt nam
        
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"code = 'VND'"];
    
        [dicEntity setObject:[[[listArrCurrency filteredArrayUsingPredicate:bPredicate] objectAtIndex:0] objectForKey:DTOSYSCAT_sysCatId] forKey:DTOOPPORTUNITYPRODUCT_currencyId];
    }
    //isActive
    [dicEntity setObject:@"1" forKey:DTOCONTACT_isActive];
    //clientOpportunityId
    if(!self.dataSend){
        [dicEntity setObject:[_dataRoot objectForKey:DTOOPPORTUNITY_clientOpportunityId] forKey:DTOOPPORTUNITY_clientOpportunityId];
    }else{
        [dicEntity setObject:[self.dataSend objectForKey:DTOOPPORTUNITY_clientOpportunityId] forKey:DTOOPPORTUNITY_clientOpportunityId];
    }
    //productMasterId
    [dicEntity setObject:[selectedProduct objectForKey:DTOPRODUCTMASTER_productMasterId] forKey:DTOOPPORTUNITYPRODUCT_productMasterId];
    //quantity
    [dicEntity setObject:[StringUtil trimString:self.txtQuantity.text] forKey:DTOOPPORTUNITYPRODUCT_quantity];
    //revenue
    [dicEntity setObject:[StringUtil trimString:self.txtRevenue.text] forKey:DTOOPPORTUNITYPRODUCT_revenue];
    
    
    if (self.dataSend) {
        
        [dicEntity setObject:[_dataSend objectForKey:DTOCONTACT_id] forKey:DTOCONTACT_id];
    }
    succsess = [dtoOpportunityProductProcess insertToDBWithEntity:dicEntity];
    
    
    if (succsess) {
        //Thong bao cap nhat thanh cong va thoat
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Cập nhật thành công, tiếp tục nhập?" delegate:self cancelButtonTitle:@"Không" otherButtonTitles:@"Có", nil];
        alert.tag = 5;
        [alert show];
        
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Sảy ra lỗi, vui lòng thử lại hoặc gửi log đến quản trị" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
    
}

- (IBAction)actionCancel:(id)sender {
    NSLog(@"dismiss");
    [self.delegateOpportunityProduct dismissPopoverView];
}
-(IBAction)actionChooseCurency:(id)sender{
    
    [self hiddenKeyBoard];
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectCurrencyIndex;
    
    detail.listData = [listArrCurrency valueForKey:DTOSYSCAT_name];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnCurrency.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320,250) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.bodyMainView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    selectCurrencyIndex = index;
    if (index<listArrCurrency.count) {
        NSDictionary *dic = [listArrCurrency objectAtIndex:index];
        self.txtCurrency.text = [dic objectForKey:DTOSYSCAT_name];
    }

//    switch (SELECTED_TAG) {
//        case FOLLOW_UP_LEAD_ITEM:
//        {
//            selectMucDich = index;
//            if (index<listArrPersonPosition.count) {
//                NSDictionary *dic = [listArrPersonPosition objectAtIndex:index];
//                catId=[dic objectForKey:DTOSYSCAT_sysCatId];
//                _txtMucDich.text = [dic objectForKey:DTOSYSCAT_name];
//                
//            }
//        }
//            
//        default:
//            break;
//    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0 && alertView.tag ==1) {
        
        
    }
    if (succsess && alertView.tag == 5 && buttonIndex == 0) { //thong bao dong form
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark UITextField


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark UITextField


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return  YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //ket thuc khong edit text do
    if (textField==_txt) {
        _txt = nil;
    }
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return  YES;
}// called when 'return' key pressed. return NO to ignore.

//end keyboard




#pragma mark check
-(BOOL) checkValidToSave {
    BOOL isValidate = YES;
    
    //clear all boder red
    //for (UIView *viewTemp in self.viewmaininfo.subviews) {
        
        for (UIView *viewSubTemp in self.viewmaininfo.subviews) {
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
            }
        }
   // }
    
    if (!searchBarController.isValid) {
        [self showTooltip:self.txtSearchCustomer.textField withText:@"Bạn chưa nhập sản phẩm"];
        
        [self.txtSearchCustomer.textField  becomeFirstResponder];
        [self setBorder:self.txtSearchCustomer.textField];
        isValidate = NO;
        return isValidate;
    }
    if([StringUtil trimString:self.txtQuantity.text].length==0){
        
        [self showTooltip:self.txtQuantity  withText:@"Bạn chưa nhập số lượng"];
        [self.txtQuantity becomeFirstResponder];
        [self setBorder:self.txtQuantity];
        isValidate=NO;
        return isValidate;
    }
    if([StringUtil trimString:self.txtRevenue.text].length==0){
        
        [self showTooltip:self.txtRevenue  withText:@"Bạn chưa nhập doanh thu"];
        [self.txtRevenue becomeFirstResponder];
        [self setBorder:self.txtRevenue];
        isValidate=NO;
        return isValidate;
    }
//    //    if([StringUtil trimString:self.txtEmail.text].length==0){
//    //
//    //        [self showTooltip:self.txtEmail withText:@"Bạn chưa nhập Email"];
//    //        [self.txtEmail becomeFirstResponder];
//    //
//    //        [self setBorder:self.txtEmail];
//    //
//    //        isValidate=NO;
//    //        return isValidate;
//    //    }
//    //
//    if([self validateEmail:self.txtEmail.text]==NO)
//    {
//        [self showTooltip:self.txtEmail withText:@"Email không đúng"];
//        [self.txtEmail becomeFirstResponder];
//        [self setBorder:self.txtEmail];
//        isValidate=NO;
//        return isValidate;
//    }
    
    return isValidate;
}

-(BOOL)textField: (UITextField *) theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // allow backspace
    if (!string.length)
    {
        return YES;
    }
    if(theTextField == self.txtQuantity ||  theTextField == self.txtRevenue){
    //for Decimal value start//////This code use use for allowing single decimal value
        if ([theTextField.text rangeOfString:@"."].location == NSNotFound)
        {
            if ([string isEqualToString:@"."]) {
                return YES;
            }
        }
        else
        {
            if ([[theTextField.text substringFromIndex:[theTextField.text rangeOfString:@"."].location] length]>2)   // this allow 2 digit after decimal
            {
                return NO;
            }
        }
        //for Decimal value End//////This code use use for allowing single decimal value
        
        // allow digit 0 to 9
        if ([string intValue])
        {
            return YES;
        }
        
        return NO;
    }else{
        return YES;
    }
    
    
    

}



#pragma mark -check email
-(BOOL) validateEmail:(NSString *)email{
    
    NSString *emailRegex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailtext=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailtext evaluateWithObject:email];
}
#pragma mark-set border text
-(void)setBorder:(UITextField *)txtView{
    
    txtView .layer.cornerRadius=1.0f;
    txtView.layer.masksToBounds=YES;
    txtView.layer.borderColor=[[UIColor redColor]CGColor ];
    txtView.layer.borderWidth=1.0f;
    [txtView becomeFirstResponder];
}
#pragma mark-phan tim kiem san pham

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listProductFilter.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [[listProductFilter objectAtIndex:indexPath.row] objectForKey:@"name"]; //[NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

-(void)searchBar:(MDSearchBarController *)searchBarController searchWithText:(NSString *)text{
    NSPredicate *keyPred = [NSPredicate predicateWithFormat: [NSString stringWithFormat:@"name contains[c] '%@'",text]];
    listProductFilter = [listProduct filteredArrayUsingPredicate: keyPred];
    [searchBarController reloadData];
    searchBarController.isValid = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedProduct = [listProductFilter objectAtIndex:indexPath.row];
    self.txtSearchCustomer.textField.text = [selectedProduct objectForKey:@"name"];
    searchBarController.active = NO;
    searchBarController.isValid = YES;
}
#pragma mark-toolip
- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}
-(void) showTooltip : (UIView*) inputTooltipView withText : (NSString*) inputMessage {
    
    [self dismissAllPopTipViews];
    
    
    NSString *contentMessage = inputMessage;
    //UIView *contentView = inputTooltipView;
    
    UIColor *backgroundColor = [UIColor redColor];
    
    UIColor *textColor = [UIColor whiteColor];
    
    //NSString *title = inputMessage;
    
    CMPopTipView *popTipView;
    
    
    popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
    
    popTipView.delegate = self;
    
    
    
    popTipView.preferredPointDirection = PointDirectionDown;
    popTipView.hasShadow = NO;
    
    if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
        popTipView.backgroundColor = backgroundColor;
    }
    if (textColor && ![textColor isEqual:[NSNull null]]) {
        popTipView.textColor = textColor;
    }
    
    popTipView.animation = arc4random() % 2;
    popTipView.has3DStyle = (BOOL)(arc4random() % 2);
    
    popTipView.dismissTapAnywhere = YES;
    [popTipView autoDismissAnimated:YES atTimeInterval:3.0];
    
    
    [popTipView presentPointingAtView:inputTooltipView inView:self.viewmaininfo animated:YES];
    
    
    [self.visiblePopTipViews addObject:popTipView];
    self.currentPopTipViewTarget = inputTooltipView;
    
    
    
}


-(void) hiddenKeyBoard {
    for (UIView *viewTemp in _bodyMainView.subviews) {
        
            
            if([viewTemp isKindOfClass:[UITextField class]]){
                [(UITextField *)viewTemp resignFirstResponder];
            }
            
            
        
    }
}

@end
