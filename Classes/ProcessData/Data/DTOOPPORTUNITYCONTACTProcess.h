//
//  DTOOPPORTUNITYCONTACTProcess.h
//  OfficeOneMB
//
//  Created by viettel on 12/17/14.
//
//


#import "BaseDataProcess.h"

@interface DTOOPPORTUNITYCONTACTProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

-(NSInteger) getClientId ;
-(BOOL) deleteEntity:(NSString *)opportunityContactId;

@end