//
//  DirectionsHeaderView.h
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#import <UIKit/UIKit.h>

@interface DirectionsHeaderView : UIView
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UIImageView *imgIconDirection;
}

-(void)loadViewWithTittle:(NSString*)title withImage:(UIImage*)image;

@end
