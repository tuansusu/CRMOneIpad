//
//  DTOACCOUNTLEADProcess.h
//  OfficeOneStudy
//
//  Created by ADMIN on 11/13/14.
//
//

#import "BaseDataProcess.h"

#define FIX_LEADTYPE_PERSON @"0"
#define FIX_LEADTYPE_BUSSINESS @"1"

#define SELECT_TEXT_ADD_PERSON @"Khách hàng cá nhân"
#define SELECT_TEXT_ADD_BUSSINESS @"Khách hàng doanh nghiệp"

/*
 * Khách hàng đầu mối
 */
@interface DTOACCOUNTLEADProcess : BaseDataProcess
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
-(NSMutableArray*) filterWithStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount;

-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue withStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;
-(NSInteger) getClientId ;

/*
 * Tim kiem theo nhieu dieu kien and
 */
-(NSMutableArray*) filterWithArrayCondition : (NSDictionary *) dicCondition;
/*
 * Tim kiem theo nhieu dieu kien or
 */
-(NSMutableArray*) filterWithOrArrayCondition : (NSDictionary *) dicCondition;

-(NSMutableArray*) filterWithOrArrayCondition : (NSDictionary *) dicCondition withStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount;

@end
