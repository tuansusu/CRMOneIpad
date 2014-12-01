//
//  DTOPRODUCTMASTERProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "DTOPRODUCTMASTERProcess.h"
#import "DataUtil.h"

#define TABLENAME_DTOPRODUCTMASTER @"dtoproductmaster"

@implementation DTOPRODUCTMASTERProcess
-(NSMutableArray*) filter {
    NSArray *allFields =[NSArray arrayWithObjects:DTOPRODUCTMASTER_name, DTOPRODUCTMASTER_code, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,TABLENAME_DTOPRODUCTMASTER ];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}
@end
