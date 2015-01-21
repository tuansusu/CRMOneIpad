//
//  MainViewListCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/25/14.
//
//

#import <UIKit/UIKit.h>
#import "SubListMainView.h"

@class DTOWidgetObject;

@interface MainViewListCell : UITableViewCell
{
    IBOutlet SubListMainView *subListMainView;
    IBOutlet UILabel *lblTitle;
}

+(MainViewListCell*) initNibCell;


-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB;

@end
