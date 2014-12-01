//
//  UIView+Custom.h
//  Voffice2.1
//
//  Created by VTIT on 2/24/14.
//
//

#import <UIKit/UIKit.h>
#import "AUISelectiveBordersLayer.h"
#import "UIView+AUISelectiveBorder.h"

@interface UIView (Custom)

-(void) setBackGroundNormalColorWithOption : (int) smgSelect;

/***
 *Đặt background cho menu view
 */
-(void) setBackGroundMenuView : (int) smgSelect;

/***
 *Đặt background cho header view
 */
-(void) setBackGroundHeaderView : (int) smgSelect;


/***
 *Đặt background cho bottom(footer)
 */
-(void) setBackGroundFooterView : (int) smgSelect;


/***
 *Đặt background cho subheader(Trang home-)
 */
-(void) setBackGroundSubHeaderView : (int) smgSelect;


/***
 *Đặt background cho nên - background cái to nhất nó bị (Trang cong viec tôi giao-)
 */
-(void) setBackGroundForBackgroundView : (int) smgSelect;


/***
 *Đặt border cho view - khi chỉ có border top, bottom, right - left đang thấy không ăn
 */
-(void) setBorderWithOption : (int) smgSelect  withBorderFlag : (AUISelectiveBordersFlag) inputBorderFlag;


/***
 *Đặt border cho view - tat ca cac border(top, right, bottom, left)
 */
-(void) setBorderWithOption : (int) smgSelect;



@end
