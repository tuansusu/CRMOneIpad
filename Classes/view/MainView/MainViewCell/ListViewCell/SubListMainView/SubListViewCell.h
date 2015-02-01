//
//  SubListViewCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/26/14.
//
//

#import <UIKit/UIKit.h>

@class DTOWidgetObject;

@interface SubListViewCell : UITableViewCell
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblDescription;
    IBOutlet UILabel *lblTime;
}

+(SubListViewCell*) initNibCell;
-(void) loadDataToCellWithData:(NSDictionary *)dicData WithWidgetObject:(DTOWidgetObject*)widgetOB;


@end
