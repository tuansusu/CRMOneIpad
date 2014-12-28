//
//  DirectionsViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#import <UIKit/UIKit.h>
#import "UICGStep.h"
@interface DirectionsViewCell : UITableViewCell
{
    IBOutlet UILabel *lblDescription;
    IBOutlet UIImageView *iconDerections;
}

-(void)loadDataCellWithStepOB:(UICGStep*)stepOB;

@end
