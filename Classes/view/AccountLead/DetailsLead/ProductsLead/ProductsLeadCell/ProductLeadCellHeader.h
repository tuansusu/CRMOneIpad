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
}

-(void)loadViewWithTittle:(NSString*)title;

@end
