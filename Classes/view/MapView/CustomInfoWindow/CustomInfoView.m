//
//  CustomInfoView.m
//  OfficeOneMB
//
//  Created by macpro on 12/19/14.
//
//

#import "CustomInfoView.h"

@implementation CustomInfoView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:nil options:nil] objectAtIndex:0];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) loadViewWithData:(NSDictionary *)dicData{
    NSString *code = @"";
    NSString *name = @"";
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_code]]) {
        code = [dicData objectForKey:DTOLEAD_code];
    }
    if (![StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_name]]) {
        name = [dicData objectForKey:DTOLEAD_name];
    }

    lblTitle.text = [NSString stringWithFormat:@"%@-%@",code,name];

    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_address]]) {
        lblAdress.text = @"N/a";
    }else{
        lblAdress.text = [NSString stringWithFormat:@"Địa chỉ: %@",[dicData objectForKey:DTOLEAD_address]];
    }

    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_email]]) {
        lblEmail.text = @"N/a";
    }else{
        lblEmail.text = [NSString stringWithFormat:@"Email: %@",[dicData objectForKey:DTOLEAD_email]];
    }

    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOLEAD_mobile]]) {
        lblPhone.text = @"N/a";

    }else{
        lblPhone.text =[NSString stringWithFormat:@"Điện thoại : %@",[dicData objectForKey:DTOLEAD_mobile]];
    }
}

@end
