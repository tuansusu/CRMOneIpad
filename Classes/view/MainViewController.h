//
//  MainViewController.h
//  VofficeIpad2
//
//  Created by Tran Van Bang on 6/19/13.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SVProgressHUD.h"
#import "FrameworkAppDelegate.h"
#import "RootViewController.h"
#import "ListEmployeeAccountViewController.h"
#import "ListOpportunityViewController.h"
#import "ProductViewController.h"
#import "ListAccountLeadViewController.h"
#import "ListAccountViewController.h"
#import "TestMapViewController.h"

///////////CHART///////
#import <QuartzCore/QuartzCore.h>
#import "BasicPieChart.h"
#import "MIMBarGraph.h"
#import "MIMLineGraph.h"
#import "MIMColor.h"
#import "AppController.h"
///////////CHART///////


#define x1 230
#define w1 20


@interface MainViewController : BaseViewController

{
    NSOperationQueue *queue;
}


//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIView *menuView;

//////////

- (IBAction)actionDashBoard:(id)sender;

- (IBAction)actionPotentialCustomer:(id)sender;

- (IBAction)actionAccount360:(id)sender;

- (IBAction)actionOpportunity:(UIButton *)sender;


//@property (weak, nonatomic) IBOutlet UIButton *actionMapView;
- (IBAction)actionMapView:(id)sender;


//////////


@property (weak, nonatomic) IBOutlet UIButton *btnHome;

@property (weak, nonatomic) IBOutlet UIView *mainView;


@property (weak, nonatomic) IBOutlet UITableView *tbData;


@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;


@end
