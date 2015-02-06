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

-(NSMutableArray*) filterTheNewestRecord;

-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;
-(NSMutableArray*) filterTaskWithAccountId:(NSString*)accountId WithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;

-(NSInteger) getClientId ;

/*
 * Lọc danh sach lien he theo clientLeaderId
 */
- (NSMutableArray *) filterCalendarWithClientLeaderId: (NSString *) strValue;
- (NSMutableArray *) filterTaskWithClientLeaderId: (NSString *) strValue;

- (NSMutableArray *) filterCalendarWithAccountId: (NSString *) strValue;
- (NSMutableArray *) filterTaskWithAccountId: (NSString *) strValue;

- (NSMutableArray *) filterTaskWithClientOpportunityId: (NSString *) strValue;

- (NSMutableArray*) filterAllTask;
/*
 * Lọc danh sach lien he theo clientLeaderId
 */
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue;
/*
 * lấy danh sách công việc của khách hàng 360
 */
-(NSMutableArray*) filterWith360Id: (NSString*) strValue;

@end
