//
//  DTOProTTQTDetailProcess.h
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "BaseDataProcess.h"

@interface DTOProTTQTDetailProcess : BaseDataProcess
-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode;
@end
