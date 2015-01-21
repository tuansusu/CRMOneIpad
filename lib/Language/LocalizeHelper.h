//
//  LocalizeHelper.h
//  OfficeOneIpad
//
//  Created by Đỗ Dũng on 8/22/14.
//
//

#import <Foundation/Foundation.h>

#define LocalizedString(key) [[LocalizeHelper sharedLocalSystem] localizedStringForKey:(key)]

#define LocalizationSetLanguage(language) [[LocalizeHelper sharedLocalSystem] setLanguage:(language)]

@interface LocalizeHelper : NSObject

// a singleton:
+ (LocalizeHelper*) sharedLocalSystem;

// this gets the string localized:
- (NSString*) localizedStringForKey:(NSString*) key;

//set a new language:
- (void) setLanguage:(NSString*) lang;

@end