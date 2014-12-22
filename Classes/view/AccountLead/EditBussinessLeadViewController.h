//
//  EditBussinessLeadViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/16/14.
//
//

#import "BaseViewController.h"
#import "SelectIndexViewController.h"

@interface EditBussinessLeadViewController : BaseViewController<UITextFieldDelegate, SelectIndexDelegate>

//DATA
@property (nonatomic, retain) NSDictionary *dataSend;

//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;


@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;




@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *headerMainView;

@property (weak, nonatomic) IBOutlet UIView *bodyMainView;

@property (weak, nonatomic) IBOutlet UIView *viewExpandInfo;


///////////
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtTaxCode;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtRegisterCodeBussiness;
@property (weak, nonatomic) IBOutlet UITextField *txtFax;
@property (weak, nonatomic) IBOutlet UITextField *txtSysCatType;
@property (weak, nonatomic) IBOutlet UITextField *txtProfitBeforeTax;
@property (weak, nonatomic) IBOutlet UITextField *txtCapital; //vốn chủ sở hữu
@property (weak, nonatomic) IBOutlet UITextField *txtNumberShareholders; //số lượng cổ động
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtRevenue; //doanh thu
@property (weak, nonatomic) IBOutlet UITextField *txtCharterCapital; //vốn điều lệ
@property (weak, nonatomic) IBOutlet UITextField *txtNumberEmployee;
@property (weak, nonatomic) IBOutlet UITextField *txtTotalassets; //tổng tài sản
- (IBAction)actionChoiceOrgType:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOrgType;


/////////////

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)actionSave:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)actionClose:(id)sender;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;


////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

@end
