//
//  DirectionsHeaderView.m
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#import "DirectionsHeaderView.h"

@implementation DirectionsHeaderView

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

-(void)loadViewWithTittle:(NSString*)title withImage:(UIImage*)image{
    [imgIconDirection setImage:image];
    [lblTitle setText:title];
}

@end
