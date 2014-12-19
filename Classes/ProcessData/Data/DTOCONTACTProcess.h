//
//  DTOCONTACTProcess.h
//  OfficeOneStudy
//
//  Created by viettel on 10/31/14.
//
//

#import "BaseDataProcess.h"



@interface DTOCONTACTProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity;

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
-(NSMutableArray*) filterWithClientOpportunityId: (NSString*) strValue;
@end
