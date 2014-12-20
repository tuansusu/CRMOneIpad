//
//  CustomerViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/17/14.
//
//

#import <UIKit/UIKit.h>

@class DTOAcountLeadProcessObject;

@protocol CustomerViewCellDelegate <NSObject>

- (void)didSelectedAtCell:(id)cell withStatus:(NSString *)status;
@end

@interface CustomerViewCell : UITableViewCell{
    IBOutlet UILabel *lblName;
    IBOutlet UIButton *btnDirection;
}
+(CustomerViewCell*) initNibCell;

-(void) loadDataToCellWithCustomerOB:(DTOAcountLeadProcessObject *)customerOB withStatus:(NSString *)status;

@property (nonatomic) id<CustomerViewCellDelegate> delegate;
@property (nonatomic,assign) BOOL isCellSelected;

@end
