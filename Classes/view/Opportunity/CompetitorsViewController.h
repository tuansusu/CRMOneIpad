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
#import "ContactOpportunityCell.h"
#import "TaskOpportunityCell.h"
#import "NoteOpportunityCell.h"
#import "TaskCalTLineCell.h"
#import "TaskCalendarCell.h"
#import "SelectIndexViewController.h"
#import "EditOpportunityViewController.h"
#import "EditContactOpportunityViewController.h"
#import "EditOpportunityProductViewController.h"
#import "EditOpportunityTaskViewController.h"
#import "EditNoteOpportunityViewController.h"
#import "EditCalendarOpportunityViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "EmptyCell.h"
#import "ComplainsView.h"
#import "TaskActionCell.h"


enum TypeActionEvent{
    type_ClueContact, //clue contact(Đầu mối liên hệ)
    type_ProposeProduct, //propose product (sản phẩm đề xuất)
    type_Sale, //san pham da ban
    type_Task, // cong viec
    type_Note, //Ghi chú
    type_Calendar // lich
};


@interface CompetitorsViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate,SelectIndexDelegate,OpportunityProductDelegate,TaskActionCellDelegate,ComplainDetailViewControllerDelegate,EditCalendarOpportunityViewControllerDelegate,ComplainsViewDelegate,UITabBarDelegate>


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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewInfo;


#pragma  mark righview button

@property (weak, nonatomic) IBOutlet UIButton *btnClueContact;

@property (weak, nonatomic) IBOutlet UIButton *btnProposeProduct;

@property (weak, nonatomic) IBOutlet UIButton *btnActionSale;
@property (weak, nonatomic) IBOutlet UIButton *btnTask;
@property (weak, nonatomic) IBOutlet UIButton *btnCalendar;
@property (weak, nonatomic) IBOutlet UIButton *btnNote;

@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
- (IBAction)actionEdit:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
- (IBAction)actionDelete:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *lblCode;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
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
@property (weak, nonatomic) IBOutlet UILabel *lblTypeDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDateRealDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblNoteDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionDetail;
@property (weak, nonatomic) IBOutlet UIView *footeView;
@property (weak, nonatomic) IBOutlet UILabel *barLabel;


- (IBAction)actionClueContact:(UIButton *)sender;

- (IBAction)actionProposeProduct:(UIButton *)sender;

- (IBAction)actionActionSale:(UIButton *)sender;
- (IBAction)actionTask:(UIButton *)sender;
- (IBAction)actionCalendar:(UIButton *)sender;
- (IBAction)actionNote:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lblTitleCode;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleName;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDateRealTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTypeTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNoteTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescriptionTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgStartDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgEndDateReal;
@property (weak, nonatomic) IBOutlet UIImageView *imgEndDate;


@property (weak, nonatomic) IBOutlet UITableView *tbData;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)actionAdd:(id)sender;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////


@property (strong, nonatomic) IBOutlet UIView *viewTableIphone;
@property (weak, nonatomic) IBOutlet UITabBar *tabBarItems;

@end
