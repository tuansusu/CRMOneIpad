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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    MainViewController *view = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    //action.sender = view;
    //view.userData = [defaults objectForKey:USER_LOGIN];
    //view.versionTypeCheck = [defaults objectForKey:KEY_VERSION];
    view.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [viewController presentViewController:view animated:YES completion:nil];
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


@end
