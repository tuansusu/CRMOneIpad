//
//  AccountLeadCell.h
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import <UIKit/UIKit.h>


@protocol AccountLeadCellDelegate <NSObject>

- (void) AccountLeadCellDelegate_ActionSendMailWithData : (NSDictionary*) dicData ;
- (void) AccountLeadCellDelegate_ActionViewMapWithData : (NSDictionary*) dicData ;
- (void) AccountLeadCellDelegate_ActionChangeFlowWithData : (NSDictionary*) dicData ;

@end

@interface AccountLeadCell : UITableViewCell

+(AccountLeadCell*) initNibCell;

@property (weak, nonatomic) id <AccountLeadCellDelegate> delegate;
@property (nonatomic, strong) NSDictionary *dicData;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbEmail;

@property (weak, nonatomic) IBOutlet UILabel *lbRightName;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@property (weak, nonatomic) IBOutlet UIImageView *imgIconPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMail;

@property (weak, nonatomic) IBOutlet UIButton *btnFollow;

-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

- (IBAction)actionAddress:(id)sender;
- (IBAction)actionSendMail:(id)sender;
- (IBAction)actionChangeFlow:(id)sender;

- (IBAction)actionCall:(id)sender;

@end
