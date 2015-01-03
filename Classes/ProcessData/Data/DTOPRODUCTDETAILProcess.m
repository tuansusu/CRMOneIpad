//
//  DTOPRODUCTDETAILProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/1/15.
//
//

#import "DTOPRODUCTDETAILProcess.h"

#import "DTOProductDetailObject.h"
#import "DataUtil.h"

#define TABLENAME_DTOPRODUCTMASTER @"dtoproductdetail"

@implementation DTOPRODUCTDETAILProcess

-(NSMutableArray*) filterProductWithLeadId:(NSString*)leadId WithTypeId:(NSString*)typeId{

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where type=%@ and clientId=%@ and status=1",[[DTOProductDetailObject allFields] componentsJoinedByString:@"," ] ,TABLENAME_DTOPRODUCTMASTER ,typeId,leadId];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProductDetailObject allFields] selectQuery:query valueParameter:nil];
}



@end
