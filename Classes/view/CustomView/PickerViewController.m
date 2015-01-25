//
//  PickerViewController.m
//  OfficeOneMB
//
//  Created by Duy Pham on 18/1/15.
//
//

#import "PickerViewController.h"

@interface PickerViewController ()
<UITableViewDelegate, UITableViewDataSource,
UIPickerViewDelegate, UIPickerViewDataSource>
{
    __weak IBOutlet UIDatePicker * _datePicker;
    __weak IBOutlet UIPickerView * _picker;
    __weak IBOutlet UITableView  * _tableview;
}

- (IBAction)dateSelected:(UIDatePicker *)sender;
@end

@implementation PickerViewController
{
    NSMutableIndexSet * _mselectedIndexes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _date = [NSDate date];
    _dataList = [NSArray array];
    _selectedIndex = 0;
    _mselectedIndexes = [[NSMutableIndexSet alloc] init];
    
    _numberStart = 0;
    _numberStep  = 1;
    _numberCount = 1;
    _numberSelected = 1;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chọn" style:UIBarButtonItemStylePlain target:self action:@selector(confirmPressed)];
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

- (IBAction)dateSelected:(UIDatePicker *)sender
{
    _date = sender.date;
}

- (void)confirmPressed
{
    if (_delegate != nil)
    {
        if ((_type == OOPickerViewType_Date || _type == OOPickerViewType_Time) && [_delegate respondsToSelector:@selector(pickerView:pickedDate:)])
        {
            [_delegate pickerView:self pickedDate:_date];
        }
        else if  (_type == OOPickerViewType_Select && [_delegate respondsToSelector:@selector(pickerView:pickedIndex:)])
        {
            [_delegate pickerView:self pickedIndex:_selectedIndex];
        }
        else if (_type == OOPickerViewType_MultiSelect && [_delegate respondsToSelector:@selector(pickerView:pickedIndexes:)])
        {
            [_delegate pickerView:self pickedIndexes:_selectedIndexes];
        }
        else if (_type == OOPickerViewType_Number && [_delegate respondsToSelector:@selector(pickerView:pickedNumber:)])
        {
            [_delegate pickerView:self pickedNumber:_numberSelected];
        }
        else
        {
            
        }
    }
}

- (void)cancelPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
- (void)setType:(OOPickerViewType)type
{
    _type = type;
    
    switch (type)
    {
        case OOPickerViewType_Date:
        {
            _datePicker.hidden = false;
            _picker.hidden     = true;
            _tableview.hidden  = true;
            
            _datePicker.datePickerMode = UIDatePickerModeDate;
            self.title = @"Chọn ngày";
        }
            break;
        case OOPickerViewType_Time:
        {
            _datePicker.hidden = false;
            _picker.hidden     = true;
            _tableview.hidden  = true;
            
            _datePicker.datePickerMode = UIDatePickerModeTime;
            self.title = @"Chọn giờ";
        }
            break;
        case OOPickerViewType_Select:
        {
            _datePicker.hidden = true;
            _picker.hidden     = false;
            _tableview.hidden  = true;
            
            self.title = @"Chọn một";
        }
            break;
        case OOPickerViewType_MultiSelect:
        {
            _datePicker.hidden = true;
            _picker.hidden     = true;
            _tableview.hidden  = false;
            
            self.title = @"Chọn nhiều";
        }
        case OOPickerViewType_Number:
        {
            _datePicker.hidden = true;
            _picker.hidden     = false;
            _tableview.hidden  = true;
            
            self.title = @"Chọn số";
        }
            break;
        default:
        {
            _datePicker.hidden = true;
            _picker.hidden     = true;
            _tableview.hidden  = true;
        }
            break;
    }
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    _datePicker.date = date;
}

- (void)setSelectedIndexes:(NSIndexSet *)selectedIndexes
{
    _selectedIndexes = selectedIndexes;
    
    _mselectedIndexes = [[NSMutableIndexSet alloc] initWithIndexSet:selectedIndexes];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [_picker selectRow:selectedIndex inComponent:0 animated:true];
}

- (void)setNumberSelected:(NSUInteger)numberSelected
{
    if (_numberStep > 0 && numberSelected > _numberStart)
    {
        [_picker selectRow:((_numberSelected - _numberStart)/_numberStep) inComponent:0 animated:true];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == OOPickerViewType_MultiSelect)
    {
        if ([_mselectedIndexes containsIndex:indexPath.row])
        {
            [_mselectedIndexes removeIndex:indexPath.row];
        }
        else
        {
            [_mselectedIndexes addIndex:indexPath.row];
        }
        
//        [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0U]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == OOPickerViewType_MultiSelect && _dataList != nil)
    {
        return [_dataList count];
    }
    return 0U;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PickerViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (_type == OOPickerViewType_MultiSelect && _dataList != nil && indexPath.row < [_dataList count])
    {
        cell.textLabel.text = [_dataList objectAtIndex:indexPath.row];
        if ([_selectedIndexes containsIndex:indexPath.row])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}


#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        if (_type == OOPickerViewType_Select && _dataList != nil && row < [_dataList count])
        {
            _selectedIndex = row;
        }
        else if (_type == OOPickerViewType_Number && row < _numberCount)
        {
            _numberSelected = _numberStart + _numberStep*row;
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1U;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        if (_type == OOPickerViewType_Select && _dataList != nil)
        {
            return [_dataList count];
        }
        else if (_type == OOPickerViewType_Number && _numberCount > 0)
        {
            return _numberCount;
        }
    }
    
    return 0U;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (component == 0)
    {
        if (_type == OOPickerViewType_Select && _dataList != nil)
        {
            return [_dataList objectAtIndex:row];
        }
        else if (_type == OOPickerViewType_Number && row < _numberCount)
        {
            return [NSString stringWithFormat:@"%u", (_numberStart + _numberStep*row)];
        }
    }
    
    return @"--";
}



@end
