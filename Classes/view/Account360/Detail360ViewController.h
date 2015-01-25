//
//  Detail360ViewController.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//
#import "BaseViewController.h"
#import "DetailCustomPersonViewController.h"
#import "DetailCustomBussinessViewController.h"
#import "SelectIndexViewController.h"

#import "EditContact360ViewController.h"
#import "Contact360Cell.h"
#import "DetailContactLeadViewController.h"

#import "EditTask360ViewController.h"
#import "Task360Cell.h"
#import "Calendar360Cell.h"
#import "Opportunity360Cell.h"

#import "EditCalendar360ViewController.h"

#import "Note360Cell.h"
#import "EditNote360ViewController.h"
#import "EditAccount360ViewController.h"
#import "EditBussinessLeadViewController.h"
#import "EditOpportunity360ViewController.h"

enum Type360View{
    type360View_ExpandInfo, //Thông tin mở rộng
    type360View_Contact, //Liên hệ
    type360View_Note, //Ghi chú
    type360View_Calendar, // Lịch
    type360View_Task, // Tác vụ
    type360View_Opportunity,   //Cơ hội
    type360View_Complains, // ý kiến phản hồi
    type360View_ProductsLead // sản phẩm dịch vụ
};

@interface Detail360ViewController : BaseViewController<SelectIndexDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;

//DATA
@property (nonatomic) enum Type360View typeActionEvent;
@property (nonatomic, retain) NSDictionary *dataSend;

@property (weak, nonatomic) IBOutlet UITableView *tbData;

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewHeaderExpandInfo;


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

////////////LEFT MENU////////////
@property (weak, nonatomic) IBOutlet UILabel *lbCode;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
@property (weak, nonatomic) IBOutlet UILabel *lbMobile;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbDiaChi;
@property (weak, nonatomic) IBOutlet UILabel *lbSector;
@property (weak, nonatomic) IBOutlet UILabel *lbJob;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;
@property (weak, nonatomic) IBOutlet UILabel *ldDateOpenCode;
@property (weak, nonatomic) IBOutlet UILabel *lbQuocGia;
@property (weak, nonatomic) IBOutlet UILabel *lbThanhPho;
@property (weak, nonatomic) IBOutlet UILabel *lbQuanHuyen;
@property (weak, nonatomic) IBOutlet UILabel *lbPhuonXa;
@property (weak, nonatomic) IBOutlet UILabel *lbKhongLienLacQua;

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

@property (weak, nonatomic) IBOutlet UITableView *tbInfo360;

@property (weak, nonatomic) IBOutlet UIButton *btnCoBan;

@property (weak, nonatomic) IBOutlet UIButton *btnNangcao;


@end
