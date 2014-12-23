//
//  MainViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/23/14.
//
//

#import "MainViewCell.h"

@implementation MainViewCell

+(MainViewCell*) initNibCell{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MainViewCell" owner:nil options:nil];

    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[MainViewCell class]])
        {
            return (MainViewCell *) curentObject;

        }
    }
    
    return nil;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataCellWithType:(TypeGraphs)type{
    _typeGraph = type;
    if (type == typeGraphLine) {
        [mLineGraph setHidden:NO];
        [mBarGraph setHidden:YES];
        horizontalLinesProperties=nil;
        verticalLinesProperties=nil;
        anchorPropertiesArray=nil;
        //    mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, self.frame.size.width, self.frame.size.height)];
        [mLineGraph setFrame:CGRectMake(5, 30, self.frame.size.width, self.frame.size.height)];
        mLineGraph.delegate=self;
        anchorPropertiesArray= [NSArray arrayWithObjects:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"touchenabled"],[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"touchenabled"], nil];
        //Set initial Y-Label as 0..
        mLineGraph.minimumLabelOnYIsZero=TRUE;


        //Set color for line graph
        MIMColorClass *c1=[MIMColorClass colorWithComponent:@"0,169,249"];
        mLineGraph.lineColorArray=[NSArray arrayWithObjects:c1, nil];
        
        titleGraph.text=@"line Huy động vốn";

        [mLineGraph drawMIMLineGraph];
    }else if (type == typeGraphColumn)
    {
        [mLineGraph setHidden:YES];
        [mBarGraph setHidden:NO];

        [mBarGraph setFrame:CGRectMake(50, 30, self.frame.size.width-50, self.frame.size.height)];
        mBarGraph.delegate=self;
        mBarGraph.barLabelStyle=BAR_LABEL_STYLE1;
        titleGraph.text=@"column Huy động vốn";
        mBarGraph.barcolorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithComponent:@"0,255,0,1"], nil];
        mBarGraph.mbackgroundcolor=[MIMColorClass colorWithComponent:@"0,0,0,0"];
        mBarGraph.xTitleStyle=XTitleStyle2;
        mBarGraph.gradientStyle=VERTICAL_GRADIENT_STYLE;
        mBarGraph.glossStyle=GLOSS_STYLE_2;
        [mBarGraph drawBarChart];
    }
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
        yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    }else{
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
    }else{
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
