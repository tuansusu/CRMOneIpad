//
//  AlarmCalendarViewController.m
//  OfficeOneMB
//
//  Created by Duy Pham on 4/1/15.
//
//

#import "AlarmCalendarViewController.h"
#import "VTRadio.h"

@interface AlarmCalendarViewController ()
<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    __weak IBOutlet UISegmentedControl *_onOffSwitch;
    
    __weak IBOutlet UITextField * _dayTF;
    __weak IBOutlet UIButton    * _dayDDBtn;
    __weak IBOutlet UITextField * _hourTF;
    __weak IBOutlet UIButton    * _hourDDBtn;
    __weak IBOutlet UITextField * _minuteTF;
    __weak IBOutlet UIButton    * _minuteDDBtn;
    
    __weak IBOutlet UISwitch *_emailSwitch;
    __weak IBOutlet UISwitch *_smsSwitch;
    __weak IBOutlet UISwitch *_notifSwitch;
    
    __weak IBOutlet UIPickerView *_pickerView;
    __weak IBOutlet UIView *_pickerContainerView;
}
- (IBAction)onOffSwitchChanged:(UISegmentedControl *)sender;

- (IBAction)pickerBtnPressed:(UIButton *)sender;
- (IBAction)pickerDonePressed:(UIButton *)sender;

- (IBAction)confirmBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;
@end

typedef enum {
    pickerType_day,
    pickerType_hour,
    pickerType_minute
} pickerType_t;

@implementation AlarmCalendarViewController
{
    pickerType_t pickerType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dayTF.delegate    = self;
    _hourTF.delegate   = self;
    _minuteTF.delegate = self;
    
    _pickerView.delegate   = self;
    _pickerView.dataSource = self;
    
    [self setupViewForConfig];
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
    if (sender == _onOffSwitch)
    {
        _config.isReminder = ([sender selectedSegmentIndex] == 1);
        [self setConfigEnable:([sender selectedSegmentIndex] == 1)];
    }
    else
    {
        _config.reminderEmail  = [_emailSwitch isOn];
        _config.reminderSMS    = [_smsSwitch isOn];
        _config.reminderNofify = [_notifSwitch isOn];
    }
}

- (IBAction)pickerBtnPressed:(UIButton *)sender
{
    _pickerContainerView.hidden = TRUE;
    if (sender == _dayDDBtn)
    {
        pickerType = pickerType_day;

    }
    else if (sender == _hourDDBtn)
    {
        pickerType = pickerType_hour;

    }
    else if (sender == _minuteDDBtn)
    {
        pickerType = pickerType_minute;
    }
    else
    {
        return;
    }
    
    [_pickerView reloadAllComponents];
    _pickerContainerView.hidden = FALSE;
}

- (IBAction)pickerDonePressed:(UIButton *)sender
{
    _pickerContainerView.hidden = TRUE;
}

- (IBAction)confirmBtnPressed:(id)sender
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(alarmCalendarView:confirmConfig:)] &&
        [_delegate respondsToSelector:@selector(dismissPopoverView)])
    {
        [_delegate alarmCalendarView:self confirmConfig:_config];
//        [_delegate dismissPopoverView];
    }
}

- (IBAction)cancelBtnPressed:(id)sender
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(dismissPopoverView)])
    {
        [_delegate dismissPopoverView];
    }
}
#pragma mark -
- (void)setupViewForConfig
{
    if (_config == nil)
    {
        pickerType = pickerType_day;
        
        _config = [[AlarmCalendarConfig alloc] init];
    }
    
    [self displayConfig:_config];
}

#pragma mark -
- (void)setConfigEnable:(BOOL)configEnable
{
    [_onOffSwitch setSelectedSegmentIndex:configEnable?1:0];
    
    _dayTF.enabled       = configEnable;
    _dayDDBtn.enabled    = configEnable;
    _hourTF.enabled      = configEnable;
    _hourDDBtn.enabled   = configEnable;
    _minuteTF.enabled    = configEnable;
    _minuteDDBtn.enabled = configEnable;

    _emailSwitch.enabled = configEnable;
    _smsSwitch.enabled   = configEnable;
    _notifSwitch.enabled = configEnable;
}

- (void)displayConfig:(AlarmCalendarConfig *)config
{
    [self setConfigEnable:[config isReminder]];
    [self setReminderTime:[config reminderTime]];
    [_emailSwitch setOn:[config reminderEmail]];
    [_smsSwitch   setOn:[config reminderSMS]];
    [_notifSwitch setOn:[config reminderNofify]];
}

- (void)setReminderTime:(NSUInteger)reminderTime // minutes
{
    NSUInteger minutes = reminderTime % 60;
    NSUInteger hours   = ((reminderTime - minutes)/60) % 24;
    NSUInteger days    = (((reminderTime - minutes)/60) - hours)/ 24;
    
    _minuteTF.text = [NSString stringWithFormat:@"%d", minutes];
    _hourTF.text   = [NSString stringWithFormat:@"%d", hours];
    _dayTF.text    = (days > 31)?@"30":[NSString stringWithFormat:@"%d", days];
}

- (NSUInteger)getReminderTime
{
    NSUInteger minutes = [_minuteTF.text integerValue];
    NSUInteger hours   = [_hourTF.text   integerValue];
    NSUInteger days    = [_dayTF.text    integerValue];
    
    return ((days * 24 + hours) * 60 + minutes);
}

#pragma mark - UIPickerView data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        if (pickerType == pickerType_day)
        {
            return 32;
        }
        else if (pickerType == pickerType_hour)
        {
            return 24;
        }
        else if (pickerType == pickerType_minute)
        {
            return 60;
        }
    }
    
    return 0;
}

#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (component == 0)
    {
        return [NSString stringWithFormat:@"%ld", (long)row];
    }
    
    return @"N/A";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerType == pickerType_day)
    {
        _dayTF.text = [NSString stringWithFormat:@"%ld", (long)row];
    }
    else if (pickerType == pickerType_hour)
    {
        _hourTF.text = [NSString stringWithFormat:@"%ld", (long)row];
    }
    else if (pickerType == pickerType_minute)
    {
        _minuteTF.text = [NSString stringWithFormat:@"%ld", (long)row];
    }
    
    _config.reminderTime = [self getReminderTime];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _dayTF)
    {
        [_dayDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _hourTF)
    {
        /* show status picker */
        [_hourDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if (textField == _minuteTF)
    {
        /* show date from picker */
        [_minuteDDBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
    }
    
    return FALSE;
}
@end
