//
//  ComplainsView.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import <UIKit/UIKit.h>

#import "ComplainViewCell.h"
#import "ComplainViewHeader.h"
#import "ComplainModel.h"

#import "ComplainDetailViewController.h"

@interface ComplainsView : UIView<ComplainDetailViewControllerDelegate,ComplainViewCellDelegate>
{
    IBOutlet UITableView *tbvListComplains;
    IBOutlet UISearchBar *searchBarComplain;
    ComplainModel *complainModel;
    ComplainDetailViewController *complainDetailVC;

    DTOComplainObject *complainEditOB;
    NSString *_leadId;
}

-(void)initDataWithLeaderId:(NSString*)leadId;

@end
