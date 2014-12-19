//
//  CustomerViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/17/14.
//
//

#import <UIKit/UIKit.h>

@protocol CustomerViewCellDelegate <NSObject>

- (void)didSelectedAtCell:(id)cell;
@end

@interface CustomerViewCell : UITableViewCell{
    IBOutlet UILabel *lblName;
}
+(CustomerViewCell*) initNibCell;
-(void) loadDataToCellWithData:(NSDictionary *)dicData ;

@property (nonatomic) id<CustomerViewCellDelegate> delegate;

@end
