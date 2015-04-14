//
//  Util.h
//  Voffice2.1
//
//  Created by VTIT on 2/7/14.
//
//

#import <Foundation/Foundation.h>
#import "CMPopTipView.h"

@interface Util : NSObject<CMPopTipViewDelegate>
+(void) rerenderFrameWithImage : (UIImageView*)  inputImage withLabel : (UILabel*) inputLabel withOption : (int) smgSelect;
+(void) backToHome : (UIViewController*) viewController ;

+(BOOL) checkNullArray : (NSArray*) inputArray;

+(BOOL) checkNullString : (NSString*) inputString ;

+(NSString*) getImageFile : (NSString *) fileName;

+(BOOL) checkFileExtension : (NSString *) fileName;
-(BOOL) checkValidToSave:(UITextField*) inputText :(NSString*)inputMessage :(UIView *)showView ;
-(void) showTooltip : (UITextField*) inputTooltipView withText : (NSString*) inputMessage showview:(UIView*)viewMainBodyInfo;
-(BOOL) validateEmail:(NSString *)email;
-(void)setBorder:(UITextField *)txtView;
/*
 *Ham send mail den dia chi cu the
 */
+(void) sendMail : (UIViewController*) viewController withEmail : (NSString*) strEmailTo ;

//ham ko cho nhap ky tu dac biet
-(BOOL) CharacterNoEnter: (NSString *) strValue;

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;
@end
