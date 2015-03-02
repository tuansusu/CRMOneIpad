//
//  SearchAdvanceLeadViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/7/14.
//
//

#import <UIKit/UIKit.h>

@protocol SearchAdvanceDelegate <NSObject>

-(void) actionSearchAdvanceWithCode : (NSString*) strCode withName : (NSString*) strName withMobile : (NSString*) strMobile withEmail : (NSString*) strEmail;
-(void) dismissPopoverView;
@end

@interface SearchAdvanceLeadViewController : UIViewController

@property (weak,nonatomic) id <SearchAdvanceDelegate> advanceSearchDelegate;
@property (weak, nonatomic) IBOutlet UILabel *lbmakh;
@property (weak, nonatomic) IBOutlet UILabel *lbtenkh;
@property (weak, nonatomic) IBOutlet UILabel *lbsdt;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@end
