//
//  NSRegularExpression+VofficeRegularExpression.m
//  Voffice2.1
//
//  Created by VTIT on 10/1/13.
//
//

#import "NSRegularExpression+VofficeRegularExpression.h"

@implementation NSRegularExpression (VofficeRegularExpression)

+(NSString*) convertNormalStringRegexString : (NSString*) stringInput{
    stringInput = [stringInput lowercaseString];
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"[" withString:@"\\["];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"]" withString:@"\\]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"{" withString:@"\\{"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"}" withString:@"\\}"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"!" withString:@"\\!"];
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"+" withString:@"\\+"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"-" withString:@"\\-"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"(" withString:@"\\("];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@")" withString:@"\\)"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"&" withString:@"\\&"];
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"$" withString:@"\\$"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"#" withString:@"\\#"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"@" withString:@"\\@"];
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"\\c" withString:@"\\\\"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"?" withString:@"\\?"];
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"/" withString:@"\\/"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"|" withString:@"\\|"];
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"a" withString:@"[aáàảãạăắằẳẵặâấầẩẫậ]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"d" withString:@"[dđ]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"e" withString:@"[eéèẻẽẹêếềểễệ]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"i" withString:@"[iíìỉĩị]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"o" withString:@"[oóòỏõọôốồổỗộơớờởỡợ]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"u" withString:@"[uúùủũụưứừửữự]"];
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"y" withString:@"[yýỳỷỹỵ]"];
    
    
    
    stringInput = [stringInput stringByReplacingOccurrencesOfString:@"y" withString:@"[yýỳỷỹỵ]"];
    
    return [NSString stringWithFormat:@".*%@.*", stringInput];
}

+(BOOL) checkSubString : (NSString*) subStringInput : (NSString*) stringInput{
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[NSRegularExpression convertNormalStringRegexString:subStringInput]
                                  
                                                                           options:NSRegularExpressionCaseInsensitive
                                  
                                                                             error:&error];
    
    
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:stringInput
                                  
                                                        options:0
                                  
                                                          range:NSMakeRange(0, [stringInput length])];
    
    
    return numberOfMatches>0;
}

@end
