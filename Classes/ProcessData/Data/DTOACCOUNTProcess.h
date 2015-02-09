//
//  DTOACCOUNTProcess.h
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "BaseDataProcess.h"

#define FIX_LEADTYPE_PERSON @"0"
#define FIX_LEADTYPE_BUSSINESS @"1"

@interface DTOACCOUNTProcess : BaseDataProcess
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
-(NSMutableArray*) filterWithArrayCondition : (NSDictionary *) dicCondition;

-(NSMutableArray*) filterWithOrArrayCondition : (NSDictionary *) dicCondition withStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount;
-(NSMutableArray*) filterWithStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount;
@end
