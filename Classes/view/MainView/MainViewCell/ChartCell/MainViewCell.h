//
//  MainViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/23/14.
//
//

#import <UIKit/UIKit.h>

#import "MIMLineGraph.h"
#import "MIMBarGraph.h"
#import "Globals.h"
#import "ContentChartViewCell.h"

@class DTOWidgetObject;

@interface MainViewCell : UITableViewCell<LineGraphDelegate,BarGraphDelegate>
{

    IBOutlet MIMLineGraph *mLineGraph;
    IBOutlet MIMBarGraph *mBarGraph;
    IBOutlet ContentChartViewCell *contentChartView;
    
    IBOutlet UILabel *titleGraph;

    NSDictionary *barProperty;

    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
    NSArray *anchorPropertiesArray;
    NSDictionary *horizontalLinesProperties;
    NSDictionary *verticalLinesProperties;

    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;
    TypeGraphs _typeGraph;
    IBOutlet UITableView *tbvMain;
    DTOWidgetObject *_widgetOB;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithType:(TypeGraphs)typeGraph;

-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
