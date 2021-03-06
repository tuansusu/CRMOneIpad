//
//  EditOpportunityProductViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/25/14.
//
//

#import "BaseViewController.h"
#import "MDSearchBarController.h"
#import "SelectIndexViewController.h"
#import "CMPopTipView.h"
#import "EnumClass.h"

@protocol OpportunityProductPopupDelegate <NSObject>
@optional
-(void)receiveData:(NSDictionary *) value;
@end
@interface EditOpportunityProductPopupViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

@property (weak, nonatomic) IBOutlet UIView *viewheader;

@property (weak, nonatomic) IBOutlet UILabel *lbTite;

@property (weak, nonatomic) IBOutlet UIView *viewinfo;

@property (weak, nonatomic) IBOutlet UIView *bodyMainView;


//@property (weak, nonatomic) IBOutlet UIScrollView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewmaininfo;
@property (weak, nonatomic) IBOutlet UILabel *lblFormTitle;



@property (weak, nonatomic) IBOutlet MDSearchBar *txtSearchCustomer;

@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;

@property (weak, nonatomic) IBOutlet UITextField *txtRevenue;

@property (weak, nonatomic) IBOutlet UITextField *txtCurrency;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)actionCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;

- (IBAction)actionHome:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCurrency;

- (IBAction)actionChooseCurency:(id)sender;


//footer
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,retain) IBOutlet UILabel *barLabel;

@property (weak, nonatomic) IBOutlet UILabel *lblProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblRevenue;





@property (weak,nonatomic) id <OpportunityProductPopupDelegate> delegateOpportunityProduct;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;
@end
