//
//  CustomerCell.h
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 2/9/15.
//
//

#import <UIKit/UIKit.h>

@interface CustomerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;
+(CustomerCell*) initNibCell;

@end
