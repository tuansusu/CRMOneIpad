//
//  EmptyCell.h
//  OfficeOneMB
//
//  Created by viettel on 1/25/15.
//
//

#import <UIKit/UIKit.h>

@interface EmptyCell : UITableViewCell

+(EmptyCell*) initNibCell;

-(void) loadDataToCellWithData : (NSString*) textToDisplay withOption : (int) smgSelect ;

@end
