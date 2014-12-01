//
//  DTOACCOUNTProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "DTOACCOUNTProcess.h"
#import "DataUtil.h"

#define TABLENAME_DTOACCOUNT @"dtoaccount"

@implementation DTOACCOUNTProcess


-(NSMutableArray*) filter {
    NSArray *allFields =[NSArray arrayWithObjects:DTOACCOUNT_email, DTOACCOUNT_code, DTOACCOUNT_name, DTOACCOUNT_mobile, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,TABLENAME_DTOACCOUNT ];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

@end
