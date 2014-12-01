//
//  Util.h
//  Voffice2.1
//
//  Created by VTIT on 2/7/14.
//
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+(void) rerenderFrameWithImage : (UIImageView*)  inputImage withLabel : (UILabel*) inputLabel withOption : (int) smgSelect;
+(void) backToHome : (UIViewController*) viewController ;

+(BOOL) checkNullArray : (NSArray*) inputArray;

+(BOOL) checkNullString : (NSString*) inputString ;

+(NSString*) getImageFile : (NSString *) fileName;

+(BOOL) checkFileExtension : (NSString *) fileName;


@end
