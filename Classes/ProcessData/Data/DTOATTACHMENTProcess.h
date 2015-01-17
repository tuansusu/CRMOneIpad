//
//  DTOATTACHMENTProcess.h
//  OfficeOneMB
//
//  Created by viettel on 12/12/14.
//
//

#import "BaseDataProcess.h"

@interface DTOATTACHMENTProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

/*
 * Ham xoa ghi chu - truyen attachmentId
 */
-(BOOL) deleteEntity : (NSString*) attachmentId;

/*
 * Lọc ghi chu (chưa có tìm kiếm và phân trang)
 */
-(NSMutableArray*) filter;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;

-(NSInteger) getClientId ;

/*
 * Lọc ghi chu theo attachmentId
 */
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue;

@end
