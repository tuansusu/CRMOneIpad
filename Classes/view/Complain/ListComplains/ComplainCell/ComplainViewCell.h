//
//  ComplainViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import <UIKit/UIKit.h>

@class DTOComplainObject;

@protocol ComplainViewCellDelegate <NSObject>

@optional
- (void)deleteComplainAtCell:(id)cell;
- (void)changeEditAtCell:(id)cell withStatus:(NSString *)status;

@end

@interface ComplainViewCell : UITableViewCell<UIGestureRecognizerDelegate>
{
    IBOutlet UIView *contentViewCell;
    IBOutlet UILabel *lblMaKhieuNai;
    IBOutlet UILabel *lblNoiDungKhieuNai;
    IBOutlet UILabel *lblLiDo;
    IBOutlet UILabel *lblNoiDungXuLy;
    IBOutlet UILabel *lblNguoiNhan;
    IBOutlet UILabel *lblNgayNhan;
    IBOutlet UILabel *lblNguoiXuLy;
    IBOutlet UILabel *lblNgayXuLy;
    IBOutlet UIButton *_btnDelete;
}

-(void)loadDataCellWithComplainOB:(DTOComplainObject*)complainOB;
@property (nonatomic,assign) id<ComplainViewCellDelegate>delegate;

@end
