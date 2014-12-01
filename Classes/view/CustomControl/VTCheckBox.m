//
//  VTCheckBox.m
//  VTCustomView
//
//  Created by ADMIN on 9/4/14.
//  Copyright (c) 2014 ADMIN. All rights reserved.
//

#import "VTCheckBox.h"

#define Image_CheckBox_Check @"checkbox_ticked.png"
#define Image_CheckBox_UnCheck @"checkbox_not_ticked.png"

@implementation VTCheckBox

-(id)init{
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VTCheckBox" owner:self options:nil];
    id mainView = [subviewArray objectAtIndex:0];
    
    [self setCheck:NO];
    
    return mainView;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setCheck:(BOOL)inputCheck{
    checked = inputCheck;
    if (checked) {
        [btnCheckBox setImage:[UIImage imageNamed:Image_CheckBox_Check] forState:UIControlStateNormal];
    }else{
        [btnCheckBox setImage:[UIImage imageNamed:Image_CheckBox_UnCheck] forState:UIControlStateNormal];
    }
    
}

-(BOOL) getCheck {
    return checked;
}

- (IBAction)action_check_click:(id)sender {
    
    checked = !checked;
    [self setCheck:checked];
    
    if ([self.delegate respondsToSelector:@selector(checkBoxClick:withIndex:)]) {
        [self.delegate checkBoxClick:sender withIndex:self.index];
    }

}





@end
