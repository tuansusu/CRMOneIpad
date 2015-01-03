//
//  ProThanhToanQuocTeViewHeader.m
//  OfficeOneMB
//
//  Created by macpro on 1/3/15.
//
//

#import "ProThanhToanQuocTeViewHeader.h"

@implementation ProThanhToanQuocTeViewHeader
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

@end
