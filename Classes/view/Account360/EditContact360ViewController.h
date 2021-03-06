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



@interface EditContact360ViewController : BaseViewController<UITextFieldDelegate, SelectPhotoDelegate,SelectIndexDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>

//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
@property (nonatomic, retain) NSDictionary *dataSend;

/*
 * chuyen tu form KHDM
 */
@property (nonatomic, retain) NSDictionary *dataRoot;

@property (strong, nonatomic) IBOutlet UIView *view;
//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

//@property (weak, nonatomic) IBOutlet UILabel *lbTitle;


@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;

//@property (weak, nonatomic) IBOutlet UIView *headerMainView;


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

@property(weak,nonatomic)IBOutlet UIButton *btnPersonalPosition;



@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
//////////controll////////

@property (weak, nonatomic) IBOutlet UITextView *tvNote;

- (IBAction)actionChoiceDateCreate:(id)sender;

-(IBAction)actionSelectPersion:(id)sender;

- (IBAction)actionChoiceDateBirthday:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCreateDate;

@property (weak, nonatomic) IBOutlet UIButton *btnBirthDay;


@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

- (IBAction)actionSelectAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDel;
- (IBAction)actionDel:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lbFullname;

@property (weak, nonatomic) IBOutlet UILabel *lbmobile;
@property (weak, nonatomic) IBOutlet UILabel *lbpassport;
@property (weak, nonatomic) IBOutlet UILabel *lbNoiSinh;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbNote;
@property (weak, nonatomic) IBOutlet UILabel *lbPosition;
@property (weak, nonatomic) IBOutlet UILabel *lbNgayCap;
@property (weak, nonatomic) IBOutlet UILabel *lbNgaySinh;
@property (weak, nonatomic) IBOutlet UILabel *lbDiaChi;

@end
