//
//  CustomerViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/17/14.
//
//

#import <UIKit/UIKit.h>

@class DTOAcountLeadProcessObject;
@class DTOAccountProcessObject;

@protocol CustomerViewCellDelegate <NSObject>

- (void)didSelectedAtCell:(id)cell withStatus:(NSString *)status;
@end

@interface CustomerViewCell : UITableViewCell{
    IBOutlet UILabel *lblName;
    IBOutlet UIButton *btnDirection;
    IBOutlet UIImageView *iconDirection;
}
+(CustomerViewCell*) initNibCell;

-(void) loadDataToCellWithKH360OB:(DTOAccountProcessObject *)kh360OB withStatus:(NSString *)status;

-(void) loadDataToCellWithKHDMOB:(DTOAcountLeadProcessObject *)khdmOB withStatus:(NSString *)status;

@property (nonatomic) id<CustomerViewCellDelegate> delegate;
@property (nonatomic,assign) BOOL isCellSelected;

@end
