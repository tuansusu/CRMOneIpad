//
//  CustomInfoView.m
//  OfficeOneMB
//
//  Created by macpro on 12/19/14.
//
//

#import "CustomInfoView.h"
#import "DTOAcountLeadProcessObject.h"
#import "DTOAccountProcessObject.h"

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

-(void) loadViewWithKHDMOB:(DTOAcountLeadProcessObject *)khdmOB{
    NSString *code = @"";
    NSString *name = @"";
    if (khdmOB.code) {
        code = khdmOB.code;
    }
    if (khdmOB.name) {
        name = khdmOB.name;
    }

    lblTitle.text = [NSString stringWithFormat:@"%@-%@",code,name];

    if (khdmOB.address) {
        lblAdress.text = @"Địa chỉ: N/a";
    }else{
        lblAdress.text = [NSString stringWithFormat:@"Địa chỉ: %@",khdmOB.address];
    }

    if (khdmOB.email) {
        lblEmail.text = @"Email: N/a";
    }else{
        lblEmail.text = [NSString stringWithFormat:@"Email: %@",khdmOB.address];
    }

    if (khdmOB.mobile) {
        lblPhone.text = @"Điện thoại: N/a";

    }else{
        lblPhone.text =[NSString stringWithFormat:@"Điện thoại : %@",khdmOB.mobile];
    }
}

-(void) loadViewWithKH360OB:(DTOAccountProcessObject *)kh360OB{
    NSString *code = @"";
    NSString *name = @"";
    if (kh360OB.code) {
        code = kh360OB.code;
    }
    if (kh360OB.name) {
        name = kh360OB.name;
    }

    lblTitle.text = [NSString stringWithFormat:@"%@-%@",code,name];

    if (kh360OB.address) {
        lblAdress.text = @"Địa chỉ: N/a";
    }else{
        lblAdress.text = [NSString stringWithFormat:@"Địa chỉ: %@",kh360OB.address];
    }

    if (kh360OB.email) {
        lblEmail.text = @"Email: N/a";
    }else{
        lblEmail.text = [NSString stringWithFormat:@"Email: %@",kh360OB.address];
    }

    if (kh360OB.mobile) {
        lblPhone.text = @"Điện thoại: N/a";

    }else{
        lblPhone.text =[NSString stringWithFormat:@"Điện thoại : %@",kh360OB.mobile];
    }
}


@end
