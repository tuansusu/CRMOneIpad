//
//  VTDateField.h
//  OfficeOneStudy
//
//  Created by viettel on 11/1/14.
//
//

#import <UIKit/UIKit.h>

@protocol VTDateFieldDelegate <NSObject>

@optional
-(void) dateFieldClick:(id)sender withIndex:(NSInteger)index;

@end

@interface VTDateField : UIView

@end
