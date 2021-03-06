//
//  MainViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/23/14.
//
//

#import <UIKit/UIKit.h>

#import "Globals.h"
#import "ContentChartViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WEPopoverController.h"
#import "ColorViewController.h"

@class DTOWidgetObject;
@class MainViewCell;

@protocol MainViewCellDelegate <NSObject>

@optional

- (void)deleteWidgetObject:(DTOWidgetObject*)widgetOB;
- (void)MainViewCell:(MainViewCell*)mainViewCell updateWidgetObject:(DTOWidgetObject*)widgetOB;

@end

@interface MainViewCell : UITableViewCell<WEPopoverControllerDelegate, UIPopoverControllerDelegate, ColorViewControllerDelegate>
{

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

    IBOutlet UIButton *btnChooseColorLeft;
    IBOutlet UIButton *btnChooseColorRight;

    IBOutlet UIView *configurationView;
    NSInteger tagChooseCollor;
    NSString *colorDisplay1;
    NSString *colorDisplay2;

    IBOutlet UILabel *lblTitleColorLeft;
    IBOutlet UILabel *lblTitleColorRight;
}

@property (nonatomic, strong) WEPopoverController *wePopoverController;

@property (nonatomic,assign) id<MainViewCellDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithType:(TypeGraphs)typeGraph;

-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
