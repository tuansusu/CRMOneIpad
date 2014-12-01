//
//  UIButton+Custom.m
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import "UIButton+Custom.h"


@implementation UIButton (Custom)

-(void) setStyleNormalWithOption : (int) smgSelect{
    
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundImage:[UIImage imageWithOverlayColor:BUTTON_IN_ACTIVE_COLOR_1] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithOverlayColor:BUTTON_ACTIVE_COLOR_1] forState:UIControlStateHighlighted];
            [self setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
            
        }
            break;
        default:
            break;
    }
}

-(void) setActiveBackgroundWithOption : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundImage:[UIImage imageWithOverlayColor:BUTTON_IN_ACTIVE_COLOR_1] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithOverlayColor:BUTTON_ACTIVE_COLOR_1] forState:UIControlStateNormal];
            [self setTitleColor:TEXT_BUTTON_COLOR1 forState:UIControlStateNormal];
            
        }
            break;
            
        default:
            break;
    }
}


-(void) setStyleClearBackGroundWithOption : (int) smgSelect{
    
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundImage:[UIImage imageWithOverlayColor:[UIColor clearColor]] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithOverlayColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
            
        }
            break;
        default:
            break;
    }
}

-(void) setTextColorMenuSub : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            [self setTitleColor:TEXT_COLOR_MENU_SUB forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}



@end
