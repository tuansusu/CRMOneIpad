//
//  LineView.m
//  Voffice2.1
//
//  Created by VTIT on 11/25/13.
//
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:240*1.0f/255 green:240*1.0f/255 blue:240*1.0f/255 alpha:1.0f];
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

-(void) drawRect:(CGRect)rect{
    //hien thi thong tin cai line o day
    
        CGContextRef context1 = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context1, 1.0);
       //CGContextSetStrokeColorWithColor(context1, [UIColor colorWithRed:240*1.0f/255 green:240*1.0f/255 blue:240*1.0f/255 alpha:0.3f].CGColor);
    
    CGContextSetStrokeColorWithColor(context1, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context1,  0, 0);
        CGContextAddLineToPoint(context1, 0, self.frame.size.height);
        CGContextStrokePath(context1);
    
}

@end
