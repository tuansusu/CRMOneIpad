//
//  DetailCustomBussinessViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/22/14.
//
//

#import <UIKit/UIKit.h>

@interface DetailCustomBussinessViewController : UIViewController


//DATA
@property (nonatomic, retain) NSDictionary *dataSend;

@property (weak, nonatomic) IBOutlet UILabel *lbDateOfEstablishment;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeOfCompany;
@property (weak, nonatomic) IBOutlet UILabel *lbCharter;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalAsset;

@property (weak, nonatomic) IBOutlet UILabel *lbProfitNoTax;


@property (weak, nonatomic) IBOutlet UILabel *lbRevenue;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberEmployee;
@property (weak, nonatomic) IBOutlet UILabel *lbWebsite;
@property (weak, nonatomic) IBOutlet UILabel *lbFax;
@property (weak, nonatomic) IBOutlet UILabel *lbNoContact;



@end
