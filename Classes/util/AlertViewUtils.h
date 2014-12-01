//
//  AlertViewUtils.h
//  ViettelPI
//
//  Created by Trinh Duy Nhan on 3/27/14.
//  Copyright (c) 2014 viettel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertViewUtils : NSObject

/**Hiển thị alert thông báo cơ bản (gồm tối đa 2 nút bấm) xác định bởi các tham số đầu vào.
 @author    nhantd
 @param     title
 Tiêu đề của alert.
 @param     message
 Thông điệp của alert.
 @param     delegate
 Delegate của alert.
 @param     tag
 Tag của alert.
 @param     titleButtonCancel
 Tiêu đề nút cancel của alert.
 @param     otherButtonTitle
 Tiêu đề nút còn lại của alert.
 @return    void.
 */
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle;


/**Hiển thị alert với textfield input (gồm tối đa 2 nút bấm) xác định bởi các tham số đầu vào.
 @author    nhantd
 @param     title
 Tiêu đề của alert.
 @param     message
 Thông điệp của alert.
 @param     delegate
 Delegate của alert.
 @param     tag
 Tag của alert.
 @param     titleButtonCancel
 Tiêu đề nút cancel của alert.
 @param     otherButtonTitle
 Tiêu đề nút còn lại của alert.
 @return    void.
 */
+ (void)showAlertViewTextInputWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle;


/**Hiển thị alert với textfield input (gồm tối đa 2 nút bấm) xác định bởi các tham số đầu vào.
 @author    nhantd
 @param     title
 Tiêu đề của alert.
 @param     inputText
 Nội dung của textfield.
 @param     message
 Thông điệp của alert.
 @param     delegate
 Delegate của alert.
 @param     tag
 Tag của alert.
 @param     titleButtonCancel
 Tiêu đề nút cancel của alert.
 @param     otherButtonTitle
 Tiêu đề nút còn lại của alert.
 @return    void.
 */
+ (void)showAlertViewTextInputWithTitle:(NSString *)title inputText:(NSString *)inputText message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle;


/**Hiển thị alert với textfield password input (gồm tối đa 2 nút bấm) xác định bởi các tham số đầu vào.
 @author    nhantd
 @param     title
 Tiêu đề của alert.
 @param     message
 Thông điệp của alert.
 @param     delegate
 Delegate của alert.
 @param     tag
 Tag của alert.
 @param     titleButtonCancel
 Tiêu đề nút cancel của alert.
 @param     otherButtonTitle
 Tiêu đề nút còn lại của alert.
 @return    void.
 */
+ (void)showAlertViewPasswordInputWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle;



/**Hiển thị alert với textfield user & password input (gồm tối đa 2 nút bấm) xác định bởi các tham số đầu vào.
 @author    nhantd
 @param     title
 Tiêu đề của alert.
 @param     message
 Thông điệp của alert.
 @param     delegate
 Delegate của alert.
 @param     tag
 Tag của alert.
 @param     titleButtonCancel
 Tiêu đề nút cancel của alert.
 @param     otherButtonTitle
 Tiêu đề nút còn lại của alert.
 @return    void.
 */
+ (void)showAlertViewUserPasswordWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate withTag:(NSInteger)tag withTitleButtonCancel:(NSString *)titleButtonCancel withTitleButtonOther:(NSString *)otherButtontitle;

@end
