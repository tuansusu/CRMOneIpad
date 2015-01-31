//
//  DTOPRODUCTDETAILProcess.h
//  OfficeOneMB
//
//  Created by macpro on 1/1/15.
//
//

#import "BaseDataProcess.h"

@interface DTOPRODUCTDETAILProcess : BaseDataProcess

-(NSMutableArray*) filterProductWithLeadId:(NSString*)leadId WithTypeId:(NSString*)typeId;
-(NSMutableArray*) filterTopKHWithType:(NSString*)typeQuery WithLimitRecord:(int)limitRecord;

@end
