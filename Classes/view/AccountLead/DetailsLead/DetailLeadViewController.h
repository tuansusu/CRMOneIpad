//
//  DetailLeadViewController.h
//  OfficeOneMB
//++//  Created by ADMIN on 11/20/14.
//
//

#import "BaseViewController.h"
#import "DetailCustomPersonViewController.h"
#import "DetailCustomBussinessViewController.h"
#import "SelectIndexViewController.h"

#import "EditContactLeadViewController.h"
#import "ContactLeadCell.h"
#import "DetailContactLeadViewController.h"

#import "EditTaskLeadViewController.h"
#import "TaskActionCell.h"
#import "TaskCalendarCell.h"

#import "EditCalendarLeadViewController.h"

#import "NoteLeadCell.h"
#import "EditNoteLeadViewController.h"
#import "EditAccountLeadViewController.h"
#import "EditBussinessLeadViewController.h"

enum TypeLeaderView{
    typeLeaderView_ExpandInfo, //Thông tin mở rộng
    typeLeaderView_Contact, //Liên hệ
    typeLeaderView_Note, //Ghi chú
    typeLeaderView_Calendar, // Lịch
    typeLeaderView_Task, // Tác vụ
    typeLeaderView_Opportunity,   //Cơ hội
    typeLeaderView_Complains, // ý kiến phản hồi
    typeLeaderView_ProductsLead // sản phẩm dịch vụ
};

@interface DetailLeadViewController : BaseViewController<SelectIndexDelegate,UIAlertViewDelegate>

//DATA
@property (nonatomic, retain) NSDictionary *dataSend;

@property (nonatomic) enum TypeLeaderView typeActionEvent;

@property (weak, nonatomic) IBOutlet UITableView *tbData;


@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

- (IBAction)actionAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnTempAdd;


@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *bodyMainView;


@property (weak, nonatomic) IBOutlet UIView *viewBodyExpandInfo;

@property (weak, nonatomic) IBOutlet UIView *viewBodyMainInfo;


@property (weak, nonatomic) IBOutlet UILabel *lbDescription;


@property (weak, nonatomic) IBOutlet UIView *viewHeaderExpandInfo;


@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;



@property (weak, nonatomic) IBOutlet UIButton *btnExpandInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnNote;
@property (weak, nonatomic) IBOutlet UIButton *btnCalendar;
@property (weak, nonatomic) IBOutlet UIButton *btnTask;
@property (weak, nonatomic) IBOutlet UIButton *btnOpportunity;


- (IBAction)actionExpandInfo:(UIButton *)sender;
- (IBAction)actionNote:(UIButton *)sender;
- (IBAction)actionCalendar:(UIButton *)sender;
- (IBAction)actionTask:(UIButton *)sender;
- (IBAction)actionOpportunity:(UIButton *)sender;


////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

////////KHAI BAO BIẾN THÔNG TIN KHÁCH HÀNG CÁ NHÂN///////
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewPersonal;
////////////LEFT MENU////////////

@property (weak, nonatomic) IBOutlet UILabel *lbLabelCode;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelName;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelSector;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelAlias;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelSex;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBirthDay;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelMarialStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelAddress;

////////////VALUE///////////////
@property (weak, nonatomic) IBOutlet UILabel *lbCode;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbSector;
@property (weak, nonatomic) IBOutlet UILabel *lbAlias;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
@property (weak, nonatomic) IBOutlet UILabel *lbBirthDay;
@property (weak, nonatomic) IBOutlet UILabel *lbMarialStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
////////////LEFT MENU////////////

////////KHAI BAO BIẾN THÔNG TIN KHÁCH HÀNG CÁ NHÂN///////


////////KHAI BAO BIẾN THÔNG TIN KHÁCH HÀNG DOANH NGHIEP///////
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBussiness;

@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessCode;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessCode;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessName;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessName;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessTaxCode;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessTaxCode;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessAddress;

////////KHAI BAO BIẾN THÔNG TIN KHÁCH HÀNG DOANH NGHIEP///////

@property (weak, nonatomic) IBOutlet UIButton *actionEdit;

- (IBAction)actionEdit:(id)sender;

- (IBAction)actionDel:(id)sender;



@end
