//
//  ListAccountLeadViewController.h
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "BaseViewController.h"
#import "EditAccountLeadViewController.h"
#import "EditBussinessLeadViewController.h"
#import "SelectIndexViewController.h"
#import "DetailLeadViewController.h"
#import "AccountLeadCell.h"
#import "SearchAdvanceLeadViewController.h"


#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "FlowLeadViewController.h"

#import "TestMapViewController.h"

@interface ListAccountLeadViewController : BaseViewController<SelectIndexDelegate, UISearchBarDelegate, UISearchDisplayDelegate, AccountLeadCellDelegate, SearchAdvanceDelegate>

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UITextField *lbTypeCustomer;
- (IBAction)actionChoiceTypeOfCustomer:(id)sender;




- (IBAction)actionAdd:(id)sender;

- (IBAction)actionAdvanceSearch:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *leftInMainView;

@property (weak, nonatomic) IBOutlet UIView *leftViewHeader;

@property (weak, nonatomic) IBOutlet UILabel *leftLabelHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet UIView *rightInMainView;

@property (weak, nonatomic) IBOutlet UITableView *tbData;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;


////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;

////////////// KHAI BAO BIEN CHUNG//////////

@end
