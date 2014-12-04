//
//  EditAccountLeadViewController.h
//  OfficeOneMB
//
//  Created by viettel on 11/15/14.
//
// FORM THÊM MỚI KHÁCH HÀNG ĐÂU MỐI LÀ CÁ NHÂN
//
//

#import "BaseViewController.h"
#import "SelectIndexViewController.h"



@interface EditAccountLeadViewController : BaseViewController<UITextFieldDelegate, SelectIndexDelegate>

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
@property (weak, nonatomic) IBOutlet UIView *viewExpandInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;

////////
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtCompany;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

@property (weak, nonatomic) IBOutlet UITextField *txtNumberIdentity;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPersonPosition;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segSex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segMarialStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtJob;

@property (weak, nonatomic) IBOutlet UITextField *txtMonthlyIncom;

@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtTotalassets; //tổng tài sản


@property (weak, nonatomic) IBOutlet UIButton *btnPersonalJob;
- (IBAction)actionChoicePersonalJob:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPersonalPosition;
- (IBAction)actionChoicePersonalPosition:(id)sender;

////////



@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

@end