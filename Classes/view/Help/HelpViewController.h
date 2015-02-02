//
//  HelpViewController.h
//  OfficeOneMB
//
//  Created by viettel on 1/31/15.
//
//

#import "BaseViewController.h"

@interface HelpViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIWebView *webContent;


//
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainView;
//footer
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,retain) IBOutlet UILabel *barLabel;



@end
