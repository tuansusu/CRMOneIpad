//
//  ListEmployeeAccountViewController.m
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import "ListEmployeeAccountViewController.h"

@interface ListEmployeeAccountViewController ()
{
    NSArray *arrayData; //khoi tao ra 1 cai danh!
}
@end

@implementation ListEmployeeAccountViewController

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
    
    DTOEMPLOYEEACCOUNTProcess *employeeAccountProcess = [DTOEMPLOYEEACCOUNTProcess new];
    arrayData = [employeeAccountProcess getAllItems];
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

//thêm cái line đến tận left margin
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    static NSString *cellId = @"employeeAccountCell";
    EmployeeAccountCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EmployeeAccountCell" owner:nil options:nil];
    
    for(id curentObject in topLevelObjects)
    {
        if([curentObject isKindOfClass:[EmployeeAccountCell class]])
        {
            cell = (EmployeeAccountCell *) curentObject;
            break;
        }
    }
    
    [cell loadDataToCell:[arrayData objectAtIndex:indexPath.row]];
    
    return cell;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
