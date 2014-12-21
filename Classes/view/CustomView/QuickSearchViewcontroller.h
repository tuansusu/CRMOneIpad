//
//  QuickSearchViewcontroller.h
//  OfficeOneMB
//
//  Created by viettel on 12/20/14.
//
//

#import <UIKit/UIKit.h>

@protocol SelectIdDelegate <NSObject>
@optional
-(void) selectAtIndex : (NSInteger) index;
@end


@interface QuickSearchViewcontroller : UITableViewController 
@property (strong, nonatomic) IBOutlet UITableView *tbData;
@property (nonatomic, retain) NSMutableArray *listData;
@property (weak,nonatomic) id <SelectIdDelegate> delegate;
@property (nonatomic) NSInteger selectId;
@end
