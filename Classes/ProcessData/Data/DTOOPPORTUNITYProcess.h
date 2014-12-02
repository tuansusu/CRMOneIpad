//
//  DTOOPPORTUNITYProcess.h
//  OfficeOneStudy
//
//  Created by viettel on 11/3/14.
//
//

#import "BaseDataProcess.h"

@interface DTOOPPORTUNITYProcess : BaseDataProcess



-(NSMutableArray*) filterOpportunity:(NSString*)keyword addStartDate:(NSDate*)startDate addEndDate:(NSDate*)endDate userType:(NSString*)type;
-(NSDictionary*) getById:(NSString*)itemId;
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

@end
