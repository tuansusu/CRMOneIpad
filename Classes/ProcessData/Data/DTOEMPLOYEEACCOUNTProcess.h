//
//  DTOEMPLOYEEACCOUNT.h
//  OfficeOneStudy
//
//  Created by viettel on 10/30/14.
//
//

#import "BaseDataProcess.h"


@interface DTOEMPLOYEEACCOUNTProcess : BaseDataProcess

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;
-(NSDictionary*) getObjectWithDataID : (NSString*) dataID ;
-(NSMutableArray*) getAllItems; //Lay tat ca

@end
