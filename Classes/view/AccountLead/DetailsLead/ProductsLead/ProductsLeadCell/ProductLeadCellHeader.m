//
//  ProductLeadCellHeader.m
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import "ProductLeadCellHeader.h"

@implementation ProductLeadCellHeader
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

-(void)loadViewWithTittle:(NSString*)title{
    [lblTitle setText:title];
}

@end
