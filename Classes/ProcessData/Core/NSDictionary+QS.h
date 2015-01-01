//
//  NSDictionaryExtends.h
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import <Foundation/Foundation.h>

#import "DTOAcountLeadProcessObject.h"
#import "DTOAccountProcessObject.h"
#import "DTOProductLeadTypeObject.h"
#import "DTOProductDetailObject.h"
#import "DTOProductMasterObject.h"

@interface NSDictionary (QS)

-(DTOProductMasterObject*)dtoProductMasterObject;

-(DTOProductDetailObject*)dtoProductDetailObject;

-(DTOProductLeadTypeObject*)dtoProductLeadTypeObject;

-(DTOAcountLeadProcessObject*)dtoAcountLeadProcessOb;
-(DTOAccountProcessObject*)dtoAcountProcessOb;


@end
