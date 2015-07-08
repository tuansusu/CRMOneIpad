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
    RepeatCalendarConfig * _config;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = self.view.frame.size;
    
    self.title = @"Lặp lại";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Hủy" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnPressed)];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Chọn" style:UIBarButtonItemStyleDone target:self action:@selector(confirmBtnPressed)];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=HEADER_VIEW_COLOR1;
    [self setupViewForConfig];
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
        _config.isRepeat = ([sender selectedSegmentIndex] == 1);
        [self setConfigOnOff:([sender selectedSegmentIndex] == 1)];
    }
    else
    {
        return;
    }
}

- (IBAction)pickerBtnPressed:(UIButton *)sender
{
    PickerViewController * picker = [[PickerViewController alloc] init];
    picker.delegate = self;
    if (sender == _endDateDDBtn)
    {
        picker_Tag = TAG_SELECT_END_DATE;
        picker.type = OOPickerViewType_Date;
        if (_config != nil)
        {
            picker.date = [_config repeatUntil];
        }
    }
    else if (sender == _endTimeDDBtn)
    {
        picker_Tag = TAG_SELECT_END_TIME;
        picker.type = OOPickerViewType_Time;
        if (_config != nil)
        {
            picker.date = [_config repeatUntil];
        }
    }
    else if (sender == _repeatFreqDDBtn)
    {
        picker_Tag = TAG_SELECT_REPEAT_FREQ;
        picker.type = OOPickerViewType_Select;
        picker.dataList = @[@"Ngày", @"Tuần", @"Tháng", @"Năm"];
        
        if (_config != nil)
        {
            switch ([_config repeatMode])
            {
                case OO_RepeatMode_Day:
                    picker.selectedIndex = 0;
                    break;
                case OO_RepeatMode_Week:
                    picker.selectedIndex = 1;
                    break;
                case OO_RepeatMode_Month:
                    picker.selectedIndex = 2;
                    break;
                case OO_RepeatMode_Year:
                    picker.selectedIndex = 3;
                    break;
                default:
                    break;
            }
        }
    }
    else if (sender == _repeatIntervalDDBtn)
    {
        picker_Tag = TAG_SELECT_REPEAT_INTE;
        picker.type = OOPickerViewType_Number;
        picker.numberStart = 1;
        picker.numberStep  = 1;
        picker.numberCount = 14;
        if (_config != nil)
        {
            picker.numberSelected = [_config repeatDuration];
        }
    }
    else if (sender == _mWeekDayDDBtn)
    {
        picker_Tag = TAG_SELECT_M_WEEKDAY;
        picker.type = OOPickerViewType_Select;
        picker.dataList = @[@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy",@"Chủ Nhật"];
        if (_config != nil)
        {
            if ([_config rpMonthDayOfWeek] > 1)
            {
                picker.selectedIndex = [_config rpMonthDayOfWeek] - 2;
            }
            else
            {
                picker.selectedIndex = 6;//CN
            }
        }
    }
    else if (sender == _mFirstOrLastDDBtn)
    {
        picker_Tag = TAG_SELECT_M_FIRSTLAST;
        picker.type = OOPickerViewType_Select;
        picker.dataList = @[@"Đầu Tháng",@"Cuối Tháng"];
        if (_config != nil)
        {
            picker.selectedIndex = [_config rpMonthFirstDay]?0:1;
        }
    }
    else if (sender == _mDateDDBtn)
    {
        picker_Tag = TAG_SELECT_M_DATE;
        picker.type = OOPickerViewType_Number;
        picker.numberStart = 1;
        picker.numberStep  = 1;
        picker.numberCount = 31;
        if (_config != nil)
        {
            picker.numberSelected = [_config rpMonthIndexDay];
        }
    }
    else if (sender == _wWeekDaysDDBtn)
    {
        picker_Tag = TAG_SELECT_W_DAYS;
        picker.type = OOPickerViewType_MultiSelect;
        picker.dataList = @[@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy",@"Chủ Nhật"];
        NSMutableIndexSet * indexes = [[NSMutableIndexSet alloc] init];
        if (_config != nil)
        {
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
        }
        picker.selectedIndexes = indexes;
    }
    else
    {
        
    }
    
    [self.navigationController pushViewController:picker animated:YES];
}

- (IBAction)checkBtnPressed:(UIButton *)sender
{
    _config.rpMonthRdIndexDay = (sender == _mDateCheckBtn);
    
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

- (void)confirmBtnPressed
{
    if ([self validateCurrentConfigForSave] &&
        _delegate &&
        [_delegate respondsToSelector:@selector(repeatCalendarView:confirmConfig:)] &&
        [_delegate respondsToSelector:@selector(dismissPopoverView)])
    {
        [_delegate repeatCalendarView:self confirmConfig:_config];
//        [_delegate dismissPopoverView];
    }
}

- (void)cancelBtnPressed
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(dismissPopoverView)])
    {
        [_delegate dismissPopoverView];
    }
}

#pragma mark -
- (BOOL)validateCurrentConfigForSave
{
    if (_config.isRepeat && _config.repeatMode == OO_RepeatMode_Week
        && !(_config.repeatWeekMon || _config.repeatWeekTue || _config.repeatWeekWed || _config.repeatWeekThu || _config.repeatWeekFri || _config.repeatWeekSat || _config.repeatWeekSun))
    {
        // currently all defaults value are set, only if repeat week is set & non of week day is selected
        [[[UIAlertView alloc] initWithTitle:@"Thông báo"
                                    message:@"Ít nhất 1 ngày trong tuần cần được chọn cho lặp hàng tuần"
                                   delegate:nil
                          cancelButtonTitle:@"Đồng ý"
                          otherButtonTitles:nil] show];
        return false;
    }
    return true;
}
#pragma mark -
- (void)setupViewForConfig
{
    if (_config == nil)
    {
        // create _config for new
        _config = [[RepeatCalendarConfig alloc] init];
    }
    
    [self displayConfig:_config];
}

#pragma mark -
- (void)displayConfig:(RepeatCalendarConfig *)config
{
    [self setConfigOnOff:[config isRepeat]];
    [self setEndDate:[config repeatUntil]];
    [self setRepeatMode:[config repeatMode]];
    [self setRepeatInterval:[config repeatDuration]];
}

- (void)setConfigOnOff:(BOOL)configEnable
{
    _onOffSwitch.selectedSegmentIndex = configEnable?1:0;
    
    _endDateTF.enabled           = configEnable;
    _endDateDDBtn.enabled        = configEnable;
    _endTimeTF.enabled           = configEnable;
    _endTimeDDBtn.enabled        = configEnable;
    
    _repeatFreqTF.enabled        = configEnable;
    _repeatFreqDDBtn.enabled     = configEnable;
    _repeatIntervalTF.enabled    = configEnable;
    _repeatIntervalDDBtn.enabled = configEnable;
    
    //TODO: recheck flow
    BOOL _mDateEnable = _config.rpMonthRdIndexDay;
    if (_mDateEnable)
    {
        [_mWeekDayCheckBtn setImage:[UIImage imageNamed:@"checkbox_not_ticked"] forState:UIControlStateNormal];
        [_mDateCheckBtn setImage:[UIImage imageNamed:@"checkbox_ticked"] forState:UIControlStateNormal];
    }
    else
    {
        [_mWeekDayCheckBtn setImage:[UIImage imageNamed:@"checkbox_ticked"] forState:UIControlStateNormal];
        [_mDateCheckBtn setImage:[UIImage imageNamed:@"checkbox_not_ticked"] forState:UIControlStateNormal];
    }
    _mWeekDayCheckBtn.enabled    = configEnable;
    _mWeekDayCheckLB.enabled     = configEnable && !_mDateEnable;
    _mWeekDayTF.enabled          = configEnable && !_mDateEnable;
    _mWeekDayDDBtn.enabled       = configEnable && !_mDateEnable;
    _mFirstOrLastTF.enabled      = configEnable && !_mDateEnable;
    _mFirstOrLastDDBtn.enabled   = configEnable && !_mDateEnable;
    _mDateCheckBtn.enabled       = configEnable;
    _mDateCheckLB.enabled        = configEnable &&  _mDateEnable;
    _mDateTF.enabled             = configEnable &&  _mDateEnable;
    _mDateDDBtn.enabled          = configEnable &&  _mDateEnable;
    
    _wWeekDaysTF.enabled         = configEnable;
    _wWeekDaysDDBtn.enabled      = configEnable;
}

- (void)setEndDate:(NSDate *)endDate
{
    _endDateTF.text = [DateUtil formatDate:endDate :FORMAT_DATE];
    _endTimeTF.text = [DateUtil formatDate:endDate :FORMAT_TIME];
}

- (void)setRepeatMode:(OO_RepeatMode)repeatMode
{
    switch (repeatMode)
    {
        case OO_RepeatMode_Day:
        {
            _repeatFreqTF.text = @"Ngày";
            _mOptionView.hidden = true;
            _wOptionView.hidden = true;
        }
            break;
        case OO_RepeatMode_Week:
        {
            _repeatFreqTF.text = @"Tuần";
            _mOptionView.hidden = true;
            _wOptionView.hidden = false;
            
            [self setRepeatWeekConfig:_config];
        }
            break;
        case OO_RepeatMode_Month:
        {
            _repeatFreqTF.text = @"Tháng";
            _mOptionView.hidden = false;
            _wOptionView.hidden = true;
            
            [self setRepeatMonthConfig:_config];
        }
            break;
        case OO_RepeatMode_Year:
        {
            _repeatFreqTF.text = @"Năm";
            _mOptionView.hidden = true;
            _wOptionView.hidden = true;
        }
            break;
        default:
            break;
    }
}

- (void)setRepeatInterval:(NSUInteger)repeatInterval
{
    _repeatIntervalTF.text = [NSString stringWithFormat:@"%u", repeatInterval];
}

- (void)setRepeatWeekConfig:(RepeatCalendarConfig *)config
{
    NSMutableArray * repeatWeekDaysStrArr = [[NSMutableArray alloc] init];
    if ([_config repeatWeekMon])
    {
        [repeatWeekDaysStrArr addObject:@"Thứ Hai"];
    }
    if ([_config repeatWeekTue])
    {
        [repeatWeekDaysStrArr addObject:@"Thứ Ba"];
    }
    if ([_config repeatWeekWed])
    {
        [repeatWeekDaysStrArr addObject:@"Thứ Tư"];
    }
    if ([_config repeatWeekThu])
    {
        [repeatWeekDaysStrArr addObject:@"Thứ Năm"];
    }
    if ([_config repeatWeekFri])
    {
        [repeatWeekDaysStrArr addObject:@"Thứ Sáu"];
    }
    if ([_config repeatWeekSat])
    {
        [repeatWeekDaysStrArr addObject:@"Thứ Bảy"];
    }
    if ([_config repeatWeekSun])
    {
        [repeatWeekDaysStrArr addObject:@"Chủ Nhật"];
    }
    
    //    if ([repeatWeekDaysStrArr count] > 0)
    {
        _wWeekDaysTF.text = [repeatWeekDaysStrArr componentsJoinedByString:@","];
    }
}

- (void)setRepeatMonthConfig:(RepeatCalendarConfig *)config
{
    if ([config rpMonthDayOfWeek] >0 && [config rpMonthDayOfWeek] < 7)
    {
        NSArray * weekdaysList = @[@"Chủ Nhật",@"Thứ Hai",@"Thứ Ba",@"Thứ Tư",@"Thứ Năm",@"Thứ Sáu",@"Thứ Bảy"];
        _mWeekDayTF.text = [weekdaysList objectAtIndex:([config rpMonthDayOfWeek] - 1)];
        _mFirstOrLastTF.text = [config rpMonthFirstDay]?@"Đầu Tháng":@"Cuối Tháng";
    }
    
    if ([config rpMonthIndexDay] >0 && [config rpMonthIndexDay] <32)
    {
        _mDateTF.text = [NSString stringWithFormat:@"%u", [config rpMonthIndexDay]];
    }
    
    if (_config.rpMonthRdIndexDay)
    {
        [_mDateCheckBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [_mWeekDayCheckBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
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
    if (picker_Tag == TAG_SELECT_END_DATE || picker_Tag == TAG_SELECT_END_TIME)
    {
        _config.repeatUntil = date;
        [self setEndDate:date];
        picker_Tag = TAG_SELECT_NONE;
    }
    [pickerView.navigationController popViewControllerAnimated:true];
}

- (void)pickerView:(PickerViewController *)pickerView pickedIndex:(NSUInteger)index
{
    if (picker_Tag == TAG_SELECT_REPEAT_FREQ)
    {
        switch (index)
        {
            case 0:
                
                _config.repeatMode = OO_RepeatMode_Day;
                break;
            case 1:
                _config.repeatMode = OO_RepeatMode_Week;
                break;
            case 2:
                _config.repeatMode = OO_RepeatMode_Month;
                break;
            case 3:
                _config.repeatMode = OO_RepeatMode_Year;
                break;
            default:
                break;
        }
        [self setRepeatMode:[_config repeatMode]];
        
        picker_Tag = TAG_SELECT_NONE;
    }
    else if (picker_Tag == TAG_SELECT_M_WEEKDAY)
    {
        if (index < 7)
        {
            if (index == 6) //CN
            {
                _config.rpMonthDayOfWeek = 1;
            }
            else
            {
                _config.rpMonthDayOfWeek = index + 2;//0-5 t2-t7
            }
            [self setRepeatMonthConfig:_config];
        }
        picker_Tag = TAG_SELECT_NONE;
    }
    else if (picker_Tag == TAG_SELECT_M_FIRSTLAST)
    {
        if (index < 2)
        {
            _config.rpMonthFirstDay = (index == 0);
            [self setRepeatMonthConfig:_config];
        }
        picker_Tag = TAG_SELECT_NONE;
    }
    [pickerView.navigationController popViewControllerAnimated:true];
}

- (void)pickerView:(PickerViewController *)pickerView pickedIndexes:(NSIndexSet *)indexes
{
    if (picker_Tag == TAG_SELECT_W_DAYS)
    {
        if ([indexes containsIndex:0])
        {
            _config.repeatWeekMon = true;
        }
        else
        {
            _config.repeatWeekMon = false;
        }
        
        if ([indexes containsIndex:1])
        {
            _config.repeatWeekTue = true;
        }
        else
        {
            _config.repeatWeekTue = false;
        }
        
        if ([indexes containsIndex:2])
        {
            _config.repeatWeekWed = true;
        }
        else
        {
            _config.repeatWeekWed = false;
        }
        
        if ([indexes containsIndex:3])
        {
            _config.repeatWeekThu = true;
        }
        else
        {
            _config.repeatWeekThu = false;
        }
        
        if ([indexes containsIndex:4])
        {
            _config.repeatWeekFri = true;
        }
        else
        {
            _config.repeatWeekFri = false;
        }
        
        if ([indexes containsIndex:5])
        {
            _config.repeatWeekSat = true;
        }
        else
        {
            _config.repeatWeekSat = false;
        }
        
        if ([indexes containsIndex:6])
        {
            _config.repeatWeekSun = true;
        }
        else
        {
            _config.repeatWeekSun = false;
        }
        [self setRepeatWeekConfig:_config];
        picker_Tag = TAG_SELECT_NONE;
    }
    [pickerView.navigationController popViewControllerAnimated:true];
}

- (void)pickerView:(PickerViewController *)pickerView pickedNumber:(NSUInteger)number
{
    if (picker_Tag == TAG_SELECT_REPEAT_INTE)
    {
        _config.repeatDuration = number;
        [self setRepeatInterval:number];
        picker_Tag = TAG_SELECT_NONE;
    }
    else if (picker_Tag == TAG_SELECT_M_DATE)
    {
        _config.rpMonthIndexDay = number;
        [self setRepeatMonthConfig:_config];
        picker_Tag = TAG_SELECT_NONE;
    }
    [pickerView.navigationController popViewControllerAnimated:true];
}
@end
