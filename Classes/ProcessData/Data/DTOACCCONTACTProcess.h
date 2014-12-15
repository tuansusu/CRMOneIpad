//
//  DTOACCCONTACTProcess.h
//  OfficeOneMB
//
//  Created by ADMIN on 12/2/14.
//
//

#import "BaseDataProcess.h"

@interface DTOACCCONTACTProcess : BaseDataProcess

/*
 *Ham them moi
 */
-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity;

-(NSInteger) getClientId ;

@end
