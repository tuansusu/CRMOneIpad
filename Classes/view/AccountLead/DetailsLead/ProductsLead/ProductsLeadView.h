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

@interface ProductsLeadView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tbvProductsLead;
    DTOPRODUCTMASTERProcess *dtoProductMaster;
    DTOPRODUCTTYPEProcess *dtoProductType;
    NSMutableArray *_listProductsLead;
    NSMutableArray *_listTypeProduct;
    NSString *_leadId;
}

-(void)initDataWithLeaderId:(NSString*)leadId;

@end
