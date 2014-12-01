//
//  NSRegularExpression+VofficeRegularExpression.h
//  Voffice2.1
//
//  Created by VTIT on 10/1/13.
//
//

#import <Foundation/Foundation.h>

@interface NSRegularExpression (VofficeRegularExpression)

+(NSString*) convertNormalStringRegexString : (NSString*) stringInput;

+(BOOL) checkSubString : (NSString*) subStringInput : (NSString*) stringInput;

@end
