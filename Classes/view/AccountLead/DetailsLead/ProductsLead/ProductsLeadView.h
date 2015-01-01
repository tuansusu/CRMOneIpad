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

@interface ProductsLeadView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tbvProductsLead;
    DTOPRODUCTMASTERProcess *dtoProductMaster;
    DTOPRODUCTTYPEProcess *dtoProductType;
    DTOPRODUCTDETAILProcess *dtoProductDetail;
    NSMutableArray *_listProductsLead;
    NSMutableArray *_listTypeProduct;
    NSString *_leadId;
}

-(void)initDataWithLeaderId:(NSString*)leadId;

@end
