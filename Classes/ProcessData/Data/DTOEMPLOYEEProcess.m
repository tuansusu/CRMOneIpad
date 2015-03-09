//
//  DTOEMPLOYEEProcess.m
//  OfficeOneMB
//
//  Created by viettel on 3/6/15.
//
//

#import "DTOEMPLOYEEProcess.h"
#import "DataUtil.h"

#define TABLENAME_dtoEmployee "dtoEmployee"

@implementation DTOEMPLOYEEProcess
-(NSDictionary*) getEmployeeByUsername:(NSString*)username{
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOEMPLOYEE_id,DTOEMPLOYEE_aoCode,DTOEMPLOYEE_hrisCode,DTOEMPLOYEE_userLogin,DTOEMPLOYEE_fullName,DTOEMPLOYEE_sex,DTOEMPLOYEE_birthday,DTOEMPLOYEE_enterOrgDate,DTOEMPLOYEE_branch,DTOEMPLOYEE_department,DTOEMPLOYEE_title,DTOEMPLOYEE_position,DTOEMPLOYEE_dayStartPosition,DTOEMPLOYEE_mobile,DTOEMPLOYEE_phoneOrg,DTOEMPLOYEE_phoneRetail,DTOEMPLOYEE_fax,DTOEMPLOYEE_address, nil];
    
    NSString *query= [NSString stringWithFormat:@"Select %@ from %@ where userLogin='%@'",[allFields componentsJoinedByString:@","],@"dtoEmployee",username];
 
    
    return [[DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil] objectAtIndex:0];
}

@end
