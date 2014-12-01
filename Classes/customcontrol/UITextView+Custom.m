//
//  UITextView+Custom.m
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import "UITextView+Custom.h"

@implementation UITextView (Custom)

-(void) setStyleNormalWithOption : (int) smgSelect{
    
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_REPORT;
            self.backgroundColor = BACKGROUND_NORMAL_COLOR1;
            self.layer.borderColor = [BORDER_COLOR CGColor];
            self.layer.borderWidth = BORDER_WITH;
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
