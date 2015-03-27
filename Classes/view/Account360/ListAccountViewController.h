//
//  ListAccountViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/4/14.
//
//

#import "BaseViewController.h"
#import "EditAccount360ViewController.h"
#import "EditBussiness360ViewController.h"
#import "SelectIndexViewController.h"
#import "DetailLeadViewController.h"
#import "Account360Cell.h"
#import "Detail360ViewController.h"
#import "Follow360ViewController.h"

#import "SearchAdvanceLeadViewController.h"

#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "FlowLeadViewController.h"

#import "TestMapViewController.h"

@interface ListAccountViewController : BaseViewController<SelectIndexDelegate, UISearchBarDelegate, UISearchDisplayDelegate, Account360CellDelegate,UITabBarControllerDelegate,UITabBarDelegate,UIActionSheetDelegate>

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

@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

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
