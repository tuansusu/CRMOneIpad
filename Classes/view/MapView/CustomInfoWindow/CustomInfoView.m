//
//  CustomInfoView.m
//  OfficeOneMB
//
//  Created by macpro on 12/19/14.
//
//

#import "CustomInfoView.h"
#import "DTOAcountLeadProcessObject.h"

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

-(void) loadViewWithCustomerOB:(DTOAcountLeadProcessObject *)customerOB{
    NSString *code = @"";
    NSString *name = @"";
    if (customerOB.code) {
        code = customerOB.code;
    }
    if (customerOB.name) {
        name = customerOB.name;
    }

    lblTitle.text = [NSString stringWithFormat:@"%@-%@",code,name];

    if (customerOB.address) {
        lblAdress.text = @"Địa chỉ: N/a";
    }else{
        lblAdress.text = [NSString stringWithFormat:@"Địa chỉ: %@",customerOB.address];
    }

    if (customerOB.email) {
        lblEmail.text = @"Email: N/a";
    }else{
        lblEmail.text = [NSString stringWithFormat:@"Email: %@",customerOB.address];
    }

    if (customerOB.mobile) {
        lblPhone.text = @"Điện thoại: N/a";

    }else{
        lblPhone.text =[NSString stringWithFormat:@"Điện thoại : %@",customerOB.mobile];
    }
}

@end
