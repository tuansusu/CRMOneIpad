//
//  SearchAdvanceLeadViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 12/7/14.
//
//

#import "SearchAdvanceLeadViewController.h"

@interface SearchAdvanceLeadViewController ()
{
    
    __weak IBOutlet UITextField *txtCode;
    
    __weak IBOutlet UITextField *txtName;
    
    __weak IBOutlet UITextField *txtMobile;
    
    __weak IBOutlet UITextField *txtEmail;
    
}
@end

@implementation SearchAdvanceLeadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSearch:(id)sender {
    
    if (self.advanceSearchDelegate && [self.advanceSearchDelegate respondsToSelector:@selector(advanceSearchDelegate)]) {
        [self.advanceSearchDelegate actionSearchAdvanceWithCode:txtCode.text withName:txtName.text withMobile:txtMobile.text withEmail:txtEmail.text];
    }
    
}

- (IBAction)actionCancel:(id)sender {
    
}

@end
