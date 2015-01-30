//
//  DTOProTTQTDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProTTQTDetailProcess.h"

#import "DataUtil.h"

#import "DTOProTTQTDetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProTTQTDetail @"dtoProTTQTDetail"

@implementation DTOProTTQTDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@ and STATUS=1",TABLENAME_dtoProTTQTDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProTTQTDetailObject allFields] selectQuery:query valueParameter:nil];
}
@end
