//
//  CustomInfoView.h
//  OfficeOneMB
//
//  Created by macpro on 12/19/14.
//
//

#import <UIKit/UIKit.h>

@interface CustomInfoView : UIView
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblAdress;
    IBOutlet UILabel *lblEmail;
    IBOutlet UILabel *lblPhone;
}

-(void) loadViewWithData:(NSDictionary *)dicData;
@end
