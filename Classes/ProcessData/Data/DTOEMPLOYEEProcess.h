//
//  DTOEMPLOYEEProcess.h
//  OfficeOneMB
//
//  Created by viettel on 3/6/15.
//
//

#import "BaseDataProcess.h"

@interface DTOEMPLOYEEProcess : BaseDataProcess
-(NSDictionary*) getEmployeeByUsername:(NSString*)username;
@end
