//
//  UIView+Custom.m
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import "UIView+Custom.h"

@implementation UIView (Custom)

-(void) setBackGroundNormalColorWithOption : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundColor:BACKGROUND_NORMAL_COLOR1];
        }
            break;
            
        default:
            break;
    }
}

-(void) setBackGroundMenuView : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundColor:MENU_VIEW_COLOR];
        }
            break;
            
        default:
            break;
    }
}
-(void) setBackGroundHeaderView : (int) smgSelect
{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundColor:HEADER_VIEW_COLOR1];
        }
            break;
            
        default:
            break;
    }
}

-(void) setBackGroundFooterView : (int) smgSelect
{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundColor:TOOLBAR_VIEW_COLOR];
        }
            break;
            
        default:
            break;
    }
}

-(void) setBackGroundSubHeaderView : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
        }
            break;
            
        default:
            break;
    }
}

-(void) setBackGroundForBackgroundView : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            [self setBackgroundColor:HEADER_SUB_VIEW_COLOR1];
        }
            break;
            
        default:
            break;
    }
}



-(void) setBorderWithOption : (int) smgSelect  withBorderFlag : (AUISelectiveBordersFlag) inputBorderFlag{
    switch (smgSelect) {
        case 1:
        {
            [self setSelectiveBorderWithColor:BORDER_COLOR withBorderWith:BORDER_WITH withBorderFlag:inputBorderFlag];
        }
            break;
            
        default:
            break;
    }
}


-(void) setBorderWithOption : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.layer.borderColor = [BORDER_COLOR CGColor];
            self.layer.borderWidth = BORDER_WITH;
        }
            break;
            
        default:
            break;
    }
}


@end
