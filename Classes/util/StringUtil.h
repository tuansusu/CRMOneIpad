//
//  StringUtil.h
//  VofficeIpad2.0
//
//  Created by VTIT on 7/18/13.
//
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+(BOOL) stringIsEmpty : (NSString*) inputString;
+(BOOL) stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace;
//Ham chuyen chuoi 15/12/2013 => 2013/12/15
+(NSString*) reverseDateString:(NSString *)inputStr;

+(NSString*) formatNumber: (NSNumber*) numb;
+(NSString*) formatNumberWithDecimal:(NSNumber *)numb;
+(NSString *) convertVietNameseToEnglish : (NSString *) currentStr;
+(NSString *) getAcronymWord: (NSString*) currentStr;
+(NSString*) reverseString : (NSString*) currentStr;
+ (NSString *) getCountFromData : (id) data;
+(BOOL)validateSpecialCharacter:(NSString*) inText;
+(BOOL)validateNumber:(NSString*) inText;
+(BOOL)validateCharacter:(NSString*) inText;
+(NSString*) trimString : (NSString*) currentStr;
+(NSInteger) getLengStringWithUTF8Unicode : (NSString*) inText;
+(NSMutableArray *) parseXML:(NSString *)stringXML withComponent:(NSString *) componentStr forkey:(NSString *) keyString;
@end

