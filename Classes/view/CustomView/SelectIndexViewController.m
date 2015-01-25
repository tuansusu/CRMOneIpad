//
//  SelectIndexViewController.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/16/14.
//
//

#import "SelectIndexViewController.h"

@interface SelectIndexViewController ()
{
    int smgSelect;
}
@end

@implementation SelectIndexViewController

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
    if ([UIDevice getCurrentSysVer] >= 7.0) {
        [self.tbData setSeparatorInset:UIEdgeInsetsZero];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    
}


- (void) updateInterFaceWithOption : (int) option
{
     
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    
    //
    if (self.selectIndex>0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
        [self.tbData scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
}


#pragma mark - Table view data source

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSLog(@"cell at index = %@ - %d", [self.listData objectAtIndex:indexPath.row], indexPath.row);
    cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
    
    switch (smgSelect) {
        case 1:
        {
            cell.textLabel.textColor = TEXT_COLOR_REPORT;
        }
            break;
            
        default:
            break;
    }
    
    
    if(self.isChecked){
        if (indexPath.row == self.selectIndex) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection){
        
        [tableView deselectRowAtIndexPath:selection animated:YES];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectAtIndex:)]) {
            [self.delegate selectAtIndex:indexPath.row];
        }
        
        self.selectIndex = indexPath.row;
        
    }
    [tableView reloadData];
    
}




@end
