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
        [imgLineTop setAlpha:1.0];
        [imgLineBottom setAlpha:1.0];
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

-(void)loadViewWithTittle:(NSString*)title WithTotalBalanceQD:(double)totalBalanceQD{
    [lblTitle setText:title];

    NSNumber *number = [NSNumber numberWithFloat:totalBalanceQD];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *totalBalanceStr = [formatter stringFromNumber:number];
    [lblTotalBalanceQD setText:totalBalanceStr];
}

@end
