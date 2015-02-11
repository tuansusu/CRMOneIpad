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
    
    //khai báo biến
    int smgSelect ; //option layout
    NSUserDefaults *defaults ;
    
    //thong tin chon NGAY - THANG
    int SELECTED_DATE_TAG ;
    int SELECTED_TAG;
    NSDate *dateFrom, *dateTo;
    NSDateFormatter *df;
    
    NSInteger selectAccountTypeIndex;
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
    
     selectAccountTypeIndex = 0;
    self.txtAccountType.text= @"Tất cả";
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
//            ((UITextField*) viewSubTemp).layer.borderColor = [BORDER_COLOR CGColor];
//            ((UITextField*) viewSubTemp).layer.borderWidth = BORDER_WITH;
            
            [((UITextField*) viewSubTemp) setPaddingLeft];
            [((UITextField*) viewSubTemp) setBorderWithOption:smgSelect];
        }
        
        if ([viewSubTemp isKindOfClass:[UIButton class]]) {
            if(viewSubTemp.tag == 90 || viewSubTemp.tag == 91 || viewSubTemp.tag == 92 || viewSubTemp.tag == 103 || viewSubTemp.tag == 104){
                continue;
            }
            [((UIButton*) viewSubTemp) setStyleNormalWithOption:smgSelect];
        }
        
    }
    
}

- (IBAction)actionSearch:(id)sender {
    
    if (self.advanceSearchDelegate && [self.advanceSearchDelegate respondsToSelector:@selector(actionSearchAdvance:addStartDate:addEndDate:userType:)]) {
        NSString *name = self.txtName.text;
        name = [StringUtil trimString:name];
        [self.advanceSearchDelegate actionSearchAdvance:name addStartDate:dateFrom addEndDate:dateTo userType:selectAccountTypeIndex];
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

- (IBAction)actionRemoveDate:(id)sender {
    //xoa ngay bat dau
    if (((UIButton*) sender).tag == 103) {
        //xoa ngay bat dau
        _txtStartDate.text = @"";
        dateFrom = nil;
    }else if (((UIButton*) sender).tag == 104){
        //xoa ngay ket thuc
        _txtEndDate.text = @"";
        dateTo = nil;
    }
    
}


- (IBAction)actionChoiceDateFrom:(id)sender {
    
    [self hiddenKeyBoard];
    
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
    
    [self hiddenKeyBoard];
    
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
    
    [self hiddenKeyBoard];
    
    SELECTED_TAG = TAG_SELECT_ACCOUNT_TYPE;
    
    SelectIndexViewController *detail = [[SelectIndexViewController alloc] initWithNibName:@"SelectIndexViewController" bundle:nil];
    
    detail.selectIndex = selectAccountTypeIndex;
    
    detail.listData = [NSArray arrayWithObjects:@"Tất cả", @"Khách hàng 360", @"Khách hàng đầu mối",nil];
    
    self.listPopover = [[UIPopoverController alloc]initWithContentViewController:detail];
    CGRect popoverFrame = self.btnChoiceAccountType.frame;
    
    detail.delegate =(id<SelectIndexDelegate>) self;
    self.listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
    [self.listPopover setPopoverContentSize:CGSizeMake(220,128) animated:NO];
    [self.listPopover presentPopoverFromRect:popoverFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

}

-(void) selectAtIndex:(NSInteger)index{
    
    if (self.listPopover) {
        [ self.listPopover dismissPopoverAnimated:YES];
    }
    switch (SELECTED_TAG) {
        case TAG_SELECT_ACCOUNT_TYPE:
        {
            selectAccountTypeIndex = index;
            if(index == 0) {
                self.txtAccountType.text = @"Tất cả";
                selectAccountTypeIndex = 0;
            }
            if (index == 1) {
                self.txtAccountType.text = @"Khách hàng 360";
                selectAccountTypeIndex = 1;
            }
            else if(index == 2){
                self.txtAccountType.text= @"Khách hàng đầu mối";
                selectAccountTypeIndex = 2;
            }
        }
            break;
          default:
            break;
    }
    
    
    
}

-(void) hiddenKeyBoard {
    
        for (UIView *subViewTemp in self.view.subviews) {
            
            if([subViewTemp isKindOfClass:[UITextField class]]){
                [(UITextField *)subViewTemp resignFirstResponder];
            }
            
            
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
