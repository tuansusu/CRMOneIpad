//
//  MapsModel.m
//  OfficeOneMB
//
//  Created by Pham Ngoc Hoang on 12/20/14.
//
//

#import "MapsModel.h"
#import "NSDictionary+QS.h"
#import "Globals.h"

@implementation MapsModel

-(id)init{
    self = [super init];

    if(self){
        _listCustomerKHDM= [[NSMutableArray alloc] init];
        dtoLeadProcess = [DTOACCOUNTLEADProcess new];

        dtoProcess = [DTOACCOUNTProcess new];
        _listCustomerKH360= [[NSMutableArray alloc] init];
        _currentPageKH360 = 1;
        _currentPageKHDM = 1;
        [self initManeuverDic];
    }
    return self;
}


-(void)initManeuverDic{
    maneuverDic = [[NSMutableDictionary alloc] init];
    [maneuverDic setValue:MANEUVER_TURN_SHARP_LEFT_VALUE forKey:MANEUVER_TURN_SHARP_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_TURN_SHARP_RIGHT_VALUE forKey:MANEUVER_TURN_SHARP_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_UTURN_LEFT_VALUE forKey:MANEUVER_UTURN_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_UTURN_RIGHT_VALUE forKey:MANEUVER_UTURN_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_TURN_SLIGHT_LEFT_VALUE forKey:MANEUVER_TURN_SLIGHT_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_TURN_SLIGHT_RIGHT_VALUE forKey:MANEUVER_TURN_SLIGHT_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_MERGE_VALUE forKey:MANEUVER_MERGE_KEY];

    [maneuverDic setValue:MANEUVER_ROUND_ABOUT_LEFT_VALUE forKey:MANEUVER_ROUND_ABOUT_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_ROUND_ABOUT_RIGHT_VALUE forKey:MANEUVER_ROUND_ABOUT_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_TURN_LEFT_VALUE forKey:MANEUVER_TURN_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_TURN_RIGHT_VALUE forKey:MANEUVER_TURN_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_RAMP_RIGHT_VALUE forKey:MANEUVER_RAMP_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_RAMP_LEFT_VALUE forKey:MANEUVER_RAMP_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_FORK_RIGHT_VALUE forKey:MANEUVER_FORK_RIGHT_KEY];

    [maneuverDic setValue:MANEUVER_FORK_LEFT_VALUE forKey:MANEUVER_FORK_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_STRAIGHT_VALUE forKey:MANEUVER_STRAIGHT_KEY];

    [maneuverDic setValue:MANEUVER_FERRY_VALUE forKey:MANEUVER_FERRY_KEY];

    [maneuverDic setValue:MANEUVER_FERRY_TRAIN_VALUE forKey:MANEUVER_FERRY_TRAIN_KEY];

    [maneuverDic setValue:MANEUVER_KEEP_LEFT_VALUE forKey:MANEUVER_KEEP_LEFT_KEY];

    [maneuverDic setValue:MANEUVER_KEEP_RIGHT_VALUE forKey:MANEUVER_KEEP_RIGHT_KEY];
    [[NSUserDefaults standardUserDefaults] setObject:maneuverDic forKey:MANEUVER_KEY];
}

-(void)getFirstPageCustomerKHDMWithKey:(NSString*)key{
    [_listCustomerKHDM removeAllObjects];
    _currentPageKHDM =1;
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr =  [dtoLeadProcess filter];
    }else{
        resultArr = [dtoLeadProcess filterWithKey:DTOLEAD_name withValue:key];
    }

    if (resultArr.count>MAX_ROW_A_PAGE) {
        for (int i=0;i<MAX_ROW_A_PAGE;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listCustomerKHDM addObject:[dic dtoAcountLeadProcessOb]];
        }
    }else{
        for (NSDictionary *dic in resultArr) {
            [_listCustomerKHDM addObject:[dic dtoAcountLeadProcessOb]];
        }
    }

}
-(void)getNextPageCustomerKHDMWithKey:(NSString*)key{

    int currentPage = _currentPageKHDM;
    int nextPage = ++_currentPageKHDM;

    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr =  [dtoLeadProcess filter];
    }else{
        resultArr = [dtoLeadProcess filterWithKey:DTOLEAD_name withValue:key];
    }

    NSInteger totalPage =resultArr.count/MAX_ROW_A_PAGE;
    if (totalPage>currentPage) {
        for (int i=MAX_ROW_A_PAGE*currentPage;i<MAX_ROW_A_PAGE*nextPage;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listCustomerKHDM addObject:[dic dtoAcountLeadProcessOb]];
        }
    }else {
        if((resultArr.count - currentPage*MAX_ROW_A_PAGE)>0){
            for (int i=MAX_ROW_A_PAGE*currentPage;i<resultArr.count;i++) {
                NSDictionary *dic = [resultArr objectAtIndex:i];
                [_listCustomerKHDM addObject:[dic dtoAcountLeadProcessOb]];
            }
        }else{
            return;
        }
    }
}

-(void)getFirstPageCustomerKH360WithKey:(NSString*)key{
    [_listCustomerKH360 removeAllObjects];
    _currentPageKH360 = 1;
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr = [dtoProcess filter];
    }else{
        resultArr = [dtoProcess filterWithKey:DTOACCOUNT_name withValue:key];
    }
    if (resultArr.count>MAX_ROW_A_PAGE) {
        for (int i=0;i<MAX_ROW_A_PAGE;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listCustomerKH360 addObject:[dic dtoAcountProcessOb]];
        }
    }else{
        for (NSDictionary *dic in resultArr) {
            [_listCustomerKH360 addObject:[dic dtoAcountProcessOb]];
        }
    }
}
-(void)getNextPageCustomerKH360WithKey:(NSString*)key{
    int currentPage = _currentPageKH360;
    int nextPage = ++_currentPageKH360;
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];

    if ([key isEqualToString:@""]) {
        resultArr = [dtoProcess filter];
    }else{
        resultArr = [dtoProcess filterWithKey:DTOACCOUNT_name withValue:key];
    }
    
    NSInteger totalPage =resultArr.count/MAX_ROW_A_PAGE;
    if (totalPage>currentPage) {
        for (int i=MAX_ROW_A_PAGE*currentPage;i<MAX_ROW_A_PAGE*nextPage;i++) {
            NSDictionary *dic = [resultArr objectAtIndex:i];
            [_listCustomerKH360 addObject:[dic dtoAcountProcessOb]];
        }
    }else {
        if((resultArr.count - currentPage*MAX_ROW_A_PAGE)>0){
            for (int i=MAX_ROW_A_PAGE*currentPage;i<resultArr.count;i++) {
                NSDictionary *dic = [resultArr objectAtIndex:i];
                [_listCustomerKH360 addObject:[dic dtoAcountProcessOb]];
            }
        }else{
            return;
        }
    }
}


@end
