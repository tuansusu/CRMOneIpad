//
//  Calendar360Cell.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import <UIKit/UIKit.h>

@interface Calendar360Cell : UITableViewCell

+(Calendar360Cell*) initNibCell;
@property (nonatomic, strong) NSDictionary *dicData;
-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;

@end
