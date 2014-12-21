//
//  QuickSearchViewcontroller.m
//  OfficeOneMB
//
//  Created by viettel on 12/20/14.
//
//

#import "QuickSearchViewcontroller.h"

@interface QuickSearchViewcontroller () 

@end

@implementation QuickSearchViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    
    //
//    if (self.selectIndex>0) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
//        [self.tbData scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    
//    switch (smgSelect) {
//        case 1:
//        {
//            cell.textLabel.textColor = TEXT_COLOR_REPORT;
//        }
//            break;
//            
//        default:
//            break;
//    }
    
//    
//    if(self.isChecked){
//        if (indexPath.row == self.selectIndex) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        else
//        {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            
//        }
//    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate
//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSIndexPath* selection = [tableView indexPathForSelectedRow];
//    if (selection){
//        
//        [tableView deselectRowAtIndexPath:selection animated:YES];
//        
//        if (self.delegate && [self.delegate respondsToSelector:@selector(selectAtId:)]) {
//            NSDictionary *selected = [self.listData objectAtIndex:indexPath.row];
//            [self.delegate selectAtIndex:[selected objectForKey:@"id"]];
//        }
//        
//      //  self.selectIndex = indexPath.row;
//        
//    }
//  //  [tableView reloadData];
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"doifd");
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
