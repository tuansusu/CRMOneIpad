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

@class DTOComplainObject;

@protocol MainViewListCellDelegate <NSObject>

@optional

- (void)deleteWidgetObject:(DTOWidgetObject*)widgetOB;

@end

@interface MainViewListCell : UITableViewCell
{
    IBOutlet SubListMainView *subListMainView;
    IBOutlet UILabel *lblTitle;
    IBOutlet UIButton *btnDelete;
    DTOWidgetObject *_widgetOB;
}

+(MainViewListCell*) initNibCell;


-(void)loadDataCellWithWidgetObject:(DTOWidgetObject*)widgetOB;
@property (nonatomic,assign) id<MainViewListCellDelegate>delegate;

@end
