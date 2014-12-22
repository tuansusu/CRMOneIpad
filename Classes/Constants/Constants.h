//
//  Constants.h
//  NetworkDemo
//
//  Created by Nguyen Thanh Dung on 6/14/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//tuannv
typedef void(^onDismiss)(BOOL); //định kiểu block function

#define DATABASE_NAME @"bisone.sqlite"

/*
 * luongdv3: Validate Login Message
 */
#define VLD_01_001 @"Vui lòng nhập thông tin Tài khoản"
#define VLD_01_002 @"Thông tin Tài khoản hoặc Mật khẩu không hợp lệ"
#define VLD_01_003 @"Vui lòng nhập Mật khẩu"
#define VLD_01_004 @"Sai Tài khoản hoặc mật khẩu"
#define VLD_01_005 @"Không có kết nối mạng. Vui lòng kiểm tra lại kết nối mạng"
#define VLD_01_006 @"Sai Tài khoản hoặc mật khẩu"
#define MAX_LENGTH_LOGIN_TEXTFIELD 100

/*
 *key
 */
#define POST_USERNAME @"username"


# pragma mark Button
#define KEY_NOTIFICATION_TITLE  @"Thông báo"
#define KEY_NOTIFICATION_CANCEL @"Đóng" // thoát
#define KEY_NOTIFICATION_INPUT_AGAIN @"Nhập lại"
#define KEY_NOTIFICATION_YES @"Có"
#define KEY_NOTIFICATION_NO @"Không"
#define KEY_NOTIFICATION_IGNOR  @"Hủy bỏ"
#define KEY_NOTIFICATION_ACCEPT @"Đồng ý"
#define KEY_NOTIFICATION_OTHER  @"Đóng"
#define CONFIRM_FINISH_DOCUMENT  @"Xác nhận hoàn tất văn bản?"
#define BUTTON_ACCEPT  1
#define BUTTON_CANCEL  0
#pragma mark Tag


#define TAG_DELETE_ITEM 11

#define TAG_RELOAD_BUTTON  50
#define TAG_EDIT_CARLENDAR_BUTTON  10
#define TAG_DELETE_CARLENDAR_BUTTON  11
# pragma mark TableView
#define DOCUMENT_HEIGHT_TBV_FILE_ATTACH  50
#define DOCUMENT_HEIGHT_TBV_HISTORY  60
#define DOCUMENT_HEIGHT_TBV_TASK_ASSIGN  160


#define KEY_NOTIFICATION_CENTER_TASK_VIEWDETAIL_REMOVEVIEW @"TaskViewDetailNotification"  //
#define KEY_NOTIFICATION_CENTER_DOCUMENT_VIEWDETAIL_REMOVEVIEW @"DocumentViewDetailNotification"  //


#define TITLE_APP_COPYRIGHT @"CRMONE IPAD 1.0 - Copyright Viettel ICT - Viettel Group"

#define GRID_VIEW_X 7.0
#define GRID_VIEW_WIDTH 990.0
#define GRID_CELL_HEIGHT 200.0

#define IMG_ICON_RIGHT @"icon_right.png"
#define IMG_ICON_DOWN @"icon_down.png"
#define ALL_DOCUMENT 0
#define NO_READ_DOCUMENT 1
#define READED_DOCUMENT 2
#define DocumentAtIndex @"DocumentAtIndex"
#define Path @"Path"
#define Level @"Level"

#define SYS_KEY_EDIT @"Sửa"
#define SYS_KEY_DELETE @"Xoá"

#define Key_SortValidTime @"SortValidTime"
#define Key_SortIndex @"SortIndex"
#define TIME_DISPLAY_CONFIG @"dd/MM/yyyy   HH:mm:ss"
//=========================Map Configuration

#define SYS_Notification_NotGetCurrentLocation @"Không xác định được vị trí của bạn"
#define SYS_Notification_EnableLocation @"Chức năng này yêu cầu bật xác định vị trí của bạn"
//tuannv
#define CommentType_CapNhatTienDo @"Cập nhật tiến độ"
#define CommentType_DeXuat @"Đề xuất"
#define CommentType_GiaoViec @"Giao việc"
#define CommentType_PheDuyet @"Phê duyệt"
#define CommentType_TuChoiPheDuyet @"Từ chối phê duyệt"
#define SYS_Task_Create @"Tạo mới"
#define No_File_Attach @"Không có file"

//tuannv notification
#define SYS_TimeOut @"Hết session trên server"
#define Code_TimeOut 215

#define Introduction_File_Pdf @"Introduct_OfficeOne.pdf"
#define SYS_Notification_Title @"Thông báo!"
#define SYS_Notification_Warming @"Cảnh báo"
#define SYS_Notification_FileNotExist @"File không tồn tại!"
#define SYS_Notification_FileNotSupportRead @"Chưa hỗ trợ đọc văn bản"
#define SYS_Notification_Invalid_InputData @"Dữ liệu nhập vào không đúng"
#define SYS_Notification_ReInput @"Nhập lại"
#define SYS_Notification_InputConfigKey @"Cấu hình hệ thống để được sử dụng đúng hệ thống của đơn vị mình"

#define SYS_Notification_UpdateSuccess @"Cập nhật thành công"
#define SYS_Notification_UpdateFail @"Cập nhật không thành công"
#define SYS_Notification_CancelTitle @"Thoát"

#define IMAGE_ICON_RIGHT @"icon_right.png"
#define IMAGE_ICON_DOWN @"icon_down.png"
#define ICON_MINUS @"icon_minus.png"
#define ICON_PLUS @"icon_plus.png"
#define IMAGE_URL_CheckBox_Tick @"checkbox_ticked.png"
#define IMAGE_URL_CheckBox_NotTick @"checkbox_not_ticked.png"

#define DIGITAL_DOCUMENT_ID @"digital_document_id"

#define VTReInputAlert(MSG) [[[UIAlertView alloc] initWithTitle:@"Thông báo!" message:(MSG) delegate:nil cancelButtonTitle:@"Nhập lại" otherButtonTitles:nil] show]


#define IntToStr(int) [NSString stringWithFormat:@"%d", int]
#define Int32ToStr(int) [NSString stringWithFormat:@"%ld", int]
#define Int64ToStr(int) [NSString stringWithFormat:@"%lld", int]
#define FloatToStr(float) [NSString stringWithFormat:@"%f", float]
#define ObjectToStr(id) [NSString stringWithFormat:@"%@", id]

#define SEG_COLOR_SELECT  [UIColor colorWithRed:40/255.0f green:120/255.0f blue:190/255.0f alpha:1.0f]

//tuannv - queue chay background - funtion
#define customQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

//#define NoDateBefore 2
#define CONFIG_TIMEOUT 1800  //2*60 dang de config time out la 2phut
#define CONFIG_KEY_TIMEOUT @"key_timeout"

#define Title_TimeOut_Exception @"Đã hết thời gian, vui lòng đăng nhập lại hệ thống"


//dinh nghia cai VofficePath khi chua chon don vi
//#define NO_CONFIG_SITE_URL @"http://10.60.15.115:8041/"
//#define NO_CONGIG_VOFFICE_PATH    @"http://10.60.15.115:8009/Base.svc/"

//#define NO_CONFIG_SITE_URL @"http://10.60.15.115:8041/"
//#define NO_CONGIG_VOFFICE_PATH    @"http://10.60.15.115:8010/Base.svc/"
//#define URL_DOWNLOAD @"filepath/" //#define URL_DOWNLOAD @"http://10.60.15.115:8010/Base.svc/filepath/"
//#define KEY_CONGIG_VOFFICE_PATH    @"http://10.60.15.115:8010/Base.svc/"

//#define NO_CONFIG_SITE_URL @"http://officeone.vn/"
//#define NO_CONGIG_VOFFICE_PATH    @"http://officeone.vn:8668/base.svc/"
//#define URL_DOWNLOAD @"http://officeone.vn:8668/base.svc/filepath/"

///sites/demo/
#define NO_CONFIG_SITE_URL @""
#define NO_CONGIG_VOFFICE_PATH    @"http://10.30.6.14:8080/base.svc/"
#define URL_DOWNLOAD @"filepath/"
#define KEY_CONGIG_VOFFICE_PATH    @"http://10.30.6.14:8080/base.svc/"


#define SYSFONT_NORMAL @"Helvetica"
#define SYSFONT_ITALIC @"Helvetica-Oblique"
#define SYSFONT_BOLD_ITALIC @"Helvetica-BoldOblique"
#define SYSFONT_BOLD @"Helvetica-Bold"
#define SYSFONT_SIZE_BIG 17
#define SYSFONT_SIZE_NORMAL 15

#define KEY_VIEWCONTROLLER_CURRENT @"view_controller_current"

#define SCREEN_WIDTH 768
#define SCREEN_HEIGHT 1024
//tuannv36 edit 7/1/2014
#define VALUE_MILLION 1000000

#define kConsumerKey @"kunkun"
#define kConsumerSecret @"3bf47226c60e20ce280eadc22c9c7f5de0cbc6c2"

#define ENCRYPTED @"ENCRYPTED"
#define DECRYPTED @"DECRYPTED"
#define PASSWORDENCRYPT @"mypassword"

#define TaskGiveByLeaderCount @"TaskGiveByLeaderCount"
#define TaskGiveByMeCount @"TaskGiveByMeCount"
#define TaskGroupByDeptCount @"TaskGroupByDeptCount"
#define MyTaskCount @"MyTaskCount"

#define COPY_OF_SOFTWARE @"Copyright Viettel ICT - Viettel Group"
#define VOFFICE @"CRMOne-iPad"
#define TITLE_APPLICATION @"HỆ THỐNG QUẢN LÝ QUAN HỆ KHÁCH HÀNG"
#define NO_CONFIG_TITLE_DEPARTMENT @"HỆ THỐNG THỬ NGHIỆM"
#define ALL_DEPARTMENT @"Tất cả đơn vị"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ICON_DOCUMENT_READ @"Icon_Email_Read.png"
#define ICON_DOCUMENT_NO_READ @"Icon_Emai_noread.png"

#define USER_CONFIG @"userConfig"
#define USER_CONFIG_DEPARTMENT_TITLE @"departmentTitleField"
#define USER_CONFIG_KEYINFO @"keyInfoField"
#define USER_CONFIG_SERVICES_URL @"servicesUrlField"
#define USER_CONFIG_SITEURL @"siteUrlField"
#define USER_CONFIG_KEY @"titleField"

#define USER_LOGIN @"userLogin"
#define USER_NAME @"userName"
#define RESPONSE @"response"
#define FULL_NAME_USER @"fullName"
#define FULL_LOGIN_NAME @"fullName"
#define USER_ID @"userId"
#define SESSION_ID @"sessionId"
#define NOTICE @"notice"
#define GROUP_ID @"userGroupId"
#define ORGANIZATION_ID @"organizationId"
#define GROUP_NAME @"userGroupName"
#define ROLE_ID @"roleId"
#define GET_LIST_STAFF_DOC @"getListStaffDoc"

#define GIATRI_TRANGTHAI_CONG_VIEC_DA_DONG 6
#define GIATRI_TRANGTHAI_CONG_VIEC_DA_PHEDUYET 8

#define FORMAT_TIME @"HH:mm"
#define FORMAT_DATE @"dd/MM/yyyy"
#define PER_LOAD  @"500"

#define SCHEDULE_INTERVAL_NORMAL 400  //300 GIAY
#define SCHEDULE_INTERVAL_RUNNING 15 //6 GIAY

#define CALENDAR_TYPE_HOME @"3"
#define CALENDAR_TYPE_DEPARTMENT @"2"
#define CALENDAR_TYPE_PERSON @"1"
#define CALENDAR_TYPE_NEXTWEEK @"4"

#define HEIGHT_SELECT_INDEX_ROW 44


////////////COLOR CHART//////
#define TAG_Graph_TechTarget_Date 235
#define TAG_Graph_TechTarget_Month 238

#define Width_Report_ViewChart 820  //1004
#define Height_Report_ViewChart 270

#define ZOOM_MAX 4 //
#define ZOOM_MIN 1


#define MIMC1 [MIMColorClass colorWithComponent:@"151,117,92"]
#define MIMC2 [MIMColorClass colorWithComponent:@"13,142,250"]
#define MIMC3 [MIMColorClass colorWithComponent:@"85,85,85"]
#define MIMC4 [MIMColorClass colorWithComponent:@"0,255,250"]

#define MIMC_LINE1 [MIMColorClass colorWithComponent:@"255,255,250"]

#define MIMColor1 [UIColor colorWithRed:151/255.0f green:117/255.0f blue:92/255.0f alpha:1.0f]
#define MIMColor2 [UIColor colorWithRed:13/255.0f green:142/255.0f blue:250/255.0f alpha:1.0f]
#define MIMColor3 [UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1.0f]
#define MIMColor4 [UIColor colorWithRed:0/255.0f green:255/255.0f blue:250/255.0f alpha:1.0f]

#define NOTE_Color_0_85 [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f]
#define NOTE_Color_85_100 [UIColor yellowColor]
#define NOTE_Color_100 [UIColor colorWithRed:0/255.0f green:0/255.0f blue:255/255.0f alpha:1.0f]

#define MIMC_LINE_COLOR_1 [MIMColorClass colorWithComponent:@"146,208,80"]
#define MIM_LINE_COLOR_1 [UIColor colorWithRed:146/255.0f green:208/255.0f blue:80/255.0f alpha:1.0f]
////////////COLOR CHART//////


@interface Constants : NSObject {
	
}

@end
