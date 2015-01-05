//
//  StringRemoval.h
//  Wedding
//
//  Created by spraveenk91 on 2/19/14.
//  Copyright (c) 2014 spraveenk91. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringRemoval : NSObject

@end

@interface NSString (stringRemoval)

- (id) removeHTMLTag;

- (id) stringByStrippingHTML;

- (BOOL)validateEmail;

@end