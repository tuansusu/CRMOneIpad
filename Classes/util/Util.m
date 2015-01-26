//
//  Util.m
//  Voffice2.1
//
//  Created by VTIT on 2/7/14.
//
//

#import "Util.h"
#import "MainViewController.h"

@implementation Util

+(BOOL) checkNullArray : (NSArray*) inputArray{
    
    if (inputArray != nil && ![inputArray isKindOfClass:[NSNull class]] && inputArray.count>0) {
        return NO;
    }
    return YES;
}

+(BOOL) checkNullString : (NSString*) inputString {
    if (inputString != nil && ![inputString isKindOfClass:[NSNull class]] && ![inputString isEqualToString:@""] ) {
        return  NO;
    }
    return YES;
}


+(void) backToHome : (UIViewController*) viewController {
//    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    MainViewController *view = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    //action.sender = view;
//    //view.userData = [defaults objectForKey:USER_LOGIN];
//    //view.versionTypeCheck = [defaults objectForKey:KEY_VERSION];
//    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [viewController presentViewController:view animated:YES completion:nil];
    
    [viewController.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

+(void) sendMail : (UIViewController*) viewController withEmail : (NSString*) strEmailTo {
    //kiem tra xem no da cau hinh mail hay chua?
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:@"Anh/chị chưa cấu hình mail, cấu hình mail trước khi thực hiện chức năng này" delegate:viewController cancelButtonTitle:KEY_NOTIFICATION_CANCEL otherButtonTitles: nil];
        if (IS_OS_8_OR_LATER) {
            [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                //[self alertView:alertView clickedButtonAtIndex:buttonIndex];
            }];
        }else{
            [alert show];
        }
        return;
    }
    
    //viec dau tien la lay file log
    
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate =(id<MFMailComposeViewControllerDelegate>) viewController;
    
    //NSArray *address = [NSArray arrayWithObjects:@"tuannv36@viettel.com.vn", nil];
    
    NSArray *toRecipients = [NSArray arrayWithObjects:strEmailTo,nil];
	NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil];
	NSArray *bccRecipients = [NSArray arrayWithObjects:@"",nil];
	
    
    
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];
	[picker setBccRecipients:bccRecipients];
	
    
//    NSData *myData = [NSData dataWithContentsOfFile:filePath];
//    
//    [picker addAttachmentData:myData mimeType:@"text/plain" fileName :fileName];
	
	// Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@""];
	[picker setMessageBody:emailBody isHTML:NO];
    
	picker.modalPresentationStyle = UIModalPresentationPageSheet;
    
	[viewController presentViewController:picker animated:YES completion:nil];
}

+(void) rerenderFrameWithImage : (UIImageView*)  inputImage withLabel : (UILabel*) inputLabel withOption : (int) smgSelect{
    
    
    if (inputLabel.text.length<=2) {
        inputLabel.frame = CGRectMake(inputLabel.frame.origin.x, inputLabel.frame.origin.y, inputLabel.frame.size.width, inputLabel.frame.size.height);
        
        inputImage.frame = CGRectMake(inputImage.frame.origin.x, inputImage.frame.origin.y, inputImage.frame.size.width , inputImage.frame.size.height);
        
        inputImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png",IMG_NOTIFICATION,smgSelect]];
        
    }else{
       
        if (inputImage.isAccessibilityElement==NO) {
            inputImage.isAccessibilityElement = YES;
            inputLabel.frame = CGRectMake(inputLabel.frame.origin.x - 20, inputLabel.frame.origin.y, inputLabel.frame.size.width + 20, inputLabel.frame.size.height);
            inputImage.frame = CGRectMake(inputImage.frame.origin.x - 20, inputImage.frame.origin.y, inputImage.frame.size.width + 20, inputImage.frame.size.height);
            inputImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png",IMG_NOTIFICATION_LONG,smgSelect]];
        }
        
        
        
    }
    
    switch (smgSelect) {
        case 1:
        {
            //inputLabel.textColor = TEXT_BUTTON_COLOR_BLACK_1;
        }
            break;
            
        default:
            break;
    }
    
}

+(NSString*) getImageFile : (NSString *) fileName{
    
    NSDictionary *dicFileAdd = [[NSDictionary alloc] initWithObjectsAndKeys:ICON_FILE_DOC, FILE_DOC, ICON_FILE_DOC, FILE_DOCX, ICON_FILE_PDF, FILE_PDF, ICON_FILE_PPT, FILE_PPT, ICON_FILE_PPT, FILE_PPTX, ICON_FILE_TXT, FILE_TXT,  ICON_FILE_XLS, FILE_XLS, ICON_FILE_XLS, FILE_XLSX, nil];
    
    
    NSString*  fileExtention = [fileName.pathExtension uppercaseString];
    
    if ([[dicFileAdd allKeys] containsObject:fileExtention]) {
        return [NSString stringWithFormat:@"%@1.png", [dicFileAdd objectForKey:fileExtention]] ;
    }
    
    dicFileAdd = nil;
    return [NSString stringWithFormat:@"%@1.png", ICON_FILE_PDF] ;
    
}


+(BOOL) checkFileExtension:(NSString *)fileName{
    NSArray *arrayFileTemp = [NSArray arrayWithObjects:FILE_DOC, FILE_DOCX, FILE_PDF, FILE_PPT, FILE_PPTX, FILE_TXT, FILE_XLS, FILE_XLSX, nil];
    if ([arrayFileTemp containsObject:[fileName.pathExtension uppercaseString]]) {
        return YES;
    }
    
    arrayFileTemp = nil;
    return NO;
}
//hàm kiểm tra dũ lieu nhap vao bat validate


#pragma mark check
-(BOOL) checkValidToSave:(UITextField*) inputText :(NSString*)inputMessage :(UIView *)showView {
    BOOL isValidate = YES;
    if ([StringUtil trimString: inputText.text].length==0) {
        [self showTooltip:inputText withText:inputMessage showview:showView];
        
        [inputText becomeFirstResponder];
        inputText.layer.cornerRadius=1.0f;
        inputText.layer.masksToBounds=YES;
        inputText.layer.borderColor=[[UIColor redColor]CGColor ];
        inputText.layer.borderWidth=1.0f;
        
        isValidate = NO;
        return isValidate;
    }
    return isValidate;
}

//hiển thị thông báo
#pragma mark tooltip

-(void) showTooltip : (UITextField*) inputTooltipView withText : (NSString*) inputMessage showview:(UIView*)viewMainBodyInfo{
    
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
    
    
    [popTipView presentPointingAtView:inputTooltipView inView:viewMainBodyInfo animated:YES];
    
    
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
//kiểm tra email có đúng định dạng hay không?
-(BOOL) validateEmail:(NSString *)email{
    
    NSString *emailRegex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailtext=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailtext evaluateWithObject:email];
}
//set border cho textview

#pragma mark-set border text
-(void)setBorder:(UITextField *)txtView{
    
    txtView .layer.cornerRadius=1.0f;
    txtView.layer.masksToBounds=YES;
    txtView.layer.borderColor=[[UIColor redColor]CGColor ];
    txtView.layer.borderWidth=1.0f;
    [txtView becomeFirstResponder];
}
@end
