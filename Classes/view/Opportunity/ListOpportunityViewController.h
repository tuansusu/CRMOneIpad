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

@interface ListOpportunityViewController : BaseViewController<VTCheckBoxDelegate>

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

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

@end
