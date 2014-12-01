//
//  WeekPickerViewController.m
//  Voffice2.1
//
//  Created by VTIT on 12/30/13.
//
//

#import "WeekPickerViewController.h"

@interface WeekPickerViewController ()
{
    NSInteger currentIndexWeek;
    NSInteger currentIndexYear;
    
    NSArray *arrayWeekInYear;
    NSMutableArray *arrayYear;
    
    NSInteger currentYear;
    
}
@end

@implementation WeekPickerViewController

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
    
    currentYear = [DateUtil getCurrentYear];
    arrayYear = [[NSMutableArray alloc]init];
    for (int i=currentYear-10; i<=currentYear+1; i++) {
        [arrayYear addObject:IntToStr(i)];
    }
    
    currentIndexYear = [arrayYear indexOfObject:IntToStr(self.year)];
    
    
    if (currentYear==self.year) {
        //arrayWeekInYear = [DateUtil getAllWeekInYear:&currentIndexWeek];
    }else {
        arrayWeekInYear = [DateUtil getAllWeekInYear:self.year withWeekOut:&currentIndexWeek];
    }
    
    
    
}

-(void) viewWillAppear:(BOOL)animated{
 
    
    [self.picker selectRow:currentIndexYear inComponent:1 animated:NO];
    [self.picker selectRow:self.weekIndex inComponent:0 animated:NO];
    
}



-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat width = [self pickerView:self.picker widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 45.0f);
    
    if (component == 0)
    {
        const CGFloat padding = 9.0f;
        if (component) {
            frame.origin.x += padding;
            frame.size.width -= padding;
        }
        
        frame.size.width -= padding;
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    if (component == 0) {
        if (row >= arrayWeekInYear.count) {
            label.text = [arrayWeekInYear objectAtIndex:arrayWeekInYear.count-1];
        }else{
        label.text = [arrayWeekInYear objectAtIndex:row];
        }
        label.textAlignment = component ? NSTextAlignmentLeft : NSTextAlignmentRight;
        label.font = [UIFont boldSystemFontOfSize:16.0f];
    } else {
        label.text =  [arrayYear objectAtIndex:row];
            label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:24.0f];
        
    }
    
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0.0f, 0.1f);
    label.shadowColor = [UIColor whiteColor];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        currentIndexWeek = row;
        return;
    }
    
    if (row != currentIndexYear) {
        currentIndexYear = row;
        self.year =  [[arrayYear objectAtIndex:(int)currentIndexYear] integerValue];
        if (currentYear==self.year) {
            //arrayWeekInYear = [DateUtil getAllWeekInYear:&currentIndexWeek];
        }else {
            arrayWeekInYear = [DateUtil getAllWeekInYear:self.year withWeekOut:&currentIndexWeek];
        }
        
        //[self.picker reloadAllComponents];
       [self.picker reloadComponent:0];
        
        if (currentIndexWeek>arrayWeekInYear.count) {
            currentIndexWeek = arrayWeekInYear.count-1;
        }
        [self.picker selectRow:currentIndexWeek inComponent:0 animated:NO];
    }
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //Two columns
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    if(component== 0)
    {
        return [arrayWeekInYear count];
    }
    else
    {
        return [arrayYear count];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0)
        return 220.0f;
    else
        return 76.0f;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dismissView:(id)sender {
    
    [self.delegatePicker selectWeekPickerWithWeek:currentIndexWeek withYear:[[arrayYear objectAtIndex:(int)currentIndexYear] integerValue] withTextSelected:[arrayWeekInYear objectAtIndex:currentIndexWeek]];
    [self.delegatePicker dismissPopoverView];
}
@end
