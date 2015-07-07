//
//  SearchAdvanceLeadViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/7/14.
//
//

#import <UIKit/UIKit.h>

@protocol SearchAdvanceDelegate <NSObject>

-(void) actionSearchAdvanceWithCode : (NSString*) strCode withName : (NSString*) strName withMobile : (NSString*) strMobile withEmail : (NSString*) strEmail  withmsthue:(NSString *)strMSthue withCMT: (NSString *) strCMT withDKKD:(NSString *)soDKKD;
-(void) dismissPopoverView;
@end

@interface SearchAdvanceLeadViewController : UIViewController<UITextFieldDelegate>

@property (weak,nonatomic) id <SearchAdvanceDelegate> advanceSearchDelegate;
@property (weak, nonatomic) IBOutlet UILabel *lbmakh;
@property (weak, nonatomic) IBOutlet UILabel *lbtenkh;
@property (weak, nonatomic) IBOutlet UILabel *lbsdt;
@property (weak, nonatomic) IBOutlet UILabel *lbmsthue;
@property (weak, nonatomic) IBOutlet UILabel *lbsocmt;
@property (weak, nonatomic) IBOutlet UILabel *lbsodk;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
//lable

@end
