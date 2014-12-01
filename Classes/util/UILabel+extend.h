//
//  UILabel+extend.h
//  Voffice2.1
//
//  Created by VTIT on 10/10/13.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (extend)

+(float) getWidthFitWithLabel : (UILabel*) yourLabel  ;

+(CGRect) getMultilineFrame : (UILabel*) lblLabel;
+(CGFloat) getRowHeightWithString : (NSString*) strMessage withW : (float) width withFontSize : (int) fontSize;

+(void) setMultiline : (UILabel*) lblLabel;
+(void) setBottomBorder : (UILabel*) lblLabel;
+(void) setBoldLabel : (UILabel*) inputLabel;

@end
