//
//  CompetitorsViewController.h
//  OfficeOneStudy
//
//  Created by viettel on 11/7/14.
//
//

#import "BaseViewController.h"
#import "CompetionorCell.h"
#import "ProposeProductCell.h"
#import "ClueContactCell.h"
#import "SelectIndexViewController.h"
#import "EditContactLeadViewController.h"


enum TypeActionEvent{
    type_ClueContact, //clue contact(Đầu mối liên hệ)
    type_ProposeProduct, //propose product (sản phẩm đề xuất)
    type_ActionSale, //action sale
    type_Competionor, // Competionor(Đối thủ cạnh tranh)
    type_Support // Support
};


@interface CompetitorsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,SelectIndexDelegate>


@property (nonatomic) enum TypeActionEvent typeActionEvent;

@property (nonatomic,retain) NSString *itemId;


//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *leftInMainView;

@property (weak, nonatomic) IBOutlet UIView *leftViewHeader;

@property (weak, nonatomic) IBOutlet UILabel *leftLabelHeader;


@property (weak, nonatomic) IBOutlet UIView *rightInMainView;
@property (weak, nonatomic) IBOutlet UIView *rightViewHeader;

#pragma  mark righview button

@property (weak, nonatomic) IBOutlet UIButton *btnClueContact;

@property (weak, nonatomic) IBOutlet UIButton *btnProposeProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnActionSale;

@property (weak, nonatomic) IBOutlet UIButton *btnCompetionor;

@property (weak, nonatomic) IBOutlet UIButton *btnSupport;


@property (strong, nonatomic) IBOutlet UILabel *lblCode;

@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UILabel *lblStatusTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblStatusDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblNextTaskTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblNextTaskDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblStartDateTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblStartDateDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblEndDateTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblEndDateDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblCustomerTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblCustomerDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblOpportunityLevelTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblOpporttunityLevelDetail;
@property (strong, nonatomic) IBOutlet UIProgressView *pgSuccessPercent;
@property (strong, nonatomic) IBOutlet UILabel *lblSuccessPercentDetail;

- (IBAction)actionClueContact:(UIButton *)sender;

- (IBAction)actionProposeProduct:(UIButton *)sender;

- (IBAction)actionActionSale:(id)sender;

- (IBAction)actionCompetionor:(id)sender;

- (IBAction)actionSupport:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tbData;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)actionAdd:(id)sender;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////



@end
