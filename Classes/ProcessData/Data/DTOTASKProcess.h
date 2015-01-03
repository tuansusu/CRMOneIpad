//
//  DTOTASKProcess.h
//  OfficeOneMB
//
//  Created by viettel on 12/7/14.
//
//

#import "BaseDataProcess.h"

#define FIX_TASK_STATUS_COMPLETE     3245
#define FIX_TASK_STATUS_NOT_COMPLETE 3244

@interface DTOTASKProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

/*
 * Ham xoa khach hang dau moi - truyen clientLeadId
 */
-(BOOL) deleteEntity : (NSString*) leadId;

/*
 * Lọc khách hàng đầu mối (chưa có tìm kiếm và phân trang)
 */
-(NSMutableArray*) filter;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;

-(NSInteger) getClientId ;

/*
 * Lọc danh sach lien he theo clientLeaderId
 */
- (NSMutableArray *) filterCalendarWithClientLeaderId: (NSString *) strValue;
- (NSMutableArray *) filterTaskWithClientLeaderId: (NSString *) strValue;

@end
