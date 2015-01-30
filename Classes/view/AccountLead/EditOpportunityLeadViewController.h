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
#import "MDSearchBarController.h"
#import "CMPopTipView.h"

@interface EditOpportunityLeadViewController : BaseViewController<UITextFieldDelegate, SelectIndexDelegate,MDSearchBarViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>


//DATA cua 360
@property (nonatomic, retain) NSDictionary *dataSend;
//data cua opportuntiy
@property (nonatomic, retain) NSDictionary *dataRoot;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UILabel *lblFormTitle;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;

@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIButton *btnNextTask;
@property (strong, nonatomic) IBOutlet UITextField *txtNextTask;
- (IBAction)actionChooseNextTask:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtLevel;
@property (strong, nonatomic) IBOutlet UIButton *btnLevel;
- (IBAction)actionChooseLevel:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *dtStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnStartDate;

@property (strong, nonatomic) IBOutlet UITextField *dtEndDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;
- (IBAction)actionStartDateSelect:(id)sender;
- (IBAction)actionEndDateSelect:(id)sender;
- (IBAction)actionSave:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtNote;



////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;

@end
