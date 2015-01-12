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
#import "DTOComplainObject.h"
#import "DTOTaskObject.h"

@interface NSDictionary (QS)

-(DTOTaskObject*)dtoTaskObject;

-(DTOComplainObject*)dtoComplainObject;

-(DTOProductMasterObject*)dtoProductMasterObject;

-(DTOProductDetailObject*)dtoProductDetailObject;

-(DTOProductLeadTypeObject*)dtoProductLeadTypeObject;

-(DTOAcountLeadProcessObject*)dtoAcountLeadProcessOb;
-(DTOAccountProcessObject*)dtoAcountProcessOb;


@end
