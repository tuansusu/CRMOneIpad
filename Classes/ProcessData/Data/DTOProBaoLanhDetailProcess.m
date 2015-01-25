//
//  DTOProBaoLanhDetailProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/24/15.
//
//

#import "DTOProBaoLanhDetailProcess.h"

#import "DataUtil.h"

#import "DTOProBaoLanhDetailObject.h"

#import "Items.h"

#define TABLENAME_dtoProBaolanhDetail @"dtoProBaolanhDetail"


@implementation DTOProBaoLanhDetailProcess

-(NSMutableArray*) filterProductDetailWithClientId:(NSString*)clientId WithProductCode:(NSString*)productCode{

    NSString *query = [NSString stringWithFormat:@"Select * from %@ where CLIENT_ID=%@ and PRODUCT_CODE=%@" ,TABLENAME_dtoProBaolanhDetail ,clientId,productCode];

    return [DataUtil BuilQueryGetListWithListFields:[DTOProBaoLanhDetailObject allFields] selectQuery:query valueParameter:nil];
}

@end
