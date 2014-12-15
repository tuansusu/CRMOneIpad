//
//  SearchAdvanceOpportunityViewController.h
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 12/15/14.
//
//

#import "BaseViewController.h"


@protocol SearchAdvanceDelegate <NSObject>

-(void) actionSearchAdvanceWithCode : (NSString*) strCode withName : (NSString*) strName withMobile : (NSString*) strMobile withEmail : (NSString*) strEmail;
-(void) dismissPopoverView;
@end

@interface SearchAdvanceOpportunityViewController : UIViewController

@property (weak,nonatomic) id <SearchAdvanceDelegate> advanceSearchDelegate;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UITextField *txtAccountType;
@property (weak, nonatomic) IBOutlet UIButton *btnChoiceAccountType;

////////////// KHAI BAO BIEN CHUNG//////////
@property (nonatomic, retain) UIPopoverController *listPopover;
////////////// KHAI BAO BIEN CHUNG//////////

@end
