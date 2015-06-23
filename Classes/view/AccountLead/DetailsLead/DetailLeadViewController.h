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
#import "OpportunityLeadCell.h"

#import "EditCalendarLeadViewController.h"

#import "NoteLeadCell.h"
#import "EditNoteLeadViewController.h"
#import "EditAccountLeadViewController.h"
#import "EditBussinessLeadViewController.h"
#import "EditOpportunityLeadViewController.h"

#import "EmptyCell.h"

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

@interface DetailLeadViewController : BaseViewController<SelectIndexDelegate,UIAlertViewDelegate,UITabBarDelegate,UITabBarControllerDelegate,UIActionSheetDelegate,UISearchBarDelegate>

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
@property (weak, nonatomic) IBOutlet UILabel *lbLeftInfo;
@property (weak, nonatomic) IBOutlet UIView *viewHeaderLeft;

@property (weak, nonatomic) IBOutlet UIView *viewlef;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollviewCN;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollviewDN;
@property (weak, nonatomic) IBOutlet UIView *viewDetailIP;

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

@property (weak, nonatomic) IBOutlet UIButton *btnComplains;

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
@property (weak, nonatomic) IBOutlet UILabel *lbLabelThuNhapCN;
@property (weak, nonatomic) IBOutlet UILabel *lbLableTongThuNhap;
@property (weak, nonatomic) IBOutlet UILabel *lbLableKhongLienLacQua;


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
@property (weak, nonatomic) IBOutlet UILabel *lbThuNhapCN;
@property (weak, nonatomic) IBOutlet UILabel *lbTongThuNhap;
@property (weak, nonatomic) IBOutlet UILabel *lbKhongLienLacQua;


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
@property (weak, nonatomic) IBOutlet UILabel *lbLableBussinessNgayThanhLap;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessNgayThanhLap;
@property (weak, nonatomic) IBOutlet UILabel *lbLableBussinessDKKD;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessDKKD;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessVoChuSoHuu;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessVoChuSoHuu;
@property (weak, nonatomic) IBOutlet UILabel *lbLableBussinessVonDieuLe;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessVonDieuLe;
@property (weak, nonatomic) IBOutlet UILabel *lbLableBussinessTongTaiSan;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessTongTaiSan;
@property (weak, nonatomic) IBOutlet UILabel *lbLabelBussinessDoanhThu;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessDoanhThu;
@property (weak, nonatomic) IBOutlet UILabel *lbLableBussniessLoiNhuan;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessLoiNhuan;
@property (weak, nonatomic) IBOutlet UILabel *lbLableBussinessKhongLienLacQua;
@property (weak, nonatomic) IBOutlet UILabel *lbBussinessKhongLienLacQuaa;

////////KHAI BAO BIẾN THÔNG TIN KHÁCH HÀNG DOANH NGHIEP///////

@property (weak, nonatomic) IBOutlet UIButton *actionEdit;

- (IBAction)actionEdit:(id)sender;

- (IBAction)actionDel:(id)sender;

//button CN
@property (weak, nonatomic) IBOutlet UIButton *btnCallCN;
- (IBAction)actionCallCN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSMSCN;
- (IBAction)actionSMSCN:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnEmailCN;
- (IBAction)actionEmailCN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAddCN;
@property (weak, nonatomic) IBOutlet UIImageView *imgCalendar;

- (IBAction)actionAddCN:(id)sender;
//button DN
@property (weak, nonatomic) IBOutlet UIButton *btnCallDN;
- (IBAction)actionCallDN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSMSDN;
- (IBAction)actionCallDN:(id)sender;
- (IBAction)actionAddDN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDN;

- (IBAction)actionSMSDN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailDN;
- (IBAction)actionEmailDN:(id)sender;
@property (weak, nonatomic) IBOutlet UITabBar *myTabbar;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
- (IBAction)myactionAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewData;

@end
