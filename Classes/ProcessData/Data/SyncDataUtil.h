//
//  SyncDataUtil.h
//  OfficeOneMB
//
//  Created by admin on 5/1/15.
//
//

#import "BaseDataProcess.h"

@interface SyncDataUtil : NSObject

/*
 * Hàm khởi tạo với controller(Sau nay có thể dùng cái viewcontroller này để update lại layout)
 */
-(id) initWithViewController : (BaseViewController*) viewController;


/*
 * Hàm đồng bộ dữ liệu khi lấy được dữ liệu từ server -> push vào db
 */
-(void) synchonizeDatabase: (NSArray*) arrayDataSync withActionEvent : (ActionEvent*) actionEvent withTableName : (NSString *) tabelName withKeyColumn : (NSString*) keyColumn withArrayColumn : (NSArray*) arrayAllColumn;
/*
 * Hàm chung thực hiện đồng bộ dữ liệu từ server về client
 */
 
-(void) getDBFromServerToClien : (BaseViewController*) viewController;
/*
 * Hàm chung thực hiện đồng bộ dữ liệu từ client lên server
 */
-(void)  pushDBFromClientToServer : (BaseViewController*) viewController;


/*
 * Hàm này xác định xem vừa thực hiện động bộ thông tin gì?
 * Nếu là lấy maxtime thì thực hiện đồng bộ thông tin đó? 
 * Nếu là đồng bộ về thì kiểm tra xem còn phải đồng bộ nữa không?
 * Nếu co - Thì tiếp tục đồng bộ 
 * Nếu không - Thì lấy trong danh sách mảng tiếp theo cần đồng bộ
 */
-(void) receiveDataFromModel: (ModelEvent*) modelEvent;


- (void) receiveErrorFromModel: (ModelEvent*) modelEvent;


- (void) receiveErrorInternetFromModel: (ModelEvent*) modelEvent;

- (void) presentSmallWaiting;
- (void) dismissSmallWaiting;
-(void) displayNotConnectInternet;
-(void) displayErrorData;
-(void) timeOutAction;

-(void) doException : (NSException *) ex withMessage : (NSString*) strMessage;
-(void) doException : (NSException *) ex;


@end
