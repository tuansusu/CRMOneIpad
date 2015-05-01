//
//  SyncDataUtil.h
//  OfficeOneMB
//
//  Created by admin on 5/1/15.
//
//

#import "BaseDataProcess.h"

@interface SyncDataUtil : NSObject

-(void) synchonizeDatabase: (NSArray*) arrayDataSync withActionEvent : (ActionEvent*) actionEvent withTableName : (NSString *) tabelName withKeyColumn : (NSString*) keyColumn withArrayColumn : (NSArray*) arrayAllColumn;

@end
