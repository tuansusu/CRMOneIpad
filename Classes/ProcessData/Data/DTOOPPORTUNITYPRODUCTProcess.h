//
//  DTOOPPORTUNITYPRODUCTProcess.h
//  OfficeOneMB
//
//  Created by viettel on 12/25/14.
//
//

#import "BaseDataProcess.h"

@interface DTOOPPORTUNITYPRODUCTProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

-(NSInteger) getClientId ;
-(NSMutableArray*) filterWithClientOpportunityId: (NSString*) strValue;
-(NSMutableArray*) getById: (NSString*) strValue;
-(BOOL) deleteEntity:(NSString *)opportunityProductId;
@end
