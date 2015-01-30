//
//  DTOProTindungDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/2/15.
//
//

#import "DTOProTindungDetailProcess.h"

#import "DTOProTindungDetailObject.h"
#import "DataUtil.h"

#define TABLENAME_DTOProTindungDetail @"dtoProTindungDetail"
@implementation DTOProTindungDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@ and STATUS=1",TABLENAME_DTOProTindungDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProTindungDetailObject allFields] selectQuery:query valueParameter:nil];
}

@end
