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
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;


@end
