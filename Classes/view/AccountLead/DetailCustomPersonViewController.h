//
//  DetailCustomPersonViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/21/14.
//
//

#import "BaseViewController.h"

@interface DetailCustomPersonViewController : UIViewController


//DATA
@property (nonatomic, retain) NSDictionary *dataSend;


///////////control/////////

@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMail;

- (IBAction)actionSendMail:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@property (weak, nonatomic) IBOutlet UIButton *btnGoToAddressMap;
- (IBAction)actionGoToMap:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lbDateOfBirth;
@property (weak, nonatomic) IBOutlet UILabel *lbIdentityNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
@property (weak, nonatomic) IBOutlet UILabel *lbMarialStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbMonthlyIncome;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalAsset;
@property (weak, nonatomic) IBOutlet UILabel *lbNoContact;



@end
