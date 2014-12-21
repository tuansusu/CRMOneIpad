//
//  CustomInfoView.h
//  OfficeOneMB
//
//  Created by macpro on 12/19/14.
//
//

#import <UIKit/UIKit.h>

@class DTOAcountLeadProcessObject;
@class DTOAccountProcessObject;
@interface CustomInfoView : UIView
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblAdress;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblPhone;
}

-(void) loadViewWithKHDMOB:(DTOAcountLeadProcessObject *)khdmOB;

-(void) loadViewWithKH360OB:(DTOAccountProcessObject *)kh360OB;

@end
