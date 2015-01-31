//
//  HelpViewController.m
//  OfficeOneMB
//
//  Created by viettel on 1/31/15.
//
//

#import "HelpViewController.h"

@interface HelpViewController ()
{
    int smgSelect ; //option layout
    NSUserDefaults *defaults;
}
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [UIDevice updateLayoutInIOs7OrAfter:self];
    }
    
    NSURL *urlFile = [NSURL URLWithString: @"https://crm.mbbank.com.vn/help.html"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:urlFile];
    
    [self.webContent loadRequest:urlRequest];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    
}

- (void) updateInterFaceWithOption : (int) option
{
    
    self.barLabel.text = [NSString stringWithFormat:@"%@ %@, %@",VOFFICE,[defaults objectForKey:@"versionSoftware"],COPY_OF_SOFTWARE];
    
    [self.headerViewBar setBackgroundColor:HEADER_VIEW_COLOR1];
    self.fullNameLB.textColor = TEXT_COLOR_HEADER_APP;
    
    self.footerView.backgroundColor = TOOLBAR_VIEW_COLOR;
    self.barLabel.textColor = TEXT_TOOLBAR_COLOR1;
    
}


- (IBAction)homeBack:(id)sender {
    [Util backToHome:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
