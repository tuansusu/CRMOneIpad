//
//  SearchAdvanceOpportunityViewController.h
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 12/15/14.
//
//

#import "BaseViewController.h"


@protocol SearchAdvanceDelegate <NSObject>

-(void) actionSearchAdvance :(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(int)type;
-(void) dismissPopoverView;
@end

@interface SearchAdvanceOpportunityViewController : UIViewController

@property (weak,nonatomic) id <SearchAdvanceDelegate> advanceSearchDelegate;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtAccountType;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceAccountType;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomerType;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnCance;



////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////
@end
