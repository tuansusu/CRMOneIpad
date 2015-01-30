//
//  DashboardTaskModel.h
//  OfficeOneMB
//
//  Created by macpro on 1/29/15.
//
//

#import <Foundation/Foundation.h>

#import "DTOTASKProcess.h"

#import "NSDictionary+QS.h"

@interface DashboardTaskModel : NSObject
{
    DTOTASKProcess *dtoProcess;
}

@property (nonatomic,readonly) NSMutableArray *listComplains;
@property (nonatomic,assign) NSInteger currentPage;

-(NSMutableArray*)getAllComplain;

-(void)getFirstPageWithKey:(NSString*)key WithLeadID:(NSString*)leadId;

-(void)getNextPageWithKey:(NSString*)key WithLeadID:(NSString*)leadId;

-(BOOL)updateComplainWithComplainOB:(DTOComplainObject*)complainOB;

-(BOOL) deleteComplainWithCasesId:(NSString *)casesId;

@end
