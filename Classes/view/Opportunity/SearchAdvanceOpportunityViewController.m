//
//  SearchAdvanceOpportunityViewController.m
//  OfficeOneMB
//
//  Created by Dao Xuan Luong on 12/15/14.
//
//

#import "SearchAdvanceOpportunityViewController.h"
#import "CalendarPickerViewController.h"
#import "SelectIndexViewController.h"

#define TAG_SELECT_DATE_FROM 1 //NGAY BAT DAU
#define TAG_SELECT_DATE_TO 2 //NGAY KET THUC
#define TAG_SELECT_ACCOUNT_TYPE 3 // LOAI KHACH HANG



@interface SearchAdvanceOpportunityViewController ()
{
    ///control
    __weak IBOutlet UITextField *txtName;
    
    //khai báo biến
    int smgSelect ; //option layout
    NSUserDefaults *defaults ;
    
    //thong tin chon NGAY - THANG
    int SELECTED_DATE_TAG ;
    int SELECTED_TAG;
    NSDate *dateFrom, *dateTo;
    NSDateFormatter *df;
    
    NSInteger selectStatusIndex;
}

@end

@implementation SearchAdvanceOpportunityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    smgSelect = [[defaults objectForKey:INTERFACE_OPTION] intValue];
    [self updateInterFaceWithOption:smgSelect];
    
    df = [[NSDateFormatter alloc] init];
   	[df setDateFormat:FORMAT_DATE];
    
     selectStatusIndex = -1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateInterFaceWithOption : (int) option
{
    
    
    
    
    for (UIView *viewSubTemp in self.view.subviews) {
        
        
        if ([viewSubTemp isKindOfClass:[UILabel class]]) {
            ((UILabel*) viewSubTemp).textColor = TEXT_COLOR_REPORT_TITLE_1;
        }
        
        
        if ([viewSubTemp isKindOfClass:[UITextView class]]) {
            ((UITextView*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextView*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextView*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextView*) viewSubTemp).layer.borderWidth = BORDER_WITH;
        }
        if ([viewSubTemp isKindOfClass:[UITextField class]]) {
            ((UITextField*) viewSubTemp).textColor = TEXT_COLOR_REPORT;
            ((UITextField*) viewSubTemp).backgroundColor = BACKGROUND_NORMAL_COLOR1;
            ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
            ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
        }
        
        if ([viewSubTemp isKindOfClass:[UIButton class]]) {
            if(viewSubTemp.tag == 90 || viewSubTemp.tag == 91 || viewSubTemp.tag == 92){
                continue;
            }
            [((UIButton*) viewSubTemp) setStyleNormalWithOption:smgSelect];
        }
        
    }
    
}

- (IBAction)actionSearch:(id)sender {
    
    if (self.advanceSearchDelegate && [self.advanceSearchDelegate respondsToSelector:@selector(actionSearchAdvanceWithCode:withName:withMobile:withEmail:)]) {
//        [self.advanceSearchDelegate actionSearchAdvanceWithCode:txtCode.text withName:txtName.text withMobile:txtMobile.text withEmail:txtEmail.text];
    }
    
}

- (IBAction)actionCancel:(id)sender {
    if (self.advanceSearchDelegate && [self.advanceSearchDelegate respondsToSelector:@selector(dismissPopoverView)]) {
        [self.advanceSearchDelegate dismissPopoverView];
    }
}
-(void) dismissPopoverView
{
    if ([self.listPopover isPopoverVisible])
        [self.listPopover dismissPopoverAnimated:YES];
}


#pragma mark - Phan chon ngay thang
- (IBAction)actionChoiceDateFrom:(id)sender {
    
    if (self.txtStartDate.text.length==0) {
        dateFrom = [NSDate date];
    }else{
        dateTo = [DateUtil getDateFromString:self.txtStartDate.text :FORMAT_DATE];
    }
    
    SELECTED_DATE_TAG = TAG_SELECT_DATE_FROM;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateFrom;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnStartDate.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
- (IBAction)actionChoiceDateTo:(id)sender {
    
    if (self.txtEndDate.text.length==0) {
        dateTo = [NSDate date];
    }else{
        dateTo = [DateUtil getDateFromString:self.txtEndDate.text :FORMAT_DATE];
    }
    
    SELECTED_DATE_TAG = TAG_SELECT_DATE_TO;
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = dateTo;
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnEndDate.frame;
    
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    [self.listPopover setPopoverContentSize:CGSizeMake(320, 260) animated:NO];
    
    
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
-(void) selectDatePickerWithDate:(NSDate *)date
{
    NSLog(@"select date = %@", date);
    switch (SELECTED_DATE_TAG) {
        case TAG_SELECT_DATE_FROM:
            self.txtStartDate.text = [NSString stringWithFormat:@"%@",
                                     [df stringFromDate:date]];
            dateFrom = date;
            break;
        case TAG_SELECT_DATE_TO:
            self.txtEndDate.text = [NSString stringWithFormat:@"%@",
                                   [df stringFromDate:date]];
            dateTo = date;
            break;
            
        default:
            break;
    }
}

#pragma mark - Phần chọn loại khách hàng
- (IBAction)actionChooseAccountType:(id)sender {
    SELECTED_TAG = TAG_SELECT_ACCOUNT_TYPE;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectStatusIndex;
    
    detail.listData = [NSArray arrayWithObjects:@"Khách hàng 360", @"Khách hàng đầu mối",nil];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnChoiceAccountType.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(220,84) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    switch (SELECTED_TAG) {
        case TAG_SELECT_ACCOUNT_TYPE:
        {
            selectStatusIndex = index;
            if (index == 0) {
                self.txtAccountType.text = @"Khách hàng 360";
            }
            else if(index == 1){
                self.txtAccountType.text= @"Khách hàng đầu mối";
            }
        }
            break;
          default:
            break;
    }
    
    
    
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
