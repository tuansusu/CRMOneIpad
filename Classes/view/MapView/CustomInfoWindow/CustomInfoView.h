//
//  CustomInfoView.h
//  OfficeOneMB
//
//  Created by macpro on 12/19/14.
//
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@class CustomInfoView;

@protocol CustomInfoViewDelegate <NSObject>

@optional
- (void)sendSMSToCustomerTel:(NSString*)tel;

@end

@class DTOAcountLeadProcessObject;
@class DTOAccountProcessObject;
@interface CustomInfoView : UIView
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblAdress;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblPhone;
    DTOAcountLeadProcessObject *_khdmOB;
    DTOAccountProcessObject *_kh360OB;
    CustomerType _customerType;
}

@property (nonatomic) IBOutlet UIButton *btnCallCustomer;

@property (nonatomic,assign) id<CustomInfoViewDelegate>delegate;

-(void) loadViewWithKHDMOB:(DTOAcountLeadProcessObject *)khdmOB;

-(void) loadViewWithKH360OB:(DTOAccountProcessObject *)kh360OB;



@end
