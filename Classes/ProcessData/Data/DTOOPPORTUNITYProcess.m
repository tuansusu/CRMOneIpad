//
//  DTOOPPORTUNITYProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/3/14.
//
//

#import "DTOOPPORTUNITYProcess.h"
#import "DataUtil.h"

@implementation DTOOPPORTUNITYProcess

-(NSMutableArray*) filterOpportunity {
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOCONTACT_fullName, DTOOPPORTUNITY_code, DTOOPPORTUNITY_name, DTOOPPORTUNITY_endDate, DTOOPPORTUNITY_startDate, DTOOPPORTUNITY_status, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] , @" dtoopportunity op left join dtoopportunitycontact opc on op.clientOpportunityId=opc.clientOpportunityContactId left join dtocontact con on opc.clientOpportunityContactId = con.clientContactId "];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

@end
