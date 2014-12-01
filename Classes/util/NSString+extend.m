//
//  NSString+extend.m
//  Voffice2.1
//
//  Created by VTIT on 1/17/14.
//
//

#import "NSString+extend.h"

@implementation NSString (extend)
- (NSInteger)countOccurencesOfString:(NSString*)searchString {
    int strCount = [self length] - [[self stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    return strCount / [searchString length];
}


-(BOOL)containsString:(NSString *)substring
              atRange:(NSRange *)range{
    
    NSRange r = [self rangeOfString : substring];
    BOOL found = ( r.location != NSNotFound );
    if (range != NULL) *range = r;
    return found;
}

-(BOOL)containsString:(NSString *)substring
{
    return [self containsString:substring
                        atRange:NULL];
}


-(NSString*) capitalisedSentence {
    
    NSString *result = self;
    
    if (self && [self length]>0) {
        //Yes. It is
        
      result =  [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                  withString:[[self substringToIndex:1] capitalizedString]];
        
        
        
    }
    return result;
}

@end
