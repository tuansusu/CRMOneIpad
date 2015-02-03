//
//  DTOFLLOWUPProcess.h
//  OfficeOneMB
//
//  Created by Luong Hoang on 12/21/14.
//
//

#import <UIKit/UIKit.h>
#import "BaseDataProcess.h"

@interface DTOFLLOWUPProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

/*
 * Ham xoa theo doi
 */
-(BOOL) deleteEntity : (NSString*) leadId;
-(BOOL) checkFollowUp:(NSString *)leadId objectType:(NSString *)type;

/*
 * Lọc khách hàng đầu mối (chưa có tìm kiếm và phân trang)
 */
-(NSMutableArray*) filter;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;

-(NSDictionary*) getDataAccountWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;

-(NSInteger) getClientId ;

/*
 * Lọc danh sach lien he theo clientLeaderId
 */
-(NSMutableArray*) filterWithClientLeaderId: (NSString *)leadId objectType:(NSString *)type;
@end
