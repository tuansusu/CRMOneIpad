//
//  ProductLeadViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import "ProductLeadViewCell.h"
#import "DTOProductMasterObject.h"
#import "NSDictionary+QS.h"

@implementation ProductLeadViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:Nil] objectAtIndex:0];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataCellWithProductDetail:(DTOProductDetailObject*)productDetailOB{

    [lblProductCode setText:productDetailOB.productCode];

    dtoProductMaster = [DTOPRODUCTMASTERProcess new];
    NSMutableArray *resultArr = [dtoProductMaster filterProductWithProductCode:productDetailOB.productCode];
    if (resultArr.count>0) {
        NSDictionary *productMasterDic =[resultArr objectAtIndex:0];
        DTOProductMasterObject *productMasterOB = [productMasterDic dtoProductMasterObject];
        [lblProductName setText:productMasterOB.name];
    }



    [lblContractNumber setText:productDetailOB.contractNumber];
    [lblOpenDate setText:productDetailOB.openDate];


    NSNumber *number = [NSNumber numberWithFloat:[productDetailOB.balanceQD doubleValue]];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *balanceQDStr = [formatter stringFromNumber:number];

    [lblBalanceQD setText:balanceQDStr];
    [lblCurrency setText:productDetailOB.currency];
    [lblExpiredDate setText:productDetailOB.expiredDate];
    [lblBussinessDate setText:productDetailOB.bussinessDate];

}

@end
