//
//  DetailContactLeadViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/3/14.
//
//

#import "DetailContactLeadViewController.h"

@interface DetailContactLeadViewController ()
{
    DTOCONTACTProcess *dtoProcess;
    NSDictionary *dicData; //Data cua thang xem chi tiet
}
@end

@implementation DetailContactLeadViewController

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

@end
