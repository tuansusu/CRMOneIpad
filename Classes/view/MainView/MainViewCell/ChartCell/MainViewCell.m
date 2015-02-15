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
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateWidgetObject:)]) {
        [self.delegate updateWidgetObject:widgetOB];
    }
}

-(IBAction)actionCancel:(id)sender{
    [configurationView setHidden:YES];
}

-(void)setWidgetSelectedWithTypeGraph:(TypeGraphs)typeGraph{
    if (typeGraph == typeGraphLine) {
        [btnLine setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

        [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    } else if (typeGraph == typeGraphColumnVertical) {
        [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

        [btnLine setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
    } else if (typeGraph == typeGraphColumnHorizontal) {
        [btnColumnHorizontal setImage:[UIImage imageNamed:@"checkbox_ticked.png"] forState:UIControlStateNormal];

        [btnColumnVertical setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
        [btnLine setImage:[UIImage imageNamed:@"checkbox_not_ticked.png"] forState:UIControlStateNormal];
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

-(void)initLineGraph{
    horizontalLinesProperties=nil;
    verticalLinesProperties=nil;
    anchorPropertiesArray=nil;
    [mLineGraph setFrame:CGRectMake(5, 60, 764, 400)];
    mLineGraph.delegate=self;
    anchorPropertiesArray= [NSArray arrayWithObjects:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"touchenabled"],[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"touchenabled"], nil];
    //Set initial Y-Label as 0..
    mLineGraph.minimumLabelOnYIsZero=TRUE;


    //Set color for line graph
    MIMColorClass *c1=[MIMColorClass colorWithComponent:@"0,169,249"];
    mLineGraph.lineColorArray=[NSArray arrayWithObjects:c1, nil];

    [mLineGraph drawMIMLineGraph];

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
    [mLineGraph setHidden:YES];
    [mBarGraph setHidden:YES];
    [contentChartView setHidden:NO];
    [contentChartView loadChartViewWithWidgetObject:widgetOB];
}


#pragma mark - Line Graph DELEGATE METHODS

-(NSArray *)AnchorProperties:(id)graph
{
    return anchorPropertiesArray;
}


-(NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}


#pragma mark - Column Graph DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    if (_typeGraph == typeGraphLine) {

        NSArray *array1=[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
        NSArray *array2=[NSArray arrayWithObjects:@"5000",@"11000",@"20000",@"15000",@"14000",@"20000",@"19000",@"14000",@"12000",@"17000",@"18000",@"14000",nil];
        yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,nil];
    }else if (_typeGraph == typeGraphColumnVertical){
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }

    return yValuesArray;
}


-(NSArray *)valuesForXAxis:(id)graph
{
    if (_typeGraph == typeGraphLine) {
        xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                      @"Feb",
                      @"Mar",
                      @"Apr",
                      @"May",
                      @"Jun",
                      @"Jul",
                      @"Aug",
                      @"Sep",
                      @"Oct",
                      @"Nov",
                      @"Dec", nil];
    }else if (_typeGraph == typeGraphColumnVertical){
        xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                      @"Feb",
                      @"Mar",
                      @"Apr",
                      @"May",
                      @"Jun",
                      @"Jul",
                      @"Aug",
                      @"Sep",
                      @"Oct",
                      @"Nov",
                      @"Dec", nil];
    }

    return xValuesArray;
}


-(NSArray *)titlesForXAxis:(id)graph
{
    if (_typeGraph == typeGraphLine) {
        xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                      @"Feb",
                      @"Mar",
                      @"Apr",
                      @"May",
                      @"Jun",
                      @"Jul",
                      @"Aug",
                      @"Sep",
                      @"Oct",
                      @"Nov",
                      @"Dec", nil];
    }else{
        xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                      @"Feb",
                      @"Mar",
                      @"Apr",
                      @"May",
                      @"Jun",
                      @"Jul",
                      @"Aug",
                      @"Sep",
                      @"Oct",
                      @"Nov",
                      @"Dec", nil];
    }
    return xTitlesArray;
}


-(NSDictionary *)animationOnBars:(id)graph
{
    if([(MIMBarGraph *)graph tag]==14)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDelay",@"animationDuration" ,nil] ];
    else if([(MIMBarGraph *)graph tag]==11)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:1.0], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDuration" ,nil] ];
    return nil;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph
{
    if (_typeGraph == typeGraphLine) {
        return horizontalLinesProperties;
    }else{
        return [NSDictionary dictionaryWithObjectsAndKeys:@"4,1",@"dotted", nil];
    }
    return nil;
}

-(NSDictionary *)xAxisProperties:(id)graph
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"0,0,0,1",@"color", nil];
}
-(NSDictionary *)yAxisProperties:(id)graph
{
    return [NSDictionary dictionaryWithObjectsAndKeys:@"0,0,0,1",@"color", nil];
}


@end
