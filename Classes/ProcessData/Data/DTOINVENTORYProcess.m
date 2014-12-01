//
//  DTOINVENTORYProcess.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/19/14.
//
//

#import "DTOINVENTORYProcess.h"
#import "DataUtil.h"

#define TABLENAME_DTOINVENTORY @"dtoinventory"

@implementation DTOINVENTORYProcess

-(NSMutableArray*) filter {
    NSArray *allFields =[NSArray arrayWithObjects:DTOINVENTORY_address, DTOINVENTORY_clientInventoryId, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,TABLENAME_DTOINVENTORY ];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

@end
