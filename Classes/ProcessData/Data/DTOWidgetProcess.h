//
//  DTOWidgetProcess.h
//  OfficeOneMB
//
//  Created by macpro on 1/18/15.
//
//

#import "BaseDataProcess.h"

@interface DTOWidgetProcess : BaseDataProcess

-(NSMutableArray*) filter;
-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue;

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;
-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity;
-(BOOL) deleteEntityWithConfId:(NSString *)confId;

@end
