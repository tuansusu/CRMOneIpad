//
//  ExampleHTMLStringToAttributedString.h
//  Voffice2.1
//
//  Created by VTIT on 8/20/13.
//
//

#import <Foundation/Foundation.h>

@interface ExampleHTMLStringToAttributedString : NSObject<NSXMLParserDelegate>
+(NSAttributedString*) getAttributedStringForHTMLText:(NSString*)htmlText WithFontSize:(CGFloat)fontSize;


@property NSString *mpString;
@property NSMutableAttributedString *mpAttributedString;

@property CGFloat mfFontSize;
@property NSMutableString *appendThisString;
@property BOOL mbIsBold;
@property BOOL mbIsItalic;
@end
