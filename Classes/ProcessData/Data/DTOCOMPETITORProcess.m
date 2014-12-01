//
//  DTOCOMPETITORProcess.m
//  OfficeOneStudy
//
//  Created by viettel on 11/10/14.
//
//

#import "DTOCOMPETITORProcess.h"
#import "DataUtil.h"

#define TABLENAME_DTOCOMPETITOR @"dtocompetitor"

@implementation DTOCOMPETITORProcess

-(NSMutableArray*) filterCompetitor {
    
    
    NSArray *allFields =[NSArray arrayWithObjects:DTOCOMPETITOR_id, DTOCOMPETITOR_fullName,DTOCOMPETITOR_code, DTOCOMPETITOR_note, DTOCOMPETITOR_address, DTOCOMPETITOR_birthday, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@",[allFields componentsJoinedByString:@"," ] ,TABLENAME_DTOCOMPETITOR ];
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

@end
