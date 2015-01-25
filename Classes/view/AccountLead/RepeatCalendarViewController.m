//
//  RepeatCalendarViewController.m
//  OfficeOneMB
//
//  Created by Duy Pham on 4/1/15.
//
//

#import "RepeatCalendarViewController.h"
//#import <EventKit/EventKit.h>

//#import "CalendarPickerViewController.h"
#import "PickerViewController.h"
#import "DateUtil.h"


#define TAG_SELECT_NONE        0
#define TAG_SELECT_END_DATE    1//NGAY KET THUC
#define TAG_SELECT_END_TIME    2//THOI GIAN KET THUC
#define TAG_SELECT_REPEAT_FREQ 3//repeatMode
#define TAG_SELECT_REPEAT_INTE 4//repeatDuration
#define TAG_SELECT_M_WEEKDAY   5//repeatWeek<Day>
#define TAG_SELECT_M_FIRSTLAST 6
#define TAG_SELECT_M_DATE      7
#define TAG_SELECT_W_DAYS      8



@interface RepeatCalendarViewController ()
<UITextFieldDelegate, PickerViewDelegate>
{
    __weak IBOutlet UISegmentedControl * _onOffSwitch;
    __weak IBOutlet UITextField * _endDateTF;
    __weak IBOutlet UIButton    * _endDateDDBtn;
    __weak IBOutlet UITextField * _endTimeTF;
    __weak IBOutlet UIButton    * _endTimeDDBtn;

    __weak IBOutlet UITextField * _repeatFreqTF;
    __weak IBOutlet UIButton    * _repeatFreqDDBtn;
    __weak IBOutlet UITextField * _repeatIntervalTF;
    __weak IBOutlet UIButton    * _repeatIntervalDDBtn;

    // for                      Monthly
    __weak IBOutlet UIView * _mOptionView;
    __weak IBOutlet UIButton    * _mWeekDayCheckBtn;
    __weak IBOutlet UILabel     * _mWeekDayCheckLB;
    __weak IBOutlet UITextField * _mWeekDayTF;
    __weak IBOutlet UIButton    * _mWeekDayDDBtn;
    __weak IBOutlet UITextField * _mFirstOrLastTF;
    __weak IBOutlet UIButton    * _mFirstOrLastDDBtn;
    __weak IBOutlet UIButton    * _mDateCheckBtn;
    __weak IBOutlet UILabel     * _mDateCheckLB;
    __weak IBOutlet UITextField * _mDateTF;
    __weak IBOutlet UIButton    * _mDateDDBtn;

    // for                      Weekly
    __weak IBOutlet UIView * _wOptionView;
    __weak IBOutlet UITextField * _wWeekDaysTF;
    __weak IBOutlet UIButton    * _wWeekDaysDDBtn;
    
    
//    __weak IBOutlet UIPickerView * _pickerView;
//    __weak IBOutlet UITableView  * _pickTableView;
}

- (IBAction)onOffSwitchChanged:(UISegmentedControl *)sender;
- (IBAction)pickerBtnPressed:(UIButton *)sender;
- (IBAction)checkBtnPressed:(UIButton *)sender;
//- (IBAction)confirmBtnPressed:(UIButton *)sender;
//- (IBAction)cancelBtnPressed:(UIButton *)sender;

- (void)cancelBtnPressed;
- (void)confirmBtnPressed;
@end

@implementation RepeatCalendarViewController
{
    int picker_Tag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = self.view.frame.size;
    
    self.title = @"Lặp lại";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hủy" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chọn" style:UIBarButtonItemStyleDone target:self action:@selector(confirmBtnPressed)];
    
    [self setConfig:nil];
}

- (void)didReceiveMemoryWarning
{
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
    if (sender == _onOffSwitch)
    {
        [self setConfigEnable:([sender selectedSegmentIndex] == 1)];
    }
    else
    {
        return;
    }
}

- (IBAction)pickerBtnPressed:(UIButton *)sender
{
    if (_config != nil)
    {
        PickerViewController * picker = [[PickerViewController alloc] init];
        picker.delegate = self;
        if (sender == _endDateDDBtn)
        {
            picker_Tag = TAG_SELECT_END_DATE;
            picker.type = OOPickerViewType_Date;
            picker.date = [_config repeatUntil];
        }
        else if (sender == _endTimeDDBtn)
        {
            picker_Tag = TAG_SELECT_END_TIME;
            picker.type = OOPickerViewType_Time;
            picker.date = [_config repeatUntil];
        }
        else if (sender == _repeatFreqDDBtn)
        {
            picker_Tag = TAG_SELECT_REPEAT_FREQ;
            picker.type = OOPickerViewType_Select;
            picker.dataList = @[@"Ngày", @"Tuần", @"Tháng", @"Năm"];
            switch ([_config repeatMode])
            {
                case OO_RepeatMode_Day:
                    picker.selectedIndex = 0;
                    break;
                case OO_RepeatMode_Week:
                    picker.selectedIndex = 1;
                case OO_RepeatMode_Month:
                    picker.selectedIndex = 2;
                case OO_RepeatMode_Year:
                    picker.selectedIndex = 3;
                default:
                    break;
            }
        }
        else if (sender == _repeatIntervalDDBtn)
        {
            picker_Tag = TAG_SELECT_REPEAT_INTE;
            picker.type = OOPickerViewType_Number;
            picker.numberStart = 1;
            picker.numberStep  = 1;
            picker.numberCount = 14;
            picker.numberSelected = [_config repeatDuration];
        }
        else if (sender == _mWeekDayDDBtn)
        {
            picker_Tag = TAG_SELECT_M_WEEKDAY;
            picker.type = OOPickerViewType_Select;
            picker.dataList = @[@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy",@"Chủ Nhật"];
            picker.selectedIndex = [_config rpMonthDayOfWeek];
            
        }
        else if (sender == _mFirstOrLastDDBtn)
        {
            picker_Tag = TAG_SELECT_M_FIRSTLAST;
            picker.type = OOPickerViewType_Select;
            picker.dataList = @[@"Đầu Tháng",@"Cuối Tháng"];
//            picker.selectedIndex = [_config rpMonthDayOfWeek];
        }
        else if (sender == _mDateDDBtn)
        {
            picker_Tag = TAG_SELECT_M_DATE;
            picker.type = OOPickerViewType_Number;
            picker.numberStart = 1;
            picker.numberStep  = 1;
            picker.numberCount = 31;
            picker.numberSelected = [_config rpMonthIndexDay];
        }
        else if (sender == _wWeekDaysDDBtn)
        {
            picker_Tag = TAG_SELECT_M_DATE;
            picker.type = OOPickerViewType_MultiSelect;
            picker.dataList = @[@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy",@"Chủ Nhật"];
            NSMutableIndexSet * indexes = [[NSMutableIndexSet alloc] init];
            if ([_config repeatWeekMon])
            {
                [indexes addIndex:0];
            }
            if ([_config repeatWeekTue])
            {
                [indexes addIndex:1];
            }
            if ([_config repeatWeekWed])
            {
                [indexes addIndex:2];
            }
            if ([_config repeatWeekThu])
            {
                [indexes addIndex:3];
            }
            if ([_config repeatWeekFri])
            {
                [indexes addIndex:4];
            }
            if ([_config repeatWeekSat])
            {
                [indexes addIndex:5];
            }
            if ([_config repeatWeekSun])
            {
                [indexes addIndex:6];
            }
            picker.selectedIndexes = [[NSIndexSet alloc] initWithIndexSet:indexes];
        }
        else
        {
            
        }
        
        [self.navigationController pushViewController:picker animated:YES];
    }
}

- (IBAction)checkBtnPressed:(UIButton *)sender
{
    BOOL dateChecked = (sender == _mDateCheckBtn);
    BOOL weekdayChecked = (sender == _mWeekDayCheckBtn);
    
    if (dateChecked)
    {
        [_mWeekDayCheckBtn setImage:[UIImage imageNamed:@"checkbox_not_ticked"] forState:UIControlStateNormal];
        [_mDateCheckBtn setImage:[UIImage imageNamed:@"checkbox_ticked"] forState:UIControlStateNormal];
    }
    else if (weekdayChecked)
    {
        [_mWeekDayCheckBtn setImage:[UIImage imageNamed:@"checkbox_ticked"] forState:UIControlStateNormal];
        [_mDateCheckBtn setImage:[UIImage imageNamed:@"checkbox_not_ticked"] forState:UIControlStateNormal];
    }
    else
    {
        [_mWeekDayCheckBtn setImage:[UIImage imageNamed:@"checkbox_not_ticked"] forState:UIControlStateNormal];
        [_mDateCheckBtn setImage:[UIImage imageNamed:@"checkbox_not_ticked"] forState:UIControlStateNormal];
    }
    
    _mDateCheckLB.enabled = dateChecked;
    _mDateTF.enabled      = dateChecked;
    _mDateDDBtn.enabled   = dateChecked;
    
    _mWeekDayCheckLB.enabled   = weekdayChecked;
    _mWeekDayTF.enabled        = weekdayChecked;
    _mWeekDayDDBtn.enabled     = weekdayChecked;
    _mFirstOrLastTF.enabled    = weekdayChecked;
    _mFirstOrLastDDBtn.enabled = weekdayChecked;
}

//- (IBAction)confirmBtnPressed:(UIButton *)sender
//{
//    
//}

- (void)confirmBtnPressed
{
    
}

//- (IBAction)cancelBtnPressed:(UIButton *)sender
//{
//    
//}

- (void)cancelBtnPressed
{
    
}
#pragma mark -
- (void)setConfigEnable:(BOOL)configEnable
{
    [_onOffSwitch setSelectedSegmentIndex:configEnable?1:0];
    
//    _dayTF.enabled       = configEnable;
//    _dayDDBtn.enabled    = configEnable;
//    _hourTF.enabled      = configEnable;
//    _hourDDBtn.enabled   = configEnable;
//    _minuteTF.enabled    = configEnable;
//    _minuteDDBtn.enabled = configEnable;
//    
//    _emailSwitch.enabled = configEnable;
//    _smsSwitch.enabled   = configEnable;
//    _notifSwitch.enabled = configEnable;
}

- (void)setConfig:(RepeatCalendarConfig *)config
{
    if (config != nil)
    {
        _config = config;
        [self setConfigEnable:[config isRepeat]];
        if ([config isRepeat])
        {
            [self setEndDate:[config repeatUntil]];
//            [_emailSwitch setOn:[config reminderEmail]];
//            [_smsSwitch   setOn:[config reminderSMS]];
//            [_notifSwitch setOn:[config reminderNofify]];
        }
    }
    else
    {
//        _dayTF.text = @"0";
//        _hourTF.text = @"0";
//        _minuteTF.text = @"15";
//        [_emailSwitch setOn:FALSE];
//        [_smsSwitch   setOn:FALSE];
//        [_notifSwitch setOn:TRUE];
        
        [self setConfigEnable:FALSE];
    }
}

#pragma mark -
- (void)setEndDate:(NSDate *)endDate
{
    _endDateTF.text = [DateUtil formatDate:endDate :FORMAT_DATE];
    _endTimeTF.text = [DateUtil formatDate:endDate :FORMAT_TIME];
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _endDateTF)
    {
        [_endDateDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _endTimeTF)
    {
        [_endTimeDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _repeatFreqTF)
    {
        [_repeatFreqDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _repeatIntervalTF)
    {
        [_repeatIntervalDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _mWeekDayTF)
    {
        [_mWeekDayDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _mFirstOrLastTF)
    {
        [_mFirstOrLastDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _mDateTF)
    {
        [_mDateDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _wWeekDaysTF)
    {
        [_wWeekDaysDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
    }
    
    return FALSE;
}

#pragma mark - PickerViewDelegate

- (void)pickerView:(PickerViewController *)pickerView pickedDate:(NSDate *)date
{
    
}

- (void)pickerView:(PickerViewController *)pickerView pickedIndex:(NSUInteger)index
{
    
}

- (void)pickerView:(PickerViewController *)pickerView pickedIndexes:(NSIndexSet *)indexes
{
    
}

- (void)pickerView:(PickerViewController *)pickerView pickedNumber:(NSUInteger)number
{
    
}
@end
