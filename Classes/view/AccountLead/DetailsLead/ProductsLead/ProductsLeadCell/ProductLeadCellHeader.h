//
//  ProductLeadCellHeader.h
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import <UIKit/UIKit.h>

@interface ProductLeadCellHeader : UIView{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblTotalBalanceQD;
}

-(void)loadViewWithTittle:(NSString*)title WithTotalBalanceQD:(double)totalBalanceQD;

@end
