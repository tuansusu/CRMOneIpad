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
@end

@interface SearchAdvanceLeadViewController : UIViewController

@property (weak,nonatomic) id <SearchAdvanceDelegate> advanceSearchDelegate;

@end
