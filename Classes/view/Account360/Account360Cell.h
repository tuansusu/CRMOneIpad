//
//  AccountLeadCell.h
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import <UIKit/UIKit.h>


@protocol Account360CellDelegate <NSObject>

- (void) Account360CellDelegate_ActionSendMailWithData : (NSDictionary*) dicData ;
- (void) Account360CellDelegate_ActionViewMapWithData : (NSDictionary*) dicData ;
- (void) Account360CellDelegate_ActionChangeFlowWithData : (NSDictionary*) dicData ;

@end

@interface Account360Cell : UITableViewCell

+(Account360Cell*) initNibCell;

@property (weak, nonatomic) id <Account360CellDelegate> delegate;
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