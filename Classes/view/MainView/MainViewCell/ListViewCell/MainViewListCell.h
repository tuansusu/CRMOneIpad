//
//  MainViewListCell.h
//  OfficeOneMB
//
//  Created by macpro on 12/25/14.
//
//

#import <UIKit/UIKit.h>
#import "SubListMainView.h"



@interface MainViewListCell : UITableViewCell
{
    IBOutlet SubListMainView *subListMainView;
    
}

+(MainViewListCell*) initNibCell;

@end
