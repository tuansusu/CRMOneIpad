//
//  DTOOPPORTUNITYProcess.h
//  OfficeOneStudy
//
//  Created by viettel on 11/3/14.
//
//

#import "BaseDataProcess.h"

@interface DTOOPPORTUNITYProcess : BaseDataProcess



-(NSMutableArray*) filterOpportunity:(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(int)type withStart : (int) start withLimit : (int) limit withOutTotal : (int*) totalCount;
-(NSDictionary*) getById:(NSString*)itemId;
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;
-(NSDictionary*) getDataWithKey : (NSString*) inputKey withValue : (NSString*) inputValue;
-(NSInteger) getClientId ;
-(BOOL) deleteEntity:(NSString *)opportunityId;
-(NSMutableArray*) filterWith360Id: (NSString*) strValue;
-(NSMutableArray*) filterWithClienLeadId: (NSString*) strValue;
@end
