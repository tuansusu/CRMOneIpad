//
//  ProThanhToanQuocTeViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 1/3/15.
//
//

#import "ProThanhToanQuocTeViewCell.h"

@implementation ProThanhToanQuocTeViewCell
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
-(void)loadDataCellWithTTQTDicData:(NSDictionary*)TTQTDicData{
    [lblMaGiaoDich setText:[TTQTDicData valueForKey:@"CONTRACT_NUMBER"]];
    [lblLoaiTTQT setText:[TTQTDicData valueForKey:@"LC_TYPE"]];
    [lblSoNguyenTienTe setText:[TTQTDicData valueForKey:@"LC_AMOUNT"]];
    [lblTienTe setText:[TTQTDicData valueForKey:@"LC_CCY"]];
    [lblSoTienQuyDoiUSD setText:[TTQTDicData valueForKey:@"LC_AMOUNT_USD"]];
    [lblNgayGiaoDich setText:[TTQTDicData valueForKey:@"BUSSINESS_DATE"]];
    [lblChiNhanhPhatHanh setText:[TTQTDicData valueForKey:@"KHOI"]];

}
@end
