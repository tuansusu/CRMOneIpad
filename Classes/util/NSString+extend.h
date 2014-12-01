//
//  NSString+extend.h
//  Voffice2.1
//
//  Created by VTIT on 1/17/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (extend)
- (NSInteger)countOccurencesOfString:(NSString*)searchString;
-(BOOL)containsString: (NSString*)substring
              atRange:(NSRange*)range;

-(BOOL)containsString:(NSString *)substring;

-(NSString*) capitalisedSentence ;

@end
