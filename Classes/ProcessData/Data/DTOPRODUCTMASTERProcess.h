//
//  DTOPRODUCTMASTERProcess.h
//  OfficeOneStudy
//
//  Created by viettel on 11/11/14.
//
//

#import "BaseDataProcess.h"

@interface DTOPRODUCTMASTERProcess : BaseDataProcess

-(NSMutableArray*) filter ;

-(NSMutableArray*) filterProductWithProductCode:(NSString*)productCode;

@end
