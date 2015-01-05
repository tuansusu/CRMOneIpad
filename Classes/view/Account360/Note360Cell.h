//
//  Note360Cell.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/22/14.
//
//

#import <UIKit/UIKit.h>

@interface Note360Cell : UITableViewCell

+(Note360Cell*) initNibCell;


@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *lbDescription;

@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgFile;



-(void) loadDataToCellWithData : (NSDictionary*) dicData withOption : (int) smgSelect ;
@end
