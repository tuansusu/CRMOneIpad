//
//  TestTableViewController.m
//  OfficeOneStudy
//
//  Created by viettel on 11/12/14.
//
//

#import "TestTableViewController.h"

@interface TestTableViewController ()

@end

@implementation TestTableViewController

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

#pragma mark table

/**
 *  Hien thi dua tren DataSource la "listTableDisplayed"
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *editPermission = @"1";
    
    UITableViewCell *cell;
    
           if ([editPermission isEqualToString:@"1"]) {
            /**
             *  Neu ios 6 thi su dung accessoryType (vi kho custom them 1 button ben canh button "Xoa" nhu tren ios7)
             *  Luu y o ios6 thi dang duoc custom button "Xoa" (kich thuoc,mau sac...) trong CalCell
             */
            if ([UIDevice getCurrentSysVer] < 7.0) {
                
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                
                /**
                 * Add custom Accessory Button
                 */
                UIImage *image =[UIImage imageNamed:@"edit_calendar.png"];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                CGRect frame = CGRectMake(0.0, 0.0, 30, 30);
                button.frame = frame;
                [button setBackgroundImage:image forState:UIControlStateNormal];
                [button addTarget:self action:@selector(customButtonAccessoryTapped:)  forControlEvents:UIControlEventTouchUpInside];
                button.tag = indexPath.row;
                button.backgroundColor = [UIColor clearColor];
                cell.accessoryView = button;
                
                
//                cell.imgLineWithDetailButtom.hidden = NO;
//                cell.lblPrepareWorking.frame = CGRectMake(cell.lblPrepareWorking.frame.origin.x,cell.lblPrepareWorking.frame.origin.y ,cell.lblPrepareWorking.frame.size.width - 35 ,cell.lblPrepareWorking.frame.size.height );
            }
        }
        
    return nil;
}

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
        
        
        
//        switch (objDelTemp.level) {
//            case 0:
//                [AlertViewUtils showAlertViewWithTitle:ALERTVIEW_BUTTON_TEXT_002 message: CONFIRM_DELETE_LEVEL0_CALENDAR(objDelTemp.level0Name) delegate:self withTag:11 withTitleButtonCancel:ALERTVIEW_BUTTON_TEXT_006 withTitleButtonOther:KEY_NOTIFICATION_CANCEL];
//                break;
//            case 1:
//                [AlertViewUtils showAlertViewWithTitle:ALERTVIEW_BUTTON_TEXT_002 message: CONFIRM_DELETE_LEVEL1_CALENDAR(objDelTemp.level1Name) delegate:self withTag:11 withTitleButtonCancel:ALERTVIEW_BUTTON_TEXT_006 withTitleButtonOther:KEY_NOTIFICATION_CANCEL];
//                break;
//            case 2:
//                [AlertViewUtils showAlertViewWithTitle:ALERTVIEW_BUTTON_TEXT_002 message: CONFIRM_DELETE_LEVEL2_CALENDAR delegate:self withTag:11 withTitleButtonCancel:ALERTVIEW_BUTTON_TEXT_006 withTitleButtonOther:KEY_NOTIFICATION_CANCEL];
//                break;
//        }
    }
}

/**
 *  Xu ly khi click Button Accessory (tren ios6, xem trong cellForRow co code set AccessoryType cho cell neu khong phai la Header)
 *  TRUONG HOP NAY HIEN TAI KHONG DUNG DEN MA SU DUNG 1 CUSTOM BUTTON VOI ACTION "customButtonAccessoryTapped"
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"Xóa";
}

/**
 *  Them 1 button "Sua" ben canh button "Xoa" (tren ios7, ios6 su dung accessoryType)
 */
-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  Neu khong phai la Header thi la item level 2
     */
    return @"Sửa";
    //return nil;
}

/**
 *  Xu ly khi chon button "Sua"
 */
-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sua item at index = %d", indexPath.row);
}



#pragma mark table edit row

- (void) customButtonAccessoryTapped:(id)sender
{
    UIButton *btnSender = (UIButton *) sender;
    
    NSLog(@"btnSender = %d", btnSender.tag);
    
}



@end
