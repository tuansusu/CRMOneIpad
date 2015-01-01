//
//  ProductLeadViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import <UIKit/UIKit.h>
#import "DTOProductDetailObject.h"
#import "DTOPRODUCTMASTERProcess.h"

@interface ProductLeadViewCell : UITableViewCell
{
    IBOutlet UILabel *lblProductCode;
    IBOutlet UILabel *lblProductName;
    IBOutlet UILabel *lblContractNumber;
    IBOutlet UILabel *lblOpenDate;
    IBOutlet UILabel *lblBalanceQD;
    IBOutlet UILabel *lblCurrency;
    IBOutlet UILabel *lblExpiredDate;
    IBOutlet UILabel *lblBussinessDate;
    DTOPRODUCTMASTERProcess *dtoProductMaster;
}

-(void)loadDataCellWithProductDetail:(DTOProductDetailObject*)productDetailOB;

@end
