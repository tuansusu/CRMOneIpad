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

#import "EditTaskLeadViewController.h"
#import "Task360Cell.h"
#import "Calendar360Cell.h"
#import "Opportunity360Cell.h"

#import "EditCalendar360ViewController.h"

#import "Note360Cell.h"
#import "EditNote360ViewController.h"
#import "EditAccount360ViewController.h"
#import "EditBussinessLeadViewController.h"
#import "EditOpportunity360ViewController.h"

#import "EmptyCell.h"

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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBodyLeft;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewHeaderRight;


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
@property (weak, nonatomic) IBOutlet UIButton *btnProductService;




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
//khach hang ca nhan


//khach hang doanh nghiep
@property (weak, nonatomic) IBOutlet UIScrollView *scollviewDN;

@property (weak, nonatomic) IBOutlet UILabel *codeDN;
@property (weak, nonatomic) IBOutlet UILabel *nameDN;

@property (weak, nonatomic) IBOutlet UILabel *loaiDN;
@property (weak, nonatomic) IBOutlet UILabel *soDKKD;
@property (weak, nonatomic) IBOutlet UILabel *ngaycapDKKD;
@property (weak, nonatomic) IBOutlet UILabel *dienthoaiDN;
@property (weak, nonatomic) IBOutlet UILabel *faxDN;
@property (weak, nonatomic) IBOutlet UILabel *sectorDN;
@property (weak, nonatomic) IBOutlet UILabel *loaihinhDN;
@property (weak, nonatomic) IBOutlet UILabel *chinhanhquanlyDN;
@property (weak, nonatomic) IBOutlet UILabel *ngaymocodeDN;
@property (weak, nonatomic) IBOutlet UILabel *quocgiaDN;
@property (weak, nonatomic) IBOutlet UILabel *tinhthanhphoDN;
@property (weak, nonatomic) IBOutlet UILabel *quanhuyenDN;
@property (weak, nonatomic) IBOutlet UILabel *phuongxaDN;
@property (weak, nonatomic) IBOutlet UILabel *khonglienlacDN;
@property (weak, nonatomic) IBOutlet UILabel *diachiDN;
//
@property (weak, nonatomic) IBOutlet UILabel *lbcodeDN;
@property (weak, nonatomic) IBOutlet UILabel *lbnameDN;

@property (weak, nonatomic) IBOutlet UILabel *lbloaiDN;
@property (weak, nonatomic) IBOutlet UILabel *lbsoDKKD;
@property (weak, nonatomic) IBOutlet UILabel *lbngaycapDKKD;
@property (weak, nonatomic) IBOutlet UILabel *lbdienthoaiDN;
@property (weak, nonatomic) IBOutlet UILabel *lbfaxDN;
@property (weak, nonatomic) IBOutlet UILabel *lbsectorDN;
@property (weak, nonatomic) IBOutlet UILabel *lbloaihinhDN;
@property (weak, nonatomic) IBOutlet UILabel *lbchinhanhquanlyDN;
@property (weak, nonatomic) IBOutlet UILabel *lbngaymocodeDN;
@property (weak, nonatomic) IBOutlet UILabel *lbquocgiaDN;
@property (weak, nonatomic) IBOutlet UILabel *lbtinhthanhphoDN;
@property (weak, nonatomic) IBOutlet UILabel *lbquanhuyenDN;
@property (weak, nonatomic) IBOutlet UILabel *lbphuongxaDN;
@property (weak, nonatomic) IBOutlet UILabel *lbkhonglienlacDN;
@property (weak, nonatomic) IBOutlet UILabel *lbdiachiDN;
- (IBAction)actionAddressDN:(id)sender;

//khach hang ca nhan
- (IBAction)actionCallCN:(id)sender;
- (IBAction)actionSMSCN:(id)sender;
- (IBAction)actionAddressCN:(id)sender;
- (IBAction)actionEmailCN:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *tenkhachangCN;
@property (weak, nonatomic) IBOutlet UILabel *gioitinhCN;
@property (weak, nonatomic) IBOutlet UILabel *dienthoaiCN;
@property (weak, nonatomic) IBOutlet UILabel *emailCN;
@property (weak, nonatomic) IBOutlet UILabel *diachiCN;
@property (weak, nonatomic) IBOutlet UILabel *sectorCN;
@property (weak, nonatomic) IBOutlet UILabel *nghenghiepCN;
@property (weak, nonatomic) IBOutlet UILabel *chinhanhquanlyCN;
@property (weak, nonatomic) IBOutlet UILabel *ngamocodeCN;
@property (weak, nonatomic) IBOutlet UILabel *quocgiaCN;
@property (weak, nonatomic) IBOutlet UILabel *tinhthanhphoCN;
@property (weak, nonatomic) IBOutlet UILabel *quanhuyenCN;
@property (weak, nonatomic) IBOutlet UILabel *phuongxaCN;
@property (weak, nonatomic) IBOutlet UILabel *khonglienlacCN;
@property (weak, nonatomic) IBOutlet UILabel *makhachhangCN;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSMS;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnAddCN;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDN;
@property (weak, nonatomic) IBOutlet UILabel *leftInfomenu;
@property (weak, nonatomic) IBOutlet UITabBar *myTabbar;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearch;

@end
