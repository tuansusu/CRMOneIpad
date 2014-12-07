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
#define FIX_SYS_CAT_TYPE_OPPORTTUNITY_STATUS @"10"
#define FIX_SYS_CAT_TYPE_OPPORTTUNITY_NEXT_TASK @"69"
#define FIX_SYS_CAT_TYPE_OPPORTTUNITY_LEVEL @"8"
#define FIX_SYS_CAT_TYPE_TASK_STATUS @"14"

@interface DTOSYSCATProcess : BaseDataProcess

-(NSMutableArray*) filterWithCatType : (NSString *) catType ;




@end
