//
//  VTCheckBoxDelegate.h
//  OfficeOneStudy
//
//  Created by viettel on 11/1/14.
//
//

#import <Foundation/Foundation.h>

@protocol VTCheckBoxDelegate <NSObject>

@optional
-(NSString *) getMessageString : (NSInteger) index :(id) sender : (NSInteger) rowIndex : (NSInteger) columnIndex;
-(void) checkBoxClick:(id)sender withIndex:(NSInteger)index;

@end

//@end
