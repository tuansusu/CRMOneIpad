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

@end
