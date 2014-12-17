//
//  EditNoteLeadViewController.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/11/14.
//
//

#import "EditNoteLeadViewController.h"
#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"

@interface EditNoteLeadViewController ()
{
    int smgSelect ; //option layout
    NSMutableArray *arrayData; //mang luu tru du lieu (file)
    NSDictionary *dicData; //luu tru du lieu sua
    
    DTONOTEProcess *dtoProcess;
    DTOATTACHMENTProcess *dtoFileProcess;
    
    //chon index form them moi
    NSInteger selectIndex;
    NSArray *listArr;
    NSInteger selectStatusIndex;
    
    int dataId; //xac dinh id de them moi hay sua
    NSUserDefaults *defaults ;
    
    //thong tin chon NGAY - THANG
    int SELECTED_DATE_TAG ;
    NSDate *dateCreate, *dateBirthday;
    NSDateFormatter *df;
    
    NSInteger selectPersonJobIndex;
    NSArray *listArrPersonJob;
    //thong tin chon cho loai hinh CHUC DANH
    NSInteger selectPersonPositionIndex;
    NSArray *listArrPersonPosition;
    
    NSString *strClientContactId;
    
    BOOL succsess;//Trang thai acap nhat
}

@end

@implementation EditNoteLeadViewController

@synthesize txtTitle;
@synthesize txtContent;
@synthesize choosePhotoBtn, takePhotoBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) homeBack:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//khoi tao gia tri mac dinh cua form
-(void) initData {
    
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:FORMAT_DATE];
    
    succsess = NO;
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    dtoProcess = [DTONOTEProcess new];
    arrayData  = [NSMutableArray new];
    //arrayData = [dtoLeadProcess filter];
    NSLog(@"dataRoot %@",self.dataRoot);
    dataId = 0;
    if (self.dataSend) {
        
        NSLog(@"data gui tu form chi tiet %@", self.dataSend);
        
        self.lbTieudeghichu.text=@"CẬP NHẬP GHI CHÚ";
        
        [self loadDataEdit];
    }
    else{
        self.lbTieudeghichu.text=@"THÊM MƠI GHI CHÚ";
    }
    
}
//load du lieu khi sua
-(void) loadDataEdit{
    
    
    
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTONOTE_title]]) {
        txtTitle.text =[_dataSend objectForKey:DTONOTE_title];
    }
    if (![StringUtil stringIsEmpty:[_dataSend objectForKey:DTONOTE_content]]) {
        txtContent.text =[_dataSend objectForKey:DTONOTE_content];
    }
    
    //  arrayData =[dtoFileProcess filter];
    //NSLog(@"count:%i", arrayData.count);
    arrayData= [[NSMutableArray alloc] initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine",@"Ten",nil];
    
    //  arrayData = [dtoProcess filterWithKey:DTONOTE_id withValue:[_dataSend objectForKey:DTONOTE_id]];
    
    
}
- (void) updateInterFaceWithOption : (int) option
{
    self.fullNameLB.text = TITLE_APPLICATION;
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    //    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    //    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    [self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    [self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    for (UIView *viewSubTemp in self.headerMainView.subviews) {
        
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
    }
    
    
    
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            
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
                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            }
            
            if ([viewSubTemp isKindOfClass:[UIButton class]]) {
                
                [((UIButton*) viewSubTemp) setStyleNormalWithOption:smgSelect];
            }
            
        }
        
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            
            [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
        }
        
    }
    
    
    for (UIView *viewTemp in self.viewMainBarButton.subviews) {
        if ([viewTemp isKindOfClass:[UIButton class]]) {
            
            [((UIButton*) viewTemp) setStyleNormalWithOption:smgSelect];
        }
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)actionCancel:(id)sender {
}
- (IBAction)actionSave:(id)sender {
    
    if (![self checkValidToSave]) {
        return;
    }
    
    NSString *title=txtTitle.text;
    strClientContactId = IntToStr(([dtoProcess getClientId]));
    
    if(title==NULL || [title isEqualToString:@""]){
        
        NSLog(@"Rong");
        
        [[[UIAlertView alloc]initWithTitle:nil message:@"Ban chua nhap tieu de" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil]show];
        return;
        
    }
    
    
    NSLog(@"%@",txtTitle.text);
    NSLog(@"%@",txtContent.text);
    
    //check valid to save
    
    //neu qua duoc check thi tien hanh luu du lieu
    NSMutableDictionary *dicEntity = [NSMutableDictionary new];
    
    [dicEntity setObject:[StringUtil trimString:txtTitle.text] forKey:DTONOTE_title];
    [dicEntity setObject:[StringUtil trimString:txtContent.text] forKey:DTONOTE_content];
    
    [dicEntity setObject:@"1" forKey:DTONOTE_isActive];
    [dicEntity setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTONOTE_updatedDate];
    
    
    
    
    
    
    if (self.dataSend) {
        //truong hop sua
        [dicEntity setObject:[_dataSend objectForKey:DTONOTE_id] forKey:DTONOTE_id];
    }else{
        //truong hop them moi
        [dicEntity setObject:[self.dataRoot objectForKey:DTOLEAD_clientLeadId] forKey:DTONOTE_clientObjectId];
        [dicEntity setObject:@"Lead" forKey:DTONOTE_objectType];
        [dicEntity setObject:strClientContactId forKey:DTONOTE_clientNoteId];
        NSLog(@"clientObjectId= %@", [dicEntity objectForKey:DTONOTE_clientObjectId]);
        NSLog(@"clientLeadId= %@", [self.dataRoot objectForKey:DTOLEAD_clientLeadId]);
        
    }
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    if (self.dataSend) {
        //truong hop sua fiel
    }
    else{
        
        //truong hop them moi file
        if(arrayData.count>0 && succsess){
            
            NSMutableDictionary *entiFile= [NSMutableDictionary new];
            
            NSString *strClientFileId = IntToStr(([dtoProcess getClientId]));
            
            for (NSString *path in arrayData) {
                NSLog(@"%@", path);
                [entiFile setObject:@"" forKey:DTOATTACHMENT_attachmentId];
                [entiFile setObject:strClientFileId forKey:DTOATTACHMENT_clientAttachmentId];
                [entiFile setObject:strClientContactId forKey:DTOATTACHMENT_clientObjectId];
                [entiFile setObject:path forKey:DTOATTACHMENT_fileName];
                [entiFile setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOATTACHMENT_updatedDate];
                [entiFile setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOATTACHMENT_createdDate];
                [entiFile setObject:@"Note" forKey:DTOATTACHMENT_objectType];
                @try {
                    [dtoFileProcess insertToDBWithEntity:entiFile];
                }
                @catch (NSException *exception) {
                    NSLog(@"%@", exception);            }
                @finally {
                    NSLog(@"OK");            }
                
            }
        }
        
    }
    
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

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        NSLog(@"Ban khong tiep tuc");
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else if(buttonIndex==1){
        NSLog(@"Ban co tiep tuc");
        [arrayData removeAllObjects];
        [self.tbData reloadData];
        txtContent.text=@"";
        txtTitle.text=@"";
        
    }
    
}


#pragma mark text delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    ////NSLog(@"edit ting : %@", self.t\\\);
    txtContent.text=txtTitle.text;
    return  YES;
}// return NO to not change text


#pragma mark action photo

-(IBAction) getPhoto:(id) sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if((UIButton *) sender == choosePhotoBtn) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    //imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //luu file
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"yyyyMMdd_HHmmss"];
    NSDate *now = [NSDate date];
    NSString *nowStr = [df stringFromDate:now];
    
    
    NSString *strFileName = [NSString stringWithFormat:@"%@_%@.jpg", @"Note", nowStr];
    NSData* imageData = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"], 1.0);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    NSLog(@"image paht = %@", dbPath);
    
    [imageData writeToFile:dbPath atomically:YES];
    
    
    //luu file thanh cong
    [arrayData addObject:strFileName];
    [self.tbData reloadData];
    
}



#pragma mark - Table View


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return  arrayData.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newFriendCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //etc.
    cell.textLabel.text = [arrayData objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
    
    NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
    
}

#pragma mark check
-(BOOL) checkValidToSave {
    BOOL isValidate = YES;
    if ([StringUtil trimString: txtTitle.text].length==0) {
        [self showTooltip:self.txtTitle withText:@"Bạn chưa nhập Tên khách hàng"];
        
        [txtTitle becomeFirstResponder];
        txtTitle.layer.cornerRadius=1.0f;
        txtTitle.layer.masksToBounds=YES;
        txtTitle.layer.borderColor=[[UIColor redColor]CGColor ];
        txtTitle.layer.borderWidth=1.0f;
        
        isValidate = NO;
        return isValidate;
    }
    return isValidate;
}


#pragma mark tooltip

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
    
    /* Some options to try.
     */
    //popTipView.disableTapToDismiss = YES;
    //popTipView.preferredPointDirection = PointDirectionUp;
    //popTipView.hasGradientBackground = NO;
    //popTipView.cornerRadius = 2.0;
    //popTipView.sidePadding = 30.0f;
    //popTipView.topMargin = 20.0f;
    //popTipView.pointerSize = 50.0f;
    //popTipView.hasShadow = NO;
    
    
    //txtTitle.layer.cornerRadius=1.0f;
    //txtTitle.layer.masksToBounds=YES;
    //txtTitle.layer.borderColor=[[UIColor redColor]CGColor ];
    //txtTitle.layer.borderWidth=1.0f;
    
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
    
    
    [popTipView presentPointingAtView:inputTooltipView inView:self.viewMainBodyInfo animated:YES];
    
    
    [self.visiblePopTipViews addObject:popTipView];
    self.currentPopTipViewTarget = inputTooltipView;
    
    
    
}

- (void)dismissAllPopTipViews
{
    while ([self.visiblePopTipViews count] > 0) {
        CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObjectAtIndex:0];
    }
}
#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [self.visiblePopTipViews removeObject:popTipView];
    self.currentPopTipViewTarget = nil;
}


-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sua item at index = %d", indexPath.row);
    
    
}


@end
