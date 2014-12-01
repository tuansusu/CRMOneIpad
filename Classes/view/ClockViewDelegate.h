//
//  ClockViewDelegate.h
//  OfficeOneIpad
//
//  Created by VTIT on 6/10/14.
//
//

#import <Foundation/Foundation.h>

@protocol ClockViewDelegate <NSObject>
@optional
-(void) openClockView;
-(void) closeClockView;
@end
