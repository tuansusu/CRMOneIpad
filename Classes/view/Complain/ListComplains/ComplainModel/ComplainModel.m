//
//  ComplainModel.m
//  OfficeOneMB
//
//  Created by macpro on 1/4/15.
//
//

#import "ComplainModel.h"
#import "Globals.h"
#import "Items.h"

@implementation ComplainModel
-(id)init{
    self = [super init];

    if(self){
        _listComplains= [[NSMutableArray alloc] init];
        dtoComplainProcess = [DTOComplainProcess new];
    }
    return self;
}

-(void)getFirstPagePageComplainsWithKey:(NSString*)key WithLeadID:(NSString*)leadId{
    [_listComplains removeAllObjects];
    _currentPage =1;
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr =  [dtoComplainProcess filterWithLeadId:leadId];
    }else{
        resultArr = [dtoComplainProcess filterWithLeadId:leadId WithKey:DTOCOMPLAIN_content withValue:key];
    }

    if (resultArr.count>MAX_ROW_A_PAGE) {
        for (int i=0;i<MAX_ROW_A_PAGE;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listComplains addObject:[dic dtoComplainObject]];
        }
    }else{
        for (NSDictionary *dic in resultArr) {
            [_listComplains addObject:[dic dtoComplainObject]];
        }
    }

}
-(void)getNextPageComplainsWithKey:(NSString*)key WithLeadID:(NSString*)leadId{

    int currentPage = _currentPage;
    int nextPage = ++_currentPage;

    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr =  [dtoComplainProcess filterWithLeadId:leadId];
    }else{
        resultArr = [dtoComplainProcess filterWithLeadId:leadId WithKey:DTOCOMPLAIN_content withValue:key];
    }

    NSInteger totalPage =resultArr.count/MAX_ROW_A_PAGE;
    if (totalPage>currentPage) {
        for (int i=MAX_ROW_A_PAGE*currentPage;i<MAX_ROW_A_PAGE*nextPage;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listComplains addObject:[dic dtoComplainObject]];
        }
    }else {
        if((resultArr.count - currentPage*MAX_ROW_A_PAGE)>0){
            for (int i=MAX_ROW_A_PAGE*currentPage;i<resultArr.count;i++) {
                NSDictionary *dic = [resultArr objectAtIndex:i];
                [_listComplains addObject:[dic dtoComplainObject]];
            }
        }else{
            return;
        }
    }
}

-(BOOL)updateComplainWithComplainOB:(DTOComplainObject*)complainOB{
    Items *items = [complainOB itemObject];
    NSMutableDictionary * complainDic = [items itemDictionary];
        return [dtoComplainProcess insertToDBWithEntity:complainDic];
}


-(BOOL) deleteComplainWithCasesId:(NSString *)casesId{
    return [dtoComplainProcess deleteEntityWithCasesId:casesId];
}
@end
