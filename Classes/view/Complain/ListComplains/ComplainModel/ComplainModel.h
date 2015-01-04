//
//  ComplainModel.h
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import <Foundation/Foundation.h>

#import "DTOComplainProcess.h"

#import "NSDictionary+QS.h"

@interface ComplainModel : NSObject
{
    DTOComplainProcess *dtoComplainProcess;
}

@property (nonatomic,readonly) NSMutableArray *listComplains;
@property (nonatomic,assign) NSInteger currentPage;

-(void)getFirstPagePageComplainsWithKey:(NSString*)key WithLeadID:(NSString*)leadId;

-(void)getNextPageComplainsWithKey:(NSString*)key WithLeadID:(NSString*)leadId;

-(BOOL)updateComplainWithComplainOB:(DTOComplainObject*)complainOB;

-(BOOL) deleteComplainWithCasesId:(NSString *)casesId;

@end
