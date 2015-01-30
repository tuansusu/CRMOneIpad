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
    _khdmOB = khdmOB;
    _customerType = typeKHDM;

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
    _kh360OB = kh360OB;
    _customerType = typeKH360;

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

#pragma mark btn Call Customer Action
-(IBAction)btnCallCustomerTapper:(id)sender{
    
}

#pragma mark btn Send SMS Customer Action
-(IBAction)btnSendSMSCustomerTapper:(id)sender{
    if (_customerType == typeKHDM) {
//        if (_khdmOB.phone) {
            if (_delegate && [_delegate respondsToSelector:@selector(sendSMSToCustomerTel:)]) {
                [_delegate sendSMSToCustomerTel:@"1234"];
            }
//        }
    }else if (_customerType == typeKH360) {
//        if (_kh360OB.phone) {
            if (_delegate && [_delegate respondsToSelector:@selector(sendSMSToCustomerTel:)]) {
                [_delegate sendSMSToCustomerTel:@"1234"];
            }
//        }
    }

}

#pragma mark btn Send Mail Customer Action
-(IBAction)btnSendMailCustomerTapper:(id)sender{
    
}

#pragma mark btn Info Customer Action
-(IBAction)btnInfoCustomerTapper:(id)sender{

}

-(void)ButtonPressed{

}
@end
