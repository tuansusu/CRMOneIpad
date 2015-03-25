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

#define CHOOSE_COLOR_LEFT_TAG 0
#define CHOOSE_COLOR_RIGHT_TAG 1

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

    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [btnChooseColorLeft.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];

    widgetOB.colorDisplay1 = [NSString stringWithFormat:@"%ld,%ld,%ld",(long)(red*255.0f),(long)(green*255.0f),(long)(blue*255.0f)];

    [btnChooseColorRight.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    widgetOB.colorDisplay2 = [NSString stringWithFormat:@"%ld,%ld,%ld",(long)(red*255.0f),(long)(green*255.0f),(long)(blue*255.0f)];

    widgetOB.createDate= [[NSDate date] description];
    widgetOB.isShowData = @"0";
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


    if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_HUY_DONG_VON) {
        [lblTitleColorLeft setText:TEXT_HDVBQ];
        [lblTitleColorRight setText:TEXT_HDVTD];
    }
    else if ([_widgetOB.widgetId intValue]==WIDGET_TYPE_TIN_DUNG)
    {
        [lblTitleColorLeft setText:TEXT_DNBQ];
        [lblTitleColorRight setText:TEXT_DNTD];
    }

    NSArray *leftColorRGBArr = [_widgetOB.colorDisplay1 componentsSeparatedByString:@","];
    if (leftColorRGBArr.count>0) {
        [btnChooseColorLeft setBackgroundColor:[UIColor colorWithRed:[[leftColorRGBArr objectAtIndex:0] floatValue]/255.0f green:[[leftColorRGBArr objectAtIndex:1] floatValue]/255.0f blue:[[leftColorRGBArr objectAtIndex:2] floatValue]/255.0f alpha:1.0]];
    }

    NSArray *rightColorRGBArr = [_widgetOB.colorDisplay2 componentsSeparatedByString:@","];
    if (rightColorRGBArr.count>0) {
        [btnChooseColorRight setBackgroundColor:[UIColor colorWithRed:[[rightColorRGBArr objectAtIndex:0] floatValue]/255.0f green:[[rightColorRGBArr objectAtIndex:1] floatValue]/255.0f blue:[[rightColorRGBArr objectAtIndex:2] floatValue]/255.0f alpha:1.0]];
    }
    
    self.contentView.layer.cornerRadius = CORNER_RADIUS_VIEW;
    self.contentView.clipsToBounds = YES;
    _typeGraph = [widgetOB.typeGraphically intValue];
    [self setWidgetSelectedWithTypeGraph:_typeGraph];

    [self setWidgetSelectedWithTypeGraph:_typeGraph];
   [contentChartView setHidden:NO];
    [contentChartView loadChartViewWithWidgetObject:widgetOB];
}

-(IBAction)btnChooseColorAction:(id)sender
{

    tagChooseCollor = [sender tag];
    if (!self.wePopoverController) {

        ColorViewController *contentViewController = [[ColorViewController alloc] init];
        contentViewController.delegate = self;
        [contentViewController.view setBackgroundColor:[UIColor whiteColor]];
        self.wePopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        self.wePopoverController.delegate = self;
        self.wePopoverController.passthroughViews = [NSArray arrayWithObject:self];


        if ([sender tag] == CHOOSE_COLOR_LEFT_TAG) {
            [self.wePopoverController presentPopoverFromRect:btnChooseColorLeft.frame
                                                      inView:btnChooseColorLeft
                                    permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
                                                    animated:YES];

        }
        else if ([sender tag] == CHOOSE_COLOR_RIGHT_TAG)
        {
            [self.wePopoverController presentPopoverFromRect:btnChooseColorRight.frame
                                                      inView:btnChooseColorRight
                                    permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
                                                    animated:YES];
        }

        UITableView *tableView = (UITableView *)self.superview.superview;
        tableView.scrollEnabled = NO;
    } else {
        [self.wePopoverController dismissPopoverAnimated:YES];
        self.wePopoverController = nil;
    }
}

-(void) colorPopoverControllerDidSelectColor:(NSString *)hexColor{

    if (tagChooseCollor == CHOOSE_COLOR_LEFT_TAG) {
        NSArray *colorArr =[GzColors RGBFromHex:hexColor];

       if (colorArr.count>0) {
            UIColor *color =[UIColor colorWithRed:[[colorArr objectAtIndex:0] floatValue]/255.0f green:[[colorArr objectAtIndex:1] floatValue]/255.0f blue:[[colorArr objectAtIndex:2] floatValue]/255.0f alpha:1.0];
           [btnChooseColorLeft setBackgroundColor:color];
        }
    }
    else if (tagChooseCollor == CHOOSE_COLOR_RIGHT_TAG)
    {
        NSArray *colorArr =[GzColors RGBFromHex:hexColor];

        if (colorArr.count>0) {
            UIColor *color =[UIColor colorWithRed:[[colorArr objectAtIndex:0] floatValue]/255.0f green:[[colorArr objectAtIndex:1] floatValue]/255.0f blue:[[colorArr objectAtIndex:2] floatValue]/255.0f alpha:1.0];
            [btnChooseColorRight setBackgroundColor:color];
        }
    }
    UITableView *tableView = (UITableView *)self.superview.superview;
    tableView.scrollEnabled = YES;

    [self.wePopoverController dismissPopoverAnimated:YES];
    self.wePopoverController = nil;
}

#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
    //Safe to release the popover here
    self.wePopoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
    //The popover is automatically dismissed if you click outside it, unless you return NO here
    return YES;
}

@end
