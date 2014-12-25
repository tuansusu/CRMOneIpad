//
//  StringRemoval.m
//  Wedding
//
//  Created by spraveenk91 on 2/19/14.
//  Copyright (c) 2014 spraveenk91. All rights reserved.
//

#import "StringRemoval.h"

@implementation StringRemoval

@end

@implementation NSString (stringRemoval)

- (id) removeHTMLTag {
    
    NSString *string = [self copy];
    [[string stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://www.americanweddinggroup.com/API/PublicJSON\">" withString:@""] stringByReplacingOccurrencesOfString:@"</string>" withString:@""];
    return string;
}

- (id) stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
