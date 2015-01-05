//
//  TaskCalTLineCell.m
//  OfficeOneMB
//
//  Created by Duy Pham on 12/13/14.
//
//

#import "TaskCalTLineCell.h"

#define CALENDAR_T_HENGAP       1
#define CALENDAR_T_GOIDIEN      2
#define CALENDAR_T_EMAIL        4
#define CALENDAR_T_NGOAIBANHANG 6
#define CALENDAR_T_NGHIPHEP     7
#define CALENDAR_T_KHAC         5


@implementation TaskCalTLineCell
{
    __weak IBOutlet UILabel *_dateLabel;
    __weak IBOutlet UILabel *_timeLabel;
    __weak IBOutlet UILabel *_typeLabel;
    __weak IBOutlet UIImageView *_typeImage;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_descLabel;
    __weak IBOutlet UILabel *_customerLabel;
    
    __weak IBOutlet UIView *_bubbleview;
    CAShapeLayer *_topTLine;
    CAShapeLayer *_botTLine;
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"TaskCalTLineCell" bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
    _topTLine = [[CAShapeLayer alloc] init];
    _botTLine = [[CAShapeLayer alloc] init];
    _tbv_position = TaskCalTLineCell_Middle;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBubble];
    [self drawTimeline];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTbv_position:(TaskCalTLineCellType)tbv_position
{
    _tbv_position = tbv_position;
    
    if (tbv_position == TaskCalTLineCell_Top)
    {
        _topTLine.hidden = TRUE;
        _botTLine.hidden = FALSE;
    }
    else if (tbv_position == TaskCalTLineCell_Bottom)
    {
        _topTLine.hidden = FALSE;
        _botTLine.hidden = TRUE;
    }
    else
    {
        _topTLine.hidden = FALSE;
        _botTLine.hidden = FALSE;
    }
}

- (void)loadDataToCellWithData:(NSDictionary *)dicData withOption:(int)smgSelect
{
    // title
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_title]])
    {
        _titleLabel.text = @"";
    }
    else
    {
        _titleLabel.text = [dicData objectForKey:DTOTASK_title];
    }
    
    // date+time
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_startDate]])
    {
        _dateLabel.text = @"";
        _timeLabel.text = @"";
    }
    else
    {
        NSString *startDateStr = [dicData objectForKey:DTOTASK_startDate];
        NSDate *startDate = [DateUtil getDateFromString:startDateStr :FORMAT_DATE_AND_TIME];
        
        _dateLabel.text = [DateUtil formatDate:startDate :FORMAT_DATE];
        _timeLabel.text  = [DateUtil formatDate:startDate :FORMAT_TIME];
    }
    
    // type
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_formal]])
    {
        _typeLabel.text = @"";
        _typeImage.hidden = YES;
    }
    else
    {
        int type = [[dicData objectForKey:DTOTASK_formal] intValue];
        //TODO: set type image
        if (type == CALENDAR_T_HENGAP)
        {
            _typeLabel.text = @"Hẹn gặp";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_GOIDIEN)
        {
            _typeLabel.text = @"Gọi điện";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_EMAIL)
        {
            _typeLabel.text = @"Email";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_NGOAIBANHANG)
        {
            _typeLabel.text = @"Ngoài bán hàng";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else if (type == CALENDAR_T_NGHIPHEP)
        {
            _typeLabel.text = @"Nghỉ phép";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        else
        {
            _typeLabel.text = @"Khác";
            // [_typeImage setImage:<#(UIImage *)#>];
        }
        
        _typeImage.hidden = NO;
    }
    
    // description
    if ([StringUtil stringIsEmpty:[dicData objectForKey:DTOTASK_content]])
    {
        _descLabel.text = @"";
    }
    else
    {
        _descLabel.text = [dicData objectForKey:DTOTASK_content];
    }
    
    //TODO: customer name label?
    _customerLabel.text = @"";
}

- (void)drawBubble
{
    CGRect frame = _bubbleview.frame;
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(CGRectGetMaxX(frame) - 1, CGRectGetMinY(frame) + 9)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMaxX(frame) - 1, CGRectGetMaxY(frame) - 9)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMaxX(frame) - 10, CGRectGetMaxY(frame) - 1) controlPoint1: CGPointMake(CGRectGetMaxX(frame) - 1, CGRectGetMaxY(frame) - 2) controlPoint2: CGPointMake(CGRectGetMaxX(frame) - 3, CGRectGetMaxY(frame) - 1)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 17, CGRectGetMaxY(frame) - 1)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMaxY(frame) - 9) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 10, CGRectGetMaxY(frame) - 1) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMaxY(frame) - 2)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 27)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 1, CGRectGetMinY(frame) + 19)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 11)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 9)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 17, CGRectGetMinY(frame) + 1) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 2) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 1)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMaxX(frame) - 10, CGRectGetMinY(frame) + 1)];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMaxX(frame) - 1, CGRectGetMinY(frame) + 9) controlPoint1: CGPointMake(CGRectGetMaxX(frame) - 3, CGRectGetMinY(frame) + 1) controlPoint2: CGPointMake(CGRectGetMaxX(frame) - 1, CGRectGetMinY(frame) + 2)];
    [bezierPath closePath];
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    [UIColor.lightGrayColor setStroke];
    bezierPath.lineWidth = 1.5;
    [bezierPath stroke];
}

- (void)drawTimeline
{
    CGRect dateFrame   = _dateLabel.frame;
    CGRect iconFrame   = _typeImage.frame;
    CGRect bubbleFrame = _bubbleview.frame;
    CGRect frame       = self.contentView.frame;
    
    UIBezierPath* topPath = [UIBezierPath bezierPathWithRect: CGRectMake((CGRectGetMaxX(dateFrame) + CGRectGetMinX(bubbleFrame))/2 - 1.5, CGRectGetMinY(frame), 3, CGRectGetMidY(iconFrame))];
    
    _topTLine.path        = topPath.CGPath;
    _topTLine.fillColor   = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:_topTLine];
    
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake((CGRectGetMaxX(dateFrame) + CGRectGetMinX(bubbleFrame))/2 - 7.5, CGRectGetMidY(iconFrame) - 7.5, 15, 15)];
    [UIColor.lightGrayColor setFill];
    [circlePath fill];
    
    UIBezierPath* rightPath = [UIBezierPath bezierPathWithRect: CGRectMake((CGRectGetMaxX(dateFrame) + CGRectGetMinX(bubbleFrame))/2, CGRectGetMidY(iconFrame) - 1.5, CGRectGetMinX(iconFrame) - (CGRectGetMaxX(dateFrame) + CGRectGetMinX(bubbleFrame))/2, 3)];
    [UIColor.lightGrayColor setFill];
    [rightPath fill];
    
    UIBezierPath* bottomPath = [UIBezierPath bezierPathWithRect: CGRectMake((CGRectGetMaxX(dateFrame) + CGRectGetMinX(bubbleFrame))/2 - 1.5, CGRectGetMidY(iconFrame), 3, CGRectGetHeight(frame) - CGRectGetMidY(iconFrame))];
    
    _botTLine.path        = bottomPath.CGPath;
    _botTLine.fillColor   = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:_botTLine];

}
@end
