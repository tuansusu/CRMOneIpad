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

@protocol MainViewCellDelegate <NSObject>

@optional

- (void)deleteWidgetObject:(DTOWidgetObject*)widgetOB;
- (void)updateWidgetObject:(DTOWidgetObject*)widgetOB;

@end

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
    IBOutlet UIButton *btnDelete;
    IBOutlet UIButton *btnLine;
    IBOutlet UIButton *btnColumnVertical;
    IBOutlet UIButton *btnColumnHorizontal;
    IBOutlet UIView *widgetTypeView;

    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnCancel;
    IBOutlet UIView *configurationView;

}

@property (nonatomic,assign) id<MainViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithType:(TypeGraphs)typeGraph;

-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
