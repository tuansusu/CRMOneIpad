//
//  PickerViewController.h
//  OfficeOneMB
//
//  Created by Duy Pham on 18/1/15.
//
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate;
typedef enum
{
    OOPickerViewType_Date,
    OOPickerViewType_Time,
    OOPickerViewType_Select,
    OOPickerViewType_MultiSelect,
    OOPickerViewType_Number
}OOPickerViewType;


@interface PickerViewController : UIViewController

@property (nonatomic, assign) id <PickerViewDelegate> delegate;

@property (nonatomic, assign) OOPickerViewType type;
// OOPickerViewType_Date + Time
@property (nonatomic, strong) NSDate * date;
//OOPickerViewType_(MNulti)Select
@property (nonatomic, strong) NSArray/* NSString */ * dataList;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSMutableIndexSet * selectedIndexes;
//OOPickerViewType_Number
@property (nonatomic, assign) NSUInteger numberStart;
@property (nonatomic, assign) NSUInteger numberStep;
@property (nonatomic, assign) NSUInteger numberCount;
@property (nonatomic, assign) NSUInteger numberSelected;



@end

@protocol PickerViewDelegate <NSObject>

// OOPickerViewType_Date + Time
- (void)pickerView:(PickerViewController *)pickerView pickedDate:(NSDate *)date;
//OOPickerViewType_(MNulti)Select
- (void)pickerView:(PickerViewController *)pickerView pickedIndex:(NSUInteger)index;
- (void)pickerView:(PickerViewController *)pickerView pickedIndexes:(NSIndexSet *)indexes;
//OOPickerViewType_Number
- (void)pickerView:(PickerViewController *)pickerView pickedNumber:(NSUInteger)number;

@end
