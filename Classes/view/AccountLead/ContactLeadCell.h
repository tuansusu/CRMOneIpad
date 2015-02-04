//
//  ContactLeadCell.h
//  OfficeOneMB
//
//  Created by viettel on 12/2/14.
//
//

#import <UIKit/UIKit.h>
@protocol ContactDelegate<NSObject>
-(void) delegate_sendMailContact:(NSString *)email;
-(void) delegate_callContact:(NSString *)phone;
-(void) delegate_sendSMSContact:(NSString *)phone;
@end
@interface ContactLeadCell : UITableViewCell

+(ContactLeadCell*) initNibCell;

@property (weak, nonatomic) id <ContactDelegate> delegate;
@property (nonatomic, strong) NSDictionary *dicData;
@property (weak, nonatomic) IBOutlet UIImageView *avartar;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbEmail;

@property (weak, nonatomic) IBOutlet UILabel *lbRightName;
@property (weak, nonatomic) IBOutlet UILabel *lbPosition;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@property (weak, nonatomic) IBOutlet UIImageView *imgIconPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMail;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

- (IBAction)actionAddress:(id)sender;
- (IBAction)actionSendMail:(id)sender;
- (IBAction)actionSendSMS:(id)sender;
- (IBAction)actionCall:(id)sender;


@end
