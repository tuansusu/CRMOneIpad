//
//  StringUtil.m
//  VofficeIpad2.0
//
//  Created by VTIT on 7/18/13.
//
//

#import "StringUtil.h"

@implementation StringUtil

static NSNumberFormatter *numberFormatter;
static NSNumberFormatter *numberFormatterDecimal;

//Ham chuyen chuoi 15/12/2013 => 2013/12/15
+(NSString*) reverseDateString:(NSString *)inputStr{
    
    NSString *strTempTime = inputStr;
    NSArray *arrayValidTime = [inputStr componentsSeparatedByString:@"/"];
    
    if (arrayValidTime.count==3) {
        // strTempTime = [arrayValidTime componentsJoinedByString:@"/"];
        arrayValidTime = [[arrayValidTime reverseObjectEnumerator]allObjects];
        strTempTime = [arrayValidTime componentsJoinedByString:@"/"];
    }
    
    return strTempTime;
}


+(NSString*) formatNumberWithDecimal:(NSNumber *)numb{
    if (numberFormatterDecimal==nil) {
        numberFormatterDecimal = [[NSNumberFormatter alloc] init];
        [numberFormatterDecimal setPositiveFormat:@"###0.##"];
    }
    
    NSString *formattedNumberString = [NSString stringWithFormat:@"%@ %%",[numberFormatterDecimal stringFromNumber:numb]] ;
    return formattedNumberString;
}

//Ham format so thanh sau
+(NSString*) formatNumber: (NSNumber*) numb{
    if (numberFormatter==nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,###"];
    }
    
    
    
    NSString *formattedNumberString = [numberFormatter stringFromNumber:numb];
    
   // NSLog(@"formattedNumberString: %@", formattedNumberString);
    
    // Output for locale en_US: "formattedNumberString: formattedNumberString: 122,344.45"
    return formattedNumberString;
}

+ (BOOL ) stringIsEmpty:(NSString *) inputString {
    
    @try {
        if ((NSNull *) inputString == [NSNull null]) {
            return YES;
        }
        
        
        
        if (inputString == nil) {
            return YES;
        } else if ([inputString length] == 0) {
            return YES;
        } else {
            inputString = [inputString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([inputString length] == 0) {
                return YES;
            }
        }
        
        if ([inputString isEqualToString:@"(null)"]) {
            return YES;
        }

    }
    @catch (NSException *exception) {
        return  YES;
    }
    
    
    return NO;
}

+ (BOOL ) stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    }
    
    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;  
}


+(BOOL)validateSpecialCharacter:(NSString*) inText
{
	
	NSString *specialChar =  @"`~!@#$%^&*()_+|\\-={}[]:\";.<>?'/,";
    if (inText.length>0) {
        for(int i = 0; i< [inText length] ;i++)
        {
            for(int j = 0;j < [specialChar length];j++)
            {
                if([inText characterAtIndex:i] == [specialChar characterAtIndex:j])
                {
                    return TRUE;
                    break;
                }
            }
        }
    }
    
	return FALSE;
}

+(NSInteger) getLengStringWithUTF8Unicode : (NSString*) inText{
    
    NSData* data=[inText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger myLength = data.length;
    return myLength;
}

+(BOOL)validateNumber:(NSString*) inText
{
	
	NSString *specialChar =  @"1234567890";
    if (inText.length>0) {
        for(int i = 0; i< [inText length] ;i++)
        {
            for(int j = 0;j < [specialChar length];j++)
            {
                if([inText characterAtIndex:i] == [specialChar characterAtIndex:j])
                {
                    return TRUE;
                    break;
                }
            }
        }
    }
    
	return FALSE;
}

+(BOOL)validateCharacter:(NSString*) inText
{
	
	NSString *specialChar =  @"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm";
    if (inText.length>0) {
        for(int i = 0; i< [inText length] ;i++)
        {
            for(int j = 0;j < [specialChar length];j++)
            {
                if([inText characterAtIndex:i] == [specialChar characterAtIndex:j])
                {
                    return TRUE;
                    break;
                }
            }
        }
    }
    
	return FALSE;
}


+(BOOL) checkStringIsNumber : (NSString*) inText{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:inText])
    {
        return NO;
    }
    return YES;
}

+ (NSString *) getCountFromData : (id) data
{
    NSDictionary *response = [data objectForKey:@"response"];
    NSString *count = [NSString stringWithFormat:@"%@",[response objectForKey:@"result"]];
    if (count.length > 0) {
        return count;
    }
    else
        return @"0";
}


+(NSString *) convertVietNameseToEnglish : (NSString *) currentStr
{
    NSString * replacedStr;
    
    
    replacedStr = [currentStr  stringByReplacingOccurrencesOfString:@"á" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ả" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ạ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"à" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ã" withString:@"a"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Á" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ả" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ạ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"À" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ã" withString:@"A"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ă" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ắ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẳ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ặ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ằ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẵ" withString:@"a"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ă" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ắ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẳ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ặ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ằ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẵ" withString:@"A"];
    //âấẩậầẫ
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"â" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ấ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẩ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ậ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ầ" withString:@"a"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẫ" withString:@"a"];
    //
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Â" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ấ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẩ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ậ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ầ" withString:@"A"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẫ" withString:@"A"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"đ" withString:@"d"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Đ" withString:@"D"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"é" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẻ" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẹ" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"è" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ẽ" withString:@"e"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"É" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẻ" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẹ" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"È" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ẽ" withString:@"E"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ê" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ế" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ể" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ệ" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ề" withString:@"e"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ễ" withString:@"e"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ê" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ế" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ể" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ệ" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ề" withString:@"E"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ễ" withString:@"E"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"í" withString:@"i"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỉ" withString:@"i"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ị" withString:@"i"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ì" withString:@"i"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ĩ" withString:@"i"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Í" withString:@"I"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỉ" withString:@"I"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ị" withString:@"I"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ì" withString:@"I"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ĩ" withString:@"I"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ó" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỏ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ọ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ò" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"õ" withString:@"o"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ó" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỏ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ọ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ò" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Õ" withString:@"O"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ô" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ố" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ổ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ộ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ồ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỗ" withString:@"o"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ô" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ố" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ổ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ộ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ồ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỗ" withString:@"O"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ơ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ớ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ở" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ợ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ờ" withString:@"o"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỡ" withString:@"o"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ơ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ớ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ở" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ợ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ờ" withString:@"O"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỡ" withString:@"O"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ú" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ủ" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ụ" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ù" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ũ" withString:@"u"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ú" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ủ" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ụ" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ù" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ũ" withString:@"U"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ư" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ứ" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ử" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ự" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ừ" withString:@"u"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ữ" withString:@"u"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ư" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ứ" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ử" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ự" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ừ" withString:@"U"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ữ" withString:@"U"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ý" withString:@"y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỷ" withString:@"y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỵ" withString:@"y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỳ" withString:@"y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"ỹ" withString:@"y"];
    
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ý" withString:@"Y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỷ" withString:@"Y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỵ" withString:@"Y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỳ" withString:@"Y"];
    replacedStr = [replacedStr stringByReplacingOccurrencesOfString:@"Ỹ" withString:@"Y"];
    
    
    return replacedStr;
}

+(NSString *) getAcronymWord: (NSString*) currentStr{
    
    NSArray *array = [currentStr componentsSeparatedByString:@" "];
    NSString *result = @"";
    for (NSString *s in array) {
        if (s.length>0 && ([s isEqualToString:@""] == NO)) {
            [result stringByAppendingString:[s substringToIndex:1]];
        }
    }
    result = [result uppercaseString];
    return result;
}

+(NSString*) reverseString : (NSString*) currentStr{
    
    
    int len = [currentStr length];
    NSMutableString *reverseName = [[NSMutableString alloc] initWithCapacity:len];
    
    for(int i=len-1;i>=0;i--)
    {
        [reverseName appendFormat:[NSString stringWithFormat:@"%c",[currentStr characterAtIndex:i]]];
        
    }
    return reverseName;
}

+(NSString*) trimString : (NSString*) currentStr{
    currentStr = [currentStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return currentStr;
}

+(NSMutableArray *) parseXML:(NSString *)stringXML withComponent:(NSString *) componentStr forkey:(NSString *) keyString
{
    NSMutableArray *needArray = [[NSMutableArray alloc]init];
    NSArray *tempArray = [stringXML componentsSeparatedByString:[NSString stringWithFormat:@"<%@>",componentStr]];
    NSString *beginKey = [NSString stringWithFormat:@"<%@>",keyString];
    NSString *endKey = [NSString stringWithFormat:@"</%@>",keyString];
    
    int lengthTempArray = [tempArray count];
    int beginpoint;
    int endpoint;
    if (lengthTempArray >0) {
        for (int i=1; i<lengthTempArray; i++) {
            NSString *tempStr = [tempArray objectAtIndex:i];
            
            beginpoint = [tempStr rangeOfString:beginKey].location + [endKey length] -1;
            endpoint = [tempStr rangeOfString:endKey].location;
            NSString *areaIdStr = [tempStr substringToIndex:endpoint];
            areaIdStr = [areaIdStr substringFromIndex:beginpoint];
            [needArray addObject:areaIdStr];
        }
    }
    else
    {
        [needArray addObject:@"No data"];
    }
    
    return needArray;
    
}

@end
