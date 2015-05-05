//
//  UITextField+Custom.m
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import "UITextField+Custom.h"

@implementation UITextField (Custom)

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

/*
 *Set padding cho UITextField
 */
-(void) setPaddingLeft {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
-(void) setPaddingRight{

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 0)];
    self.rightView = paddingView;
    self.rightViewMode =UITextFieldViewModeAlways;
}
@end
