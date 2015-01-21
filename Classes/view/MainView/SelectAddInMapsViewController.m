//
//  SelectAddInMapsViewController.m
//  OfficeOneMB
//
//  Created by Luong Hoang on 1/6/15.
//
//

#import "SelectAddInMapsViewController.h"



@interface SelectAddInMapsViewController ()

@end

@implementation SelectAddInMapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtSearchBar.barTintColor = [UIColor whiteColor];
    _mkMapview.showsUserLocation=YES;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
