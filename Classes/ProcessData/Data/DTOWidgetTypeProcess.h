//
//  DTOWidgetTypeProcess.h
//  OfficeOneMB
//
//  Created by macpro on 1/20/15.
//
//

#import "BaseDataProcess.h"

@interface DTOWidgetTypeProcess : BaseDataProcess

-(NSMutableArray*) filter;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

@end
