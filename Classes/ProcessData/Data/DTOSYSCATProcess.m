//
//  DTOSYSCATProcess.m
//  OfficeOneMB
//
//  Created by ADMIN on 11/19/14.
// Loại hình doanh nghiệp
//

#import "DTOSYSCATProcess.h"
#import "DataUtil.h"

//


@implementation DTOSYSCATProcess


///////xac dinh loai hinh doanh nghiep = 5/////////
-(NSMutableArray*) filterWithCatType : (NSString *) catType  {
    NSArray *allFields =[NSArray arrayWithObjects:DTOSYSCAT_code, DTOSYSCAT_sysCatId,DTOSYSCAT_name,DTOSYSCAT_value, nil];
    
    NSString *query = [NSString stringWithFormat:@"Select %@  FROM dtosyscat where  syscattypeid=%@ order by name",[allFields componentsJoinedByString:@"," ] , catType];
    //NSLog(@"query = %@", query);
    
    return [DataUtil BuilQueryGetListWithListFields:allFields selectQuery:query valueParameter:nil];
}

@end
