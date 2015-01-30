//
//  DTOProTindungDetailProcess.h
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "BaseDataProcess.h"

@interface DTOProTindungDetailProcess : BaseDataProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode;

@end
