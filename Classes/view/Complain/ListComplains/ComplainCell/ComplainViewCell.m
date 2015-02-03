//
//  ComplainViewCell.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "ComplainViewCell.h"

#import "DTOComplainObject.h"

@implementation ComplainViewCell

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


#pragma mark load data
-(void)loadDataCellWithComplainOB:(DTOComplainObject*)complainOB{
    [lblMaKhieuNai setText:complainOB.casesId];
    [lblNoiDungKhieuNai setText:complainOB.content];
    [lblLiDo setText:complainOB.reason];
    [lblNoiDungXuLy setText:complainOB.result];
    [lblNguoiNhan setText:complainOB.receiverId];
    [lblNgayNhan setText:complainOB.receivedDate];
    [lblNguoiXuLy setText:complainOB.processerId];
    [lblNgayXuLy setText:complainOB.processedDate];
    [imgLine setAlpha:1.0];
}

@end
