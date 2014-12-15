//
//  TestMapViewController.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/29/14.
//
//

#import <UIKit/UIKit.h>

@interface TestMapViewController : UIViewController

@property (nonatomic)  float lan;
@property (nonatomic)  float lon;
@property (nonatomic, strong)  NSString* address;


//Header
@property (weak, nonatomic) IBOutlet UIView *headerViewBar;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLB;

@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)homeBack:(id)sender;

@property (nonatomic,retain) IBOutlet UILabel *barLabel;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end
