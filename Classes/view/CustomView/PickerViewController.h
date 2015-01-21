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
    OOPickerViewType_MultiSelect
}OOPickerViewType;


@interface PickerViewController : UIViewController

@property (nonatomic, assign) id <PickerViewDelegate> delegate;

@property (nonatomic, assign) OOPickerViewType type;
// OOPickerViewType_Date + Time
@property (nonatomic, strong) NSDate * date;
//OOPickerViewType_(MNulti)Select
@property (nonatomic, strong) NSArray/* NSString */ * dataList;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSIndexSet * selectedIndexes;

@end

@protocol PickerViewDelegate <NSObject>

// OOPickerViewType_Date + Time
- pickerView:(PickerViewController *)pickerView pickedDate:(NSDate *)date;
- pickerView:(PickerViewController *)pickerView pickedIndex:(NSUInteger)index;
- pickerView:(PickerViewController *)pickerView pickedIndexes:(NSIndexSet *)indexes;

@end
