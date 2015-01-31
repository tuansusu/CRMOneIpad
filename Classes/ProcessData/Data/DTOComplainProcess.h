//
//  DTOComplainProcess.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "BaseDataProcess.h"

@interface DTOComplainProcess : BaseDataProcess

-(NSMutableArray*) filterWithLeadId:(NSString*)leadId;


-(NSMutableArray*) filterWithLeadId:(NSString*)leadId WithKey : (NSString*) strKey withValue : (NSString*) strValue;
-(NSMutableArray*) filterWithLimitRecord:(int)limitRecord;

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;
-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity;
-(BOOL) deleteEntityWithCasesId:(NSString *)casesId;

@end
