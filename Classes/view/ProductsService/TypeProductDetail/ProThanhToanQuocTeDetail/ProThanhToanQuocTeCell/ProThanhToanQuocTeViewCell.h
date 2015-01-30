//
//  ProThanhToanQuocTeViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/3/15.
//
//

#import <UIKit/UIKit.h>

@interface ProThanhToanQuocTeViewCell : UITableViewCell
{
    IBOutlet UILabel *lblMaGiaoDich;
    IBOutlet UILabel *lblLoaiTTQT;
    IBOutlet UILabel *lblSoNguyenTienTe;
    IBOutlet UILabel *lblTienTe;
    IBOutlet UILabel *lblSoTienQuyDoiUSD;
    IBOutlet UILabel *lblNgayGiaoDich;
    IBOutlet UILabel *lblChiNhanhPhatHanh;
}
-(void)loadDataCellWithTTQTDicData:(NSDictionary*)TTQTDicData;

@end
