//
//  DTOSYSCATProcess.h
//  OfficeOneMB
//
//  Created by ADMIN on 11/19/14.
//
//

#import "BaseDataProcess.h"

#define FIX_SYS_CAT_TYPE_BUSSINESS @"5"
#define FIX_SYS_CAT_TYPE_PERSONAL_JOB @"25"
#define FIX_SYS_CAT_TYPE_PERSONAL_POSITION @"26"

@interface DTOSYSCATProcess : BaseDataProcess

-(NSMutableArray*) filterWithCatType : (NSString *) catType ;




@end
