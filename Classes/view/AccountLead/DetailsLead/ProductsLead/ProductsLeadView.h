//
//  ProductsView.h
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import <UIKit/UIKit.h>

#import "DTOPRODUCTMASTERProcess.h"
#import "DTOPRODUCTTYPEProcess.h"
#import "DTOPRODUCTDETAILProcess.h"
#import "ProTindungDetailViewController.h"
#import "ProBaoLanhDetailViewController.h"
#import "ProTaiKhoanThanhToanDetailViewController.h"
#import "ProTaiKhoanTietKiemDetailViewController.h"
#import "ProEMBDetailViewController.h"
#import "ProBankPlusDetailViewController.h"
#import "ProTheDetailViewController.h"
#import "ProThanhToanQuocTeDetailViewController.h"

@protocol ProductsLeadViewDelegate <NSObject>

@optional
- (void)selectedProductDetailAtIndex:(int)index;

@end

@interface ProductsLeadView : UIView<UITableViewDataSource,UITableViewDelegate
,ProTindungDetailViewControllerDelegate,ProBaoLanhDetailViewControllerDelegate,ProTaiKhoanThanhToanDetailViewControllerDelegate,ProTaiKhoanTietKiemDetailViewControllerDelegate,ProBankPlusDetailViewControllerDelegate,ProEMBDetailViewControllerDelegate,ProThanhToanQuocTeDetailViewControllerDelegate,ProTheDetailViewControllerDelegate>
{
    IBOutlet UITableView *tbvProductsLead;
    DTOPRODUCTMASTERProcess *dtoProductMaster;
    DTOPRODUCTTYPEProcess *dtoProductType;
    DTOPRODUCTDETAILProcess *dtoProductDetail;
    NSMutableArray *_listProductsLead;
    NSMutableArray *_listTypeProduct;
    NSString *_leadId;
    ProTindungDetailViewController *proTindungDetailVC;
    ProTaiKhoanThanhToanDetailViewController *proTaiKhoanThanhToanDetailVC;
    ProTaiKhoanTietKiemDetailViewController *proTaiKhoanTietKiemDetailVC;
    ProBaoLanhDetailViewController *proBaoLanhDetailVC;
    ProThanhToanQuocTeDetailViewController *proThanhToanQuocTeDetailVC;
    ProTheDetailViewController *proTheDetailVC;
    ProEMBDetailViewController *proEMBDetailVC;
    ProBankPlusDetailViewController *proBankPlusDetailVC;
}

-(void)initDataWithLeaderId:(NSString*)leadId;

@end
