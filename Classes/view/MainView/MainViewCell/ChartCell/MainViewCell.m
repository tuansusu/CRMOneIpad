//
//  MainViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/23/14.
//
//

#import "MainViewCell.h"

#import "DTOWidgetObject.h"
#import "Globals.h"
#import "Items.h"

#define COLOR_ICON (UIColor *)[UIColor colorWithRed:10.0/255.0 green:110.0/255.0 blue:188.0/255.0 alpha:1]

@implementation MainViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithType:(TypeGraphs)typeGraph
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];
        [self initView];
        [contentChartView initChartViewWithType:typeGraph];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    widgetTypeView.layer.cornerRadius = CORNER_RADIUS_VIEW;
    widgetTypeView.clipsToBounds = YES;

    btnSave.layer.cornerRadius = CORNER_RADIUS_BUTTON;
    btnSave.clipsToBounds = YES;

    btnCancel.layer.cornerRadius = CORNER_RADIUS_BUTTON;
    btnCancel.clipsToBounds = YES;

    btnDelete.layer.cornerRadius = CORNER_RADIUS_BUTTON*3;
    btnDelete.clipsToBounds = YES;

//    [self customIconView:btnColumnHorizontal withColor:COLOR_ICON];

}

-(void)customIconView:(UIView*)view withColor:(UIColor*)color{
    [view.layer setCornerRadius:view.frame.size.height/2];
    [view.layer setBorderWidth:0];
    [view.layer setBorderColor:(CGColorRef)color.CGColor];
    [view setBackgroundColor:color];
    [view.layer setMasksToBounds:YES];
}
#pragma mark button action

-(IBAction) actionSave:(id)sender{
    //check valid to save

    //    if ([self checkValidToSave]) {
    DTOWidgetObject *widgetOB = [[DTOWidgetObject alloc] init];
    widgetOB.confId = _widgetOB.confId;
    widgetOB.accountName = _widgetOB.accountName;
    widgetOB.typeGraphically = [NSString stringWithFormat:@"%d",_typeGraph];
    widgetOB.colorDisplay1 = _widgetOB.colorDisplay1;
    widgetOB.createDate= [[NSDate date] description];
    widgetOB.isShowData = @"0";
    widgetOB.colorDisplay2 = _widgetOB.colorDisplay2;
    widgetOB.widgetId = _widgetOB.widgetId;
    widgetOB.widgetName = _widgetOB.widgetName;
    widgetOB.widgetType = _widgetOB.widgetType;
    widgetOB.status = _widgetOB.status;
    [configurationView setHidden:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(MainViewCell:updateWidgetObject:)]) {
        [self.delegate MainViewCell:self updateWidgetObject:widgetOB];
    }
}

-(IBAction)actionCancel:(id)sender{
    [configurationView setHidden:YES];
}

-(void)setWidgetSelectedWithTypeGraph:(TypeGraphs)typeGraph{
    if (typeGraph == typeGraphLine)
    {
        [btnLine setBackgroundImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

        [btnColumnVertical setBackgroundImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        [btnColumnHorizontal setBackgroundImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    }
    else if (typeGraph == typeGraphColumnVertical)
    {
        [btnColumnVertical setBackgroundImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

        [btnLine setBackgroundImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        [btnColumnHorizontal setBackgroundImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];

    }
    else if (typeGraph == typeGraphColumnHorizontal)
    {
        [btnColumnHorizontal setBackgroundImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

        [btnColumnVertical setBackgroundImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        [btnLine setBackgroundImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)actionWidgetLineSelected:(id)sender {
    _typeGraph = typeGraphLine;
    [self setWidgetSelectedWithTypeGraph:_typeGraph];
}
- (IBAction)actionWidgetColumnVerticalSelected:(id)sender {
    _typeGraph = typeGraphColumnVertical;
    [self setWidgetSelectedWithTypeGraph:_typeGraph];
}
- (IBAction)actionWidgetColumnHorizontalSelected:(id)sender {
    _typeGraph = typeGraphColumnHorizontal;
    [self setWidgetSelectedWithTypeGraph:_typeGraph];
}

-(IBAction)deleteAction:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteWidgetObject:)]) {
        [self.delegate deleteWidgetObject:_widgetOB];
    }
}

-(IBAction)btnConfigurationTapped:(id)sender{
    [configurationView setHidden:NO];
}



-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB{
    [self initView];
    _widgetOB = widgetOB;
    [titleGraph setText:_widgetOB.widgetName];

    self.contentView.layer.cornerRadius = CORNER_RADIUS_VIEW;
    self.contentView.clipsToBounds = YES;
    _typeGraph = [widgetOB.typeGraphically intValue];
    [self setWidgetSelectedWithTypeGraph:_typeGraph];

    [self setWidgetSelectedWithTypeGraph:_typeGraph];
   [contentChartView setHidden:NO];
    [contentChartView loadChartViewWithWidgetObject:widgetOB];
}

@end
