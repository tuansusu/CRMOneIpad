//
//  VTRadio.m
//  OfficeOneStudy
//
//  Created by viettel on 11/1/14.
//
//

#import "VTRadio.h"

#define Image_CheckBox_Check @"icon_radio-button_on.png"
#define Image_CheckBox_UnCheck @"icon_radio-button_off.png"

@implementation VTRadio

-(id)init{
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VTRadio" owner:self options:nil];
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
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
