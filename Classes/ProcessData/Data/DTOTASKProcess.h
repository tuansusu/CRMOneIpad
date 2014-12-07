//
//  DTOTASKProcess.h
//  OfficeOneMB
//
//  Created by viettel on 12/7/14.
//
//

#import "BaseDataProcess.h"

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
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue;

@end
