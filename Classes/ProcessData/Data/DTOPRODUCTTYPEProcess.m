//
//  DTOPRODUCTTYPEProcess.m
//  OfficeOneMB
//
//  Created by macpro on 12/31/14.
//
//

#import "DTOPRODUCTTYPEProcess.h"

#import "DataUtil.h"

#define TABLENAME_DTOPRODUCTTYPE @"dtoproducttype"

@implementation DTOPRODUCTTYPEProcess

-(NSMutableArray*) filter {
    NSArray *allFields =[NSArray arrayWithObjects:DTOPRODUCTTYPE_productTypeId, DTOPRODUCTTYPE_name,DTOPRODUCTTYPE_code,DTOPRODUCTTYPE_isActive, nil];

    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where isActive=1 order by %@ asc",[allFields componentsJoinedByString:@"," ] ,TABLENAME_DTOPRODUCTTYPE,DTOPRODUCTTYPE_name];

    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

@end
