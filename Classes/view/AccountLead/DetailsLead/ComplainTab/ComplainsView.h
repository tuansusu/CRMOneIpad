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

@class DTOComplainObject;
@protocol ComplainsViewDelegate <NSObject>

@optional
- (void)selectedComplainOB:(DTOComplainObject*)complainOB;

@end

@interface ComplainsView : UIView<ComplainDetailViewControllerDelegate,ComplainViewCellDelegate>
{
    IBOutlet UITableView *tbvListComplains;
    IBOutlet UISearchBar *searchBarComplain;
    ComplainModel *complainModel;
    ComplainDetailViewController *complainDetailVC;

    DTOComplainObject *complainEditOB;
    NSString *_leadId;
}

@property (nonatomic,assign) id<ComplainsViewDelegate>delegate;

-(void)initDataWithLeaderId:(NSString*)leadId;

@end
