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

#import "Util.h"

#import "TestMapViewController.h"

#import "MJDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"


@interface EditAccountLeadViewController : BaseViewController<UITextFieldDelegate, SelectIndexDelegate,UITableViewDataSource,UITableViewDelegate>

//DATA
@property (nonatomic, retain) NSDictionary *dataSend;
//For iPhone only
@property(strong,nonatomic) IBOutlet UIDatePicker* datePicker;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnDel;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

//@property (weak, nonatomic) IBOutlet UIView *headerMainView;
//@property (weak, nonatomic) IBOutlet UILabel *lbTextHeaderMainView;


@property (weak, nonatomic) IBOutlet UIScrollView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewMainBodyInfo;
@property (weak, nonatomic) IBOutlet UIView *viewExpandInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;

- (IBAction)actionDel:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;

////////
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtCompany;

@property (weak, nonatomic) IBOutlet UITextField *txtDateOfBirth;

- (IBAction)actionChoiceDateOfBirth:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBirthDay;

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

@property (weak, nonatomic) IBOutlet UIButton *btnAddAddress;

- (IBAction)actionAddAdress:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckMobile;

- (IBAction)actionCheckMobile:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnCheckEmail;
- (IBAction)actionCheckMail:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckSMS;

- (IBAction)actionCheckSMS:(id)sender;


//display image in ipad air
@property (weak, nonatomic) IBOutlet UILabel *lbThongtinchinh;
@property (weak, nonatomic) IBOutlet UILabel *lbtenkhachhang;

@property (weak, nonatomic) IBOutlet UILabel *lbchungminhthu;

@property (weak, nonatomic) IBOutlet UILabel *lbdidong;
@property (weak, nonatomic) IBOutlet UILabel *lbCongty;
@property (weak, nonatomic) IBOutlet UILabel *lbchucdanh;
@property (weak, nonatomic) IBOutlet UILabel *lbNgaysinh;
@property (weak, nonatomic) IBOutlet UILabel *lbthongtinkhacs;
@property (weak, nonatomic) IBOutlet UILabel *lbgioitinh;
@property (weak, nonatomic) IBOutlet UILabel *lbtinhtranghonnhan;
@property (weak, nonatomic) IBOutlet UILabel *lbnghenghiep;
@property (weak, nonatomic) IBOutlet UILabel *lbthunhap;
@property (weak, nonatomic) IBOutlet UILabel *lbdiachi;
@property (weak, nonatomic) IBOutlet UILabel *lbkhongllq;
@property (weak, nonatomic) IBOutlet UILabel *lbdienthoai;

@property (weak, nonatomic) IBOutlet UILabel *lbtongtaisan;
@end
