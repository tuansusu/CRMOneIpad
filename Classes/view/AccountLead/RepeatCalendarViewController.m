//
//  RepeatCalendarViewController.m
//  OfficeOneMB
//
//  Created by Duy Pham on 4/1/15.
//
//

#import "RepeatCalendarViewController.h"
#import <EventKit/EventKit.h>

#import "CalendarPickerViewController.h"

@interface RepeatCalendarViewController ()
<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UISegmentedControl * _onOffSwitch;
    __weak IBOutlet UITextField * _endDateTF;
    __weak IBOutlet UIButton    * _endDateDDBtn;
    __weak IBOutlet UITextField * _endHourTF;
    __weak IBOutlet UIButton    * _endHourDDBtn;

    __weak IBOutlet UITextField * _repeatFreqTF;
    __weak IBOutlet UIButton    * _repeatFreqDDBtn;
    __weak IBOutlet UITextField * _repeatIntervalTF;
    __weak IBOutlet UIButton    * _repeatIntervalDDBtn;

    // for                      Monthly
    __weak IBOutlet UIView * _mOptionView;
    __weak IBOutlet UITextField * _mWeekDayTF;
    __weak IBOutlet UIButton    * _mWeekDayDDBtn;
    __weak IBOutlet UITextField * _mFirstOrLastTF;
    __weak IBOutlet UIButton    * _mFirstOrLastDDBtn;
    __weak IBOutlet UITextField * _mDateTF;
    __weak IBOutlet UIButton    * _mDateDDBtn;

    // for                      Weekly
    __weak IBOutlet UIView * _wOptionView;
    __weak IBOutlet UITextField * _wWeekDaysTF;
    __weak IBOutlet UIButton    * _wWeekDaysDDBtn;
    
    
    __weak IBOutlet UIPickerView * _pickerView;
    __weak IBOutlet UITableView  * _pickTableView;
}

- (IBAction)onOffSwitchChanged:(UISegmentedControl *)sender;
- (IBAction)pickerBtnPressed:(UIButton *)sender;
- (IBAction)confirmBtnPressed:(UIButton *)sender;
- (IBAction)cancelBtnPressed:(UIButton *)sender;

- (void)cancelBtnPressed;
- (void)confirmBtnPressed;
@end

@implementation RepeatCalendarViewController
{
    NSDate * _startDateTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = self.view.frame.size;
    
    self.title = @"Lặp lại";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hủy" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chọn" style:UIBarButtonItemStyleDone target:self action:@selector(confirmBtnPressed)];
    
    _startDateTime = [NSDate date];
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


- (IBAction)onOffSwitchChanged:(UISegmentedControl *)sender
{
    
}

- (IBAction)pickerBtnPressed:(UIButton *)sender
{
//    [self hideKeyboard];
//    SELECTED_POPOVER_TAG = TAG_SELECT_DATE_FROM;
    
    // date-from date picker
    CalendarPickerViewController *detail = [[CalendarPickerViewController alloc] initWithNibName:@"CalendarPickerViewController" bundle:nil];
    detail.dateSelected = _startDateTime;
    detail.isTimeMode   = FALSE;
    detail.delegateDatePicker =(id<CalendarSelectDatePickerDelegate>) self;
    
//    [self.navigationController pushViewController:detail animated:YES];
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
//    UIPopoverController *_listPopover = [[UIPopoverController alloc] initWithContentViewController:detail];
////    _listPopover.delegate = (id<UIPopoverControllerDelegate>)self;
//    _listPopover.popoverContentSize = CGSizeMake(320, 260);
//    [_listPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)confirmBtnPressed:(UIButton *)sender
{
    
}

- (void)confirmBtnPressed
{
    
}

- (IBAction)cancelBtnPressed:(UIButton *)sender
{
    
}

- (void)cancelBtnPressed
{
    
}

@end
