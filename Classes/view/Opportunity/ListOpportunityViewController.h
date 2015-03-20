//
//  ListOpportunityViewController.h
//  OfficeOneStudy
//
//  Created by ADMIN on 10/31/14.
//
//

#import "BaseViewController.h"
#import "VTRadio.h"
#import "OpportunityCell.h"
#import "CompetitorsViewController.h"
#import "EditOpportunityViewController.h"
#import "EnumClass.h"

@interface ListOpportunityViewController : BaseViewController<VTCheckBoxDelegate,UISearchBarDelegate>

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *leftInMainView;

@property (weak, nonatomic) IBOutlet UIView *leftViewHeader;

@property (weak, nonatomic) IBOutlet UILabel *leftLabelHeader;


@property (weak, nonatomic) IBOutlet UIView *viewRdCustomer360;

@property (weak, nonatomic) IBOutlet UIView *viewRdCustomerRoot;

@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet UIView *rightInMainView;

@property (weak, nonatomic) IBOutlet UITableView *tbData;
@property (strong, nonatomic) IBOutlet UITextField *dtStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnStartDateClear;
- (IBAction)startDateSelect:(id)sender;
- (IBAction)startDateClear:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtKeyword;

@property (strong, nonatomic) IBOutlet UITextField *dtEndDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDateClear;
- (IBAction)endDateSelect:(id)sender;
- (IBAction)endDateClear:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;

- (IBAction)search:(id)sender;
- (IBAction)actionAdvanceSearch:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)actionAdd:(id)sender;


//footer
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *searchbarView;



@property (nonatomic, retain) UIPopoverController *listPopover;

@end
