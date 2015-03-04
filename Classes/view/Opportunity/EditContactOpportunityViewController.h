//
//  EditContactLeadViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/1/14.
//
//

#import "BaseViewController.h"
#import "CalendarPickerViewController.h"
#import "SelectPhotoViewController.h"
#import "SelectIndexViewController.h"
#import "CMPopTipView.h"



@interface EditContactOpportunityViewController : BaseViewController<UITextFieldDelegate, SelectPhotoDelegate,SelectIndexDelegate, CMPopTipViewDelegate,UITextFieldDelegate>

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

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;


@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

//@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;
@property (weak, nonatomic) IBOutlet UIScrollView *viewMainBodyInfo;


@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;
//////////chon trol

@property (weak, nonatomic) IBOutlet UIImageView *imgAvartar;

- (IBAction)actionChoicePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChoicePhoto;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtPosition;

@property (weak, nonatomic) IBOutlet UITextField *txtNumberIdentity;
@property (weak, nonatomic) IBOutlet UITextField *txtDateCreate;
@property (weak, nonatomic) IBOutlet UITextField *txtWhereBorn;
@property (weak, nonatomic) IBOutlet UITextField *txtDateOfBirth;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;



@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
//////////controll////////

@property (weak, nonatomic) IBOutlet UITextView *tvNote;

- (IBAction)actionChoiceDateCreate:(id)sender;

- (IBAction)actionChoiceDateBirthday:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateDate;

@property (weak, nonatomic) IBOutlet UIButton *btnBirthDay;


@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

//danh sách nhưng tooltip
@property (nonatomic, retain) NSMutableArray *visiblePopTipViews;
@property (nonatomic, strong) id currentPopTipViewTarget;


@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblIdentityNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblWhereBorn;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblNote;
@property (weak, nonatomic) IBOutlet UILabel *lblPositioin;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateDate;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;



@end
