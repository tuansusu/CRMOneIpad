//
//  ListComplainsViewController.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "ListComplainsViewController.h"

#import "ComplainViewCell.h"
#import "ComplainViewHeader.h"
#import "ComplainModel.h"

#import "ComplainDetailViewController.h"


@interface ListComplainsViewController ()<ComplainDetailViewControllerDelegate,ComplainViewCellDelegate>
{
    IBOutlet UITableView *tbvListComplains;
    IBOutlet UISearchBar *searchBarComplain;
    ComplainModel *complainModel;
    ComplainDetailViewController *complainDetailVC;

    DTOComplainObject *complainEditOB;
}

@end

@implementation ListComplainsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    complainModel = [[ComplainModel alloc] init];
    [complainModel getFirstPagePageComplainsWithKey:searchBarComplain.text WithLeadID:@""];
    [tbvListComplains reloadData];
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

#pragma mark button close view action
- (IBAction)btnAddComplainAction:(id)sender {
    complainDetailVC = [[ComplainDetailViewController alloc] init];
    complainDetailVC.delegate = self;
    [complainDetailVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    [self.view addSubview:complainDetailVC.view];
}

#pragma mark button close view action
- (IBAction)homeCloseView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ComplainViewHeader *header = [[ComplainViewHeader alloc] init];
    return header;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return complainModel.listComplains.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ComplainViewCell";
    ComplainViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ComplainViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
        DTOComplainObject *complainOB = [complainModel.listComplains objectAtIndex:indexPath.row];
        [cell loadDataCellWithComplainOB:complainOB];
    }
    return cell;
}

#pragma mark table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    complainDetailVC = [[ComplainDetailViewController alloc] init];
    complainDetailVC.delegate = self;
    [complainDetailVC.view setFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    DTOComplainObject *complainOB = [complainModel.listComplains objectAtIndex:indexPath.row];
    [complainDetailVC loadDataWithComplainOB:complainOB];
    [self.view addSubview:complainDetailVC.view];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;

    if (currentOffset - maximumOffset >= 40) {
        [complainModel getNextPageComplainsWithKey:searchBarComplain.text WithLeadID:@""];
        [tbvListComplains reloadData];
    }
}

#pragma mark edit
/**
 *  Bat Swipe right de cho phep hien thi button xoa 1 row
 *  @return YES: If you want the specified item to be editable.
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *deletePermission =@"1";
    if ([deletePermission isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

/**
 *  Delete 1 row tren TableView
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {


        complainEditOB = [complainModel.listComplains objectAtIndex:indexPath.row];

        UIAlertView *mylert = [[UIAlertView alloc] initWithTitle:SYS_Notification_Title message:SYS_Notification_DeleteConfirm delegate:self cancelButtonTitle:SYS_Notification_OKButton otherButtonTitles: SYS_Notification_CancelButton, nil];
        [mylert show];

    }
}

#pragma mark Alert Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if ([complainModel deleteComplainWithCasesId:complainEditOB.casesId]) {
            [complainModel getFirstPagePageComplainsWithKey:searchBarComplain.text WithLeadID:@""];

            [tbvListComplains reloadData];
        }
    }
}

#pragma mark CompalinDetailViewController Delegate
- (void)closeComplainDetailView:(ComplainDetailViewController*)complainDetailViewController{
    [complainDetailVC.view removeFromSuperview];
}

- (void)updateComplainDetailViewWithComplainOB:(DTOComplainObject*)complainOB
{
    if ([complainModel updateComplainWithComplainOB:complainOB]) {
        [complainDetailVC.view removeFromSuperview];
        [complainModel getFirstPagePageComplainsWithKey:searchBarComplain.text WithLeadID:@""];
        [tbvListComplains reloadData];
    }
}

#pragma mark Search Bar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [complainModel getFirstPagePageComplainsWithKey:searchText WithLeadID:@""];
    [tbvListComplains reloadData];
}

@end
