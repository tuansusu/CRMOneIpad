//
//  TableTestProcess.h
//  OfficeOneStudy
//
//  Created by viettel on 10/30/14.
//
//

#import <Foundation/Foundation.h>
#import "BaseDataProcess.h"


@interface TableTestProcess : BaseDataProcess

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;
-(NSDictionary*) getObjectWithDataID : (NSString*) dataID ;


@end
