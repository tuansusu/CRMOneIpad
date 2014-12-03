//
//  DetailContactLeadViewController.h
//  OfficeOneMB
//
//  Created by viettel on 12/3/14.
//
//

#import "BaseViewController.h"
#import "DTOCONTACTProcess.h"

@interface DetailContactLeadViewController : BaseViewController

//DATA
/*
 * chuyen tu form danh sahc lien he(co ca clientLeaderId)
 */
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



//@property (weak, nonatomic) IBOutlet UITextField *txtName;
//@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
//@property (weak, nonatomic) IBOutlet UITextField *txtPosition;
//
//@property (weak, nonatomic) IBOutlet UITextField *txtNumberIdentity;
//@property (weak, nonatomic) IBOutlet UITextField *txtDateCreate;
//@property (weak, nonatomic) IBOutlet UITextField *txtWhereBorn;
//@property (weak, nonatomic) IBOutlet UITextField *txtDateOfBirth;
//
//@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
//
//
//
//@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
////////////controll////////
//
//@property (weak, nonatomic) IBOutlet UITextView *tvNote;


@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end
