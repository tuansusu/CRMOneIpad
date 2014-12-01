//
//  UILabel+extend.m
//  Voffice2.1
//
//  Created by VTIT on 10/10/13.
//
//

#import "UILabel+extend.h"
#import "UIDevice+extend.h"
#import "UIView+AUISelectiveBorder.h"

@implementation UILabel (extend)

+(float) getWidthFitWithLabel : (UILabel*) yourLabel {
    float widthIs =
    [yourLabel.text
     boundingRectWithSize:yourLabel.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:yourLabel.font }
     context:nil]
    .size.width;
    
    NSLog(@"the width of yourLabel is %f", widthIs);
    return  widthIs;
}

+(void) setBottomBorder : (UILabel*) lblLabel{
    lblLabel.selectiveBorderFlag = AUISelectiveBordersFlagBottom;
    lblLabel.selectiveBordersColor = BORDER_COLOR;
    lblLabel.selectiveBordersWidth = BORDER_WITH;
}

+(void) setMultiline : (UILabel*) lblLabel{
    if ([UIDevice getCurrentSysVer] >= 7.0) {

        CGRect labelFrame = lblLabel.frame;
        CGRect expectedFrame = [lblLabel.text boundingRectWithSize:CGSizeMake(lblLabel.frame.size.width, 9999)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 lblLabel.font, NSFontAttributeName,
                                                                 nil]
                                                        context:nil];
        if (labelFrame.size.height<expectedFrame.size.height ) {
            labelFrame.size.height = expectedFrame.size.height;
            labelFrame.size.height = ceil(labelFrame.size.height);
        }
        
        if (labelFrame.size.width<expectedFrame.size.width) {
            labelFrame.size.width = expectedFrame.size.width;
            labelFrame.size.width = ceil(labelFrame.size.width);
        }
         //iOS7 is not rounding up to the nearest whole number
        lblLabel.frame = labelFrame;
        lblLabel.numberOfLines = 0;
        
        
    
    }else{
        lblLabel.frame = [UILabel getMultilineFrame:lblLabel];
    }
}

+(CGRect) getMultilineFrame : (UILabel*) lblLabel{
    lblLabel.numberOfLines = 0;
    CGSize size = [lblLabel.text sizeWithFont:lblLabel.font constrainedToSize:CGSizeMake(lblLabel.frame.size.width,FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    return  CGRectMake(lblLabel.frame.origin.x,lblLabel.frame.origin.y,lblLabel.frame.size.width,size.height);
    
}

+(CGFloat) getRowHeightWithString : (NSString*) strMessage withW : (float) width withFontSize : (int) fontSize {
    
    CGSize maximumSize =CGSizeMake(width, 9999);
    
    UIFont *myFont = [UIFont fontWithName:@"Helvetica" size:fontSize];
    CGSize myStringSize = [strMessage sizeWithFont:myFont
                                                constrainedToSize:maximumSize
                                                    lineBreakMode:UILineBreakModeWordWrap];
    
    return myStringSize.height;
    
}

+(void) setBoldLabel : (UILabel*) inputLabel{
    UIFont *currentFont = inputLabel.font;
    UIFont *newFont = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",currentFont.fontName] size:currentFont.pointSize];
    inputLabel.font = newFont;
}


@end
