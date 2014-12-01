//
//  UILabel+Custom.m
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import "UILabel+Custom.h"
#import "UIView+AUISelectiveBorder.h"

@implementation UILabel (Custom)

-(void) setBottomBorderWithOption : (int) smgSelect {
    switch (smgSelect) {
        case 1:
        {
            self.selectiveBorderFlag = AUISelectiveBordersFlagBottom;
            self.selectiveBordersColor = BORDER_COLOR;
            self.selectiveBordersWidth = BORDER_WITH;
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void) setTextColorMenuHeader : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_MENU_HEADER;
        }
            break;
            
        default:
            break;
    }
    
}

-(void) setTextColorHeaderApp : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_HEADER_APP;
        }
            break;
            
        default:
            break;
    }
}

-(void) setTextColorFooter : (int) smgSelect
{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_TOOLBAR_COLOR1;
        }
            break;
            
        default:
            break;
    }
}

-(void) setTextColorNotifyNumber : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_HOME;
        }
            break;
            
        default:
            break;
    }
}


-(void) setTextColorHome : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_HOME;
        }
            break;
            
        default:
            break;
    }
}

-(void) setTextColorHightLight : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_BLUE;
        }
            break;
            
        default:
            break;
    }
}


-(void) setTextColorRuning : (int) smgSelect{
    switch (smgSelect) {
        case 1:
        {
            self.textColor = TEXT_COLOR_HOME_RUNNING;
        }
            break;
            
        default:
            break;
    }
}

@end
