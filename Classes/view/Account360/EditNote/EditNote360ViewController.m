//
//  EditNote360ViewController.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import "EditNote360ViewController.h"

#import "DTONOTEProcess.h"
#import "DTOATTACHMENTProcess.h"
#import "EditNoteViewCell.h"
#import "Util.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "FileManagerUtil.h"
#import "EnumClass.h"

@interface EditNote360ViewController ()
{
    int smgSelect ; //option layout
    NSMutableArray *arrayData; //mang luu tru du lieu (file)
    NSDictionary *dicData; //luu tru du lieu sua
    NSMutableArray *arrayDelFile;//mang luu tru file del
    NSDictionary *fileItemDel;
    
    DTONOTEProcess *dtoProcess;
    DTOATTACHMENTProcess *dtoFileProcess;
    Util*util;
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
    NSString *deleteFile;
    NSString *index;
    
    BOOL succsess;//Trang thai acap nhat
    Language *obj;
}

@end

@implementation EditNote360ViewController

@synthesize txtTitle;
@synthesize txtContent;
@synthesize choosePhotoBtn, takePhotoBtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    arrayDelFile=[NSMutableArray new];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    util=[Util new];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    [self initData];
    
    obj=[Language getInstance];
    obj.str=[defaults objectForKey:@"Language"];
    LocalizationSetLanguage(obj.str);
    [self setLanguage];
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if ([self currentDeviceType]==iPhone) {
        self.txtContent.layer.borderColor = [[UIColor colorWithRed:215.0 / 255.0 green:215.0 / 255.0 blue:215.0 / 255.0 alpha:1] CGColor];
        self.txtContent.layer.borderWidth = 0.6f;
        self.txtContent.layer.cornerRadius = 1.0f;
        //text
        [self setBorderTextfield:self.txtTitle];
        
    }
    
}
-(void)setBorderTextfield:(UITextField *)txtField{
    
    txtField.textColor = TEXT_COLOR_REPORT;
    txtField.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    [txtField setBorderWithOption:smgSelect];
    [txtField setPaddingLeft];
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
    dtoFileProcess=[DTOATTACHMENTProcess new];
    arrayData  = [NSMutableArray new];
    //arrayData = [dtoLeadProcess filter];
    arrayData  = [NSMutableArray new];
    self.txtContent.text = @"Nội dung";
    self.txtContent.textColor = [UIColor lightGrayColor];
    self.txtContent.tag = 0;
    NSLog(@"dataRoot %@",self.dataRoot);
    dataId = 0;
    if (self.dataSend) {
        _btnDel.hidden=NO;
        arrayData =[dtoFileProcess filterWithKey:DTOATTACHMENT_clientObjectId withValue:[_dataSend objectForKey:DTONOTE_clientNoteId]];
        NSLog(@"data gui tu form chi tiet %@", self.dataSend);
        
        self.fullNameLB.text=@"CẬP NHẬP GHI CHÚ";
        
        [self loadDataEdit];
        [self.tbData reloadData];
        NSLog(@"data File %@",arrayData);
    }
    else{
        self.fullNameLB.text=@"THÊM MƠI GHI CHÚ";
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
}
- (void) updateInterFaceWithOption : (int) option
{
    if (_dataSend) {
        self.fullNameLB.text = TITLE_EDIT_NOTES;
    }else{
        self.fullNameLB.text = TITLE_ADD_NOTES;
    }
    
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    //    [self.leftViewHeader setBackgroundColor:BACKGROUND_COLOR_TOP_LEFT_HEADER];
    //    self.leftLabelHeader.textColor = TEXT_COLOR_HEADER_APP;
    //    [self.headerMainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    //    [self.headerMainView setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:AUISelectiveBordersFlagBottom];
    //    for (UIView *viewSubTemp in self.headerMainView.subviews) {
    //
    //
    //        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
    //            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
    //        }
    //    }
    
    
    //[self.btnSave setStyleNormalWithOption:smgSelect];
    
    [self.mainView setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
    
    self.bodyMainView.backgroundColor = BACKGROUND_NORMAL_COLOR1;
    
    self.bodyMainView.layer.borderWidth = BORDER_WITH;
    self.bodyMainView.layer.borderColor = [BORDER_COLOR CGColor];
    
    for (UIView *viewTemp in self.bodyMainView.subviews) {
        
        for (UIView *viewSubTemp in viewTemp.subviews) {
            
            
            if ([viewSubTemp isKindOfClass:[UIImageView class]]) {
                [((UIImageView*) viewSubTemp) setAlpha:1.0f];
                continue;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UILabel class]]) {
                ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
                continue;
            }
            
            
            if ([viewSubTemp isKindOfClass:[UITextView class]]) {
                ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                continue;
            }
            if ([viewSubTemp isKindOfClass:[UITextField class]]) {
                ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
                ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
                //                ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
                //                ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
                [((UITextField*) viewSubTemp) setBorderWithOption:option];
                [((UITextField*) viewSubTemp) setPaddingLeft];
                continue;
            }
            
            if ([viewSubTemp isKindOfClass:[UIButton class]]) {
                
                [((UIButton*) viewSubTemp) setStyleNormalWithOption:smgSelect];
                continue;
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

- (IBAction)actionCancel:(id)sender {
}
- (IBAction)actionSave:(id)sender {
    
    if (![util checkValidToSave:self.txtTitle:MSG_INPUT_TITLE_NOTES :self.bodyMainView]) {
        return;
    }
    
    
    strClientContactId = IntToStr(([dtoProcess getClientId]));
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
        [dicEntity setObject:[self.dataRoot objectForKey:DTOACCOUNT_clientAccountId] forKey:DTONOTE_clientObjectId];
        [dicEntity setObject:@"360" forKey:DTONOTE_objectType];
        [dicEntity setObject:strClientContactId forKey:DTONOTE_clientNoteId];
        
    }
    succsess = [dtoProcess insertToDBWithEntity:dicEntity];
    
    BOOL dt ;
    //truong hop them moi file
    if(arrayData.count>0 && succsess){
        
        NSMutableDictionary *entiFile= [NSMutableDictionary new];
        
        NSString *strClientFileId = IntToStr(([dtoProcess getClientId]));
        //them moi file
        for (NSDictionary *path in arrayData) {
            //  NSLog(@"%@", path);
            int itemid=[[path objectForKey:DTOATTACHMENT_id] intValue];
            if(itemid<0){
                [entiFile setObject:@"" forKey:DTOATTACHMENT_attachmentId];
                [entiFile setObject:strClientFileId forKey:DTOATTACHMENT_clientAttachmentId];
                if (self.dataSend.count>0) {
                    [entiFile setObject:[_dataSend objectForKey:DTONOTE_clientNoteId] forKey:DTOATTACHMENT_clientObjectId];
                }
                else{
                    [entiFile setObject:strClientContactId forKey:DTOATTACHMENT_clientObjectId];
                }
                [entiFile setObject:[path objectForKey:@"fileName"] forKey:DTOATTACHMENT_fileName];
                [entiFile setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOATTACHMENT_updatedDate];
                [entiFile setObject:[DateUtil formatDate:[NSDate new] :@"yyyy-MM-dd HH:mm:ss.S"] forKey:DTOATTACHMENT_createdDate];
                [entiFile setObject:@"Note" forKey:DTOATTACHMENT_objectType];
                [entiFile setObject:@"1" forKey:DTOATTACHMENT_isActive];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_updatedBy];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_checkSum];
                [entiFile setObject:[path objectForKey:@"clientFilePath"] forKey:DTOATTACHMENT_clientFilePath];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_createdBy];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_note];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_objectId];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_serverFilePath];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_verifyLat];
                [entiFile setObject:@"" forKey:DTOATTACHMENT_verifyLon];
                
                @try {
                    dt = [dtoFileProcess insertToDBWithEntity:entiFile];
                    if (!dt) {
                        NSLog(@"Loi roi");
                    }
                }
                @catch (NSException *exception) {
                    NSLog(@"log:%@", exception);            }
                @finally {
                    NSLog(@"OK");            }
                
            }
        }
    }
    //thêm đoạn mới này
    //xoa file
    if (succsess && arrayDelFile.count>0) {
        for (NSDictionary *item in arrayDelFile) {
            int itemId=[[item objectForKey:DTOATTACHMENT_id] intValue];
            if (itemId>0) {
                BOOL result=[dtoFileProcess deleteEntity:[NSString stringWithFormat:@"%d",itemId]];
                if (result) {
                    NSLog(@"Delete OK");
                }
            }
        }
    }
    
    if (succsess) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //khong bao nhap loi - lien he quan tri
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_ALERT_TITLE")  message:LocalizedString(@"KEY_ALERT_ERROR") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERT_EXIT") otherButtonTitles:nil];
        alert.tag = 6;
        [alert show];
    }
}
#pragma -mark xử lý thông báo
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag==22){
        NSMutableDictionary *dicEntity = [NSMutableDictionary new];
        
        [dicEntity setObject:@"0" forKey:DTONOTE_isActive];
        //truong hop sua
        [dicEntity setObject:[_dataSend objectForKey:DTONOTE_id] forKey:DTONOTE_id];
        
        succsess = [dtoProcess insertToDBWithEntity:dicEntity];
        if(succsess){
            
            NSMutableDictionary *entiFile= [NSMutableDictionary new];
            for (NSDictionary *path in arrayData) {
                //  NSLog(@"%@", path);
                
                [entiFile setObject:@"0" forKey:DTOATTACHMENT_isActive];
                [entiFile setObject:[path objectForKey:DTOATTACHMENT_id] forKey:DTOATTACHMENT_id];
                
                @try {
                    BOOL   dt = [dtoFileProcess insertToDBWithEntity:entiFile];
                    if (!dt) {
                        NSLog(@"Loi roi");
                    }
                }
                @catch (NSException *exception) {
                    NSLog(@"log:%@", exception);            }
                @finally {
                    NSLog(@"OK");            }
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        else{
            NSLog(@"Error");
        }
    }
    else{
        
        if (alertView.tag==TAG_DELETE_ITEM) {
            NSLog(@"Xoa file dinh kem");
            if(buttonIndex==0){
                [arrayData removeObject:fileItemDel];
                NSMutableDictionary *addItem=[NSMutableDictionary new];
                [addItem setValue:deleteFile forKey:DTOATTACHMENT_id];
                [arrayDelFile addObject:addItem];
                [_tbData reloadData];
            }
            else if(buttonIndex==1){
                NSLog(@"Khong  xoa file");
            }
        }else{
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
    }
    if (alertView.tag==6) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark text delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    if(textField==self.txtTitle){
        self.txtContent.text=textField.text;
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 200 || returnKey;
    }
    if(textField==self.txtTitle){
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= 2000 || returnKey;
    }
    return YES;
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
    
    NSMutableDictionary *dicFile = [[NSMutableDictionary alloc]init];
    int i = rand()%100+1;
    NSLog(@"Random Number: %i", -i);
    dicData=[NSMutableDictionary new];
    [dicData setValue:strFileName forKey:DTOATTACHMENT_fileName];
    [dicData setValue:dbPath forKey:DTOATTACHMENT_clientFilePath];
    [dicData setValue:[NSString stringWithFormat:@"%i",-i] forKey:DTOATTACHMENT_id];
    
    [arrayData addObject: dicData];
    [self.tbData reloadData];
    NSLog(@"data File %@",arrayData);
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
    
    return 50.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  arrayData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"EditNoteViewCell";
    EditNoteViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        [self.tbData registerNib:[UINib nibWithNibName:@"EditNoteViewCell" bundle:nil] forCellReuseIdentifier:@"EditNoteViewCell"];
        cell = [[EditNoteViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        //        cell.delegate = self;
    }
    
    NSDictionary *dicRow = [arrayData objectAtIndex:indexPath.row];
    
    [cell loadDataCellWithImageName:[dicRow objectForKey:DTOATTACHMENT_fileName]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:arrayData.count];
    for (int i = 0; i<arrayData.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        NSDictionary *dicRow = [arrayData objectAtIndex:i];
        UIImage *currentimage;
        NSString *fullPath = [FileManagerUtil getPathWithWithName:[dicRow objectForKey:DTOATTACHMENT_fileName]];
        if (fullPath) {
            currentimage =[UIImage imageWithContentsOfFile:fullPath];
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:fullPath];
            photo.url = fileURL;
            photo.srcImageView = [[UIImageView alloc] initWithImage:currentimage];
            [photos addObject:photo];
        }
    }
    if (photos.count>0) {
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = indexPath.row; // current image index
        browser.photos = photos; // set list photo
        [browser show];
    }
    
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
        
        fileItemDel =[NSDictionary new];
        fileItemDel=[arrayData objectAtIndex:indexPath.row];
        NSDictionary *dicData = [arrayData objectAtIndex:indexPath.row];
        deleteFile =[dicData objectForKey:DTOATTACHMENT_id];
        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"KEY_ALERT_TITLE") message:LocalizedString(@"KEY_ALERT_DEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles: LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
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
//-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{

/**
 *  Neu khong phai la Header thi la item level 2
 */
//  return SYS_KEY_EDIT;
//return nil;
//}

/**
 *  Xu ly khi chon button "Sua"
 */
-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sua item at index = %d", indexPath.row);
    
    NSDictionary *dicDataTemp = [arrayData objectAtIndex:indexPath.row];
    
    
}



#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}
//set language
-(void) setLanguage{
    // [_btnSave setTitle:LocalizedString(@"KEY_UPDATE") forState:UIControlStateNormal];
    [_lbContent setText:LocalizedString(@"KEY_NOTE_CONTENT")];
    [_lbTitle setText:LocalizedString(@"KEY_NOTE_TITLE")];
    // [_btnDel setTitle:LocalizedString(@"KEY_Delete") forState:UIControlStateNormal];
    [self.choosePhotoBtn setTitle:LocalizedString(@"KEY_CHOICE_IMAGE") forState:(UIControlStateNormal)];
    [self.takePhotoBtn setTitle:LocalizedString(@"KEY_CAMERA") forState:(UIControlStateNormal)];
    if (_dataSend.count>0) {
        [_fullNameLB setText:LocalizedString(@"KEY_NOTE_EDIT")];
    }
    else{
        [_fullNameLB setText:LocalizedString(@"KEY_NOTE_ADD")];
    }
    [_lbFileAttachment setText:LocalizedString(@"KEY_NOTE_FILE")];
};


- (IBAction)actionDel:(id)sender {
    UIAlertView *myAler=[[UIAlertView alloc]initWithTitle:LocalizedString(@"KEY_INFO_TITLE") message:LocalizedString(@"KEY_ALERT_DEL") delegate:self cancelButtonTitle:LocalizedString(@"KEY_ALERTVIEW_DELETE_OK") otherButtonTitles:LocalizedString(@"KEY_ALERTVIEW_DELETE_CANCEL"), nil];
    myAler.tag=22;
    [myAler show];
}
@end

