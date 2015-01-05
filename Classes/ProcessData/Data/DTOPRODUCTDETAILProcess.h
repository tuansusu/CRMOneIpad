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

@end
