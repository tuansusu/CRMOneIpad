//
//  SelectIndexViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/16/14.
//
//

#import "BaseViewController.h"

@protocol SelectIndexDelegate <NSObject>
@optional
-(void) selectAtIndex : (NSInteger) index;
@end

@interface SelectIndexViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tbData;
@property (weak,nonatomic) id <SelectIndexDelegate> delegate;
@property (nonatomic) NSInteger selectIndex;
@property (nonatomic, retain) NSArray *listData;
@property (nonatomic) BOOL isChecked;



@end
