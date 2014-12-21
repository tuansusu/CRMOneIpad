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

@interface NSDictionary (QS)

-(DTOAcountLeadProcessObject*)dtoAcountLeadProcessOb;
-(DTOAccountProcessObject*)dtoAcountProcessOb;

@end
