//
//  EditOpportunityViewController.h
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 11/25/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SelectIndexViewController.h"
#import "QuickSearchViewcontroller.h"
#import "SearchViewController.h"

@interface EditOpportunityViewController : BaseViewController<UITextFieldDelegate, SelectIndexDelegate>

//DATA
@property (nonatomic, retain) NSDictionary *dataSend;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;



@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;

@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;

@property (weak, nonatomic) IBOutlet UIView *footerView;
- (IBAction)actionChooseStatus:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnStatus;
@property (strong, nonatomic) IBOutlet UITextField *txtStatus;
@property (strong, nonatomic) IBOutlet UIButton *btnNextTask;
@property (strong, nonatomic) IBOutlet UITextField *txtNextTask;
- (IBAction)actionChooseNextTask:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtLevel;
@property (strong, nonatomic) IBOutlet UIButton *btnLevel;
- (IBAction)actionChooseLevel:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *pgLevel;
@property (strong, nonatomic) IBOutlet UITextField *txtCustomer;
@property (strong, nonatomic) IBOutlet UIButton *btnCustomer;
- (IBAction)actionChooseCustomer:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dtStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnStartDate;

@property (strong, nonatomic) IBOutlet UIButton *btnStartDateClear;
@property (strong, nonatomic) IBOutlet UITextField *dtEndDate;
@property (strong, nonatomic) IBOutlet UIButton *dfEndDateClear;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;
- (IBAction)actionStartDateSelect:(id)sender;
- (IBAction)actionEndDateSelect:(id)sender;
- (IBAction)actionEndDateClear:(id)sender;
- (IBAction)actionStartDateClear:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtStartDateTime;
@property (strong, nonatomic) IBOutlet UIButton *btnStartDateTime;
- (IBAction)actionSelectStartDateTime:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtEndDateTime;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDateTime;
- (IBAction)actionSelectEndDateTime:(id)sender;
- (IBAction)actionSave:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtType;
@property (weak, nonatomic) IBOutlet UITextField *txtNote;
@property (weak, nonatomic) IBOutlet UIButton *btnType;
- (IBAction)actionChooseType:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchCustomer;




////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

@end
