//
//  SelectPhotoViewController.m
//  OfficeOneMB
//
//  Created by viettel on 12/12/14.
//
//

#import "SelectPhotoViewController.h"

@interface SelectPhotoViewController ()
{
    NSMutableArray *arrayData;
    
    NSString *strFileName;
    NSString *nowStr;
}
@end

@implementation SelectPhotoViewController
@synthesize imageView,choosePhotoBtn, takePhotoBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	if((UIButton *) sender == choosePhotoBtn) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	
	[self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //luu file
    strFileName = [NSString stringWithFormat:@"%@_%@.jpg", self.typeImage, nowStr];    NSData* imageData = UIImageJPEGRepresentation(imageView.image, 1.0);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:strFileName];
    
    NSLog(@"image paht = %@", dbPath);
    
    [imageData writeToFile:dbPath atomically:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arrayData =[NSMutableArray new];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSFileManager* fm = [[NSFileManager alloc] init];
	NSDirectoryEnumerator* en = [fm enumeratorAtPath:path];
	NSString* file;
	while (file = [en nextObject]) {
        
		[arrayData addObject:file];
	}
    
   NSDateFormatter *df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:@"yyyyMMdd_HHmmss"];
   NSDate *now = [NSDate date];
   nowStr = [df stringFromDate:now];
    
    strFileName = @"";
    
    
    //remove footer view
    //(xoá dòng thừa không hiển thị của table)
    //self.tbData.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    
    return arrayData.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [arrayData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath* selection = [tableView indexPathForSelectedRow];
    if (selection) {
        [tableView deselectRowAtIndexPath:selection animated:YES];
    }
}


- (IBAction)actionLoadPhoto:(id)sender {
    if ([StringUtil stringIsEmpty:strFileName]) {
        //tinh
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:KEY_NOTIFICATION_TITLE message:@"Chưa chọn file đồng ý đóng?" delegate:self cancelButtonTitle:@"Thoát" otherButtonTitles:nil];
        alert.tag = 5;
        if (IS_OS_8_OR_LATER) {
            [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                [self alertView:alertView clickedButtonAtIndex:buttonIndex];
            }];
        }else{
            [alert show];
        }
        
        return;
    }
    
    //[self loadimage];
    [self.delegate selectPhoto:strFileName];
    [self.view removeFromSuperview];
}





- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(void)loadimage{
    NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"tuankk.jpg"];
    
    imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    
}


#pragma mark alertview 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag ==5) {
        
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }
}


- (IBAction)actionCancel:(id)sender {
    [self.view removeFromSuperview];
    [_delegate delegateCancel];
}
@end
