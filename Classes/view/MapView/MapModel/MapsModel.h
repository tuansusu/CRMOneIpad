//
//  MapsModel.h
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import <Foundation/Foundation.h>

#import "DTOACCOUNTLEADProcess.h"

@interface MapsModel : NSObject
{
    DTOACCOUNTLEADProcess *dtoLeadProcess;
}

@property (nonatomic,readonly) NSMutableArray *listCustomer;

-(void)getAllCustomer;

@end
