//
//  OpportunityCell.h
//  OfficeOneStudy
//
//  Created by ADMIN on 10/31/14.
//
//

#import <UIKit/UIKit.h>
#import "NZLabel.h"
#import "EnumClass.h"

@interface OpportunityCell : UITableViewCell

+(OpportunityCell *)getNewCell;
//@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet NZLabel *lbName;


@property (weak, nonatomic) IBOutlet UILabel *lbLevel; //tiem nang

@property (weak, nonatomic) IBOutlet UILabel *lbContact;

@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIView *viewStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (nonatomic,assign) enum DeviceType currentDeviceType;


-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;

@end
