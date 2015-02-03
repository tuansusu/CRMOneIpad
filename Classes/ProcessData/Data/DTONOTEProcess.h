//
//  DTONOTEProcess.h
//  OfficeOneMB
//
//  Created by viettel on 12/8/14.
//
//

#import "BaseDataProcess.h"

@interface DTONOTEProcess : BaseDataProcess

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
-(NSMutableArray*) filterWithLimitRecord:(int)limitRecord;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;

/*
 *Tao ham id client la ham tu sinh
 */
-(NSInteger) getClientId ;

/*
 * Lọc danh sach lien he theo clientLeaderId
 */
-(NSMutableArray*) filterWithClientLeaderId: (NSString*) strValue;
/* Lọc danh sach lien he theo client360Id
*/
-(NSMutableArray*) filterWithClient360Id: (NSString*) strValue;
//lay danh sach theo id co hoi
-(NSMutableArray*) filterWithOpportunityId: (NSString*) strValue;

@end
