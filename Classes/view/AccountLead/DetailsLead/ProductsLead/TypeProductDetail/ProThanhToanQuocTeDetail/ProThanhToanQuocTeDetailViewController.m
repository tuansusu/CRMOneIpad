//
//  ProThanhToanQuocTeDetailViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "ProThanhToanQuocTeDetailViewController.h"
#import "ProThanhToanQuocTeViewHeader.h"
#import "ProThanhToanQuocTeViewCell.h"

@interface ProThanhToanQuocTeDetailViewController ()
{
    IBOutlet UIView *mainView;
    IBOutlet UITableView *tbvThanhToanQuocTe;
}
@end

@implementation ProThanhToanQuocTeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mainView.layer.cornerRadius = 20;
    mainView.layer.masksToBounds = YES;
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
-(IBAction)btnCloseViewTapped:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(closeThanhToanQuocTeDetailView:)]) {
        [_delegate closeThanhToanQuocTeDetailView:self];
    }
}



#pragma mark Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProThanhToanQuocTeViewHeader *header = [[ProThanhToanQuocTeViewHeader alloc] init];
    return header;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ProThanhToanQuocTeViewCell";
    ProThanhToanQuocTeViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ProThanhToanQuocTeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}
@end
