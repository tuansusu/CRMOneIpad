//
//  EditCalendarLeadViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "BaseViewController.h"
#import "AMRatingControl.h"
#import "SelectIndexViewController.h"
#import "CalendarPickerViewController.h"

@interface EditCalendarLeadViewController : BaseViewController

//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;
//////////chon trol
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtTypeObject;
@property (weak, nonatomic) IBOutlet UITextField *txtNameObject;

@property (weak, nonatomic) IBOutlet UITextField *txtStatus;


@property (weak, nonatomic) IBOutlet UITextField *txtDateFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtTimeFrom;

@property (weak, nonatomic) IBOutlet UITextField *txtDateTo;

@property (weak, nonatomic) IBOutlet UITextField *txtTimeTo;

- (IBAction)actionChoiceStatus:(id)sender;

- (IBAction)actionChoiceDateFrom:(id)sender;
- (IBAction)actionChocieTimeFrom:(id)sender;
- (IBAction)actionChoiceDateTo:(id)sender;
- (IBAction)actionChoiceTimeTo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnChoiceStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceDateFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceTimeFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceDateTo;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceTimeTo;

@property (weak, nonatomic) IBOutlet UIView *viewRatingStar;



@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

@end