//
//  DTOWidgetProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/18/15.
//
//

#import "DTOWidgetProcess.h"

#import "DataUtil.h"

#import "DTOWidgetObject.h"

#import "Items.h"

#define TABLENAME_DTODASHBOARDCONFIGURATION @"dtoDashboardConfiguration"

@implementation DTOWidgetProcess

-(NSMutableArray*) filter{
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status=1 order by %@ asc",[[DTOWidgetObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTODASHBOARDCONFIGURATION, DTOWIDGET_confId];

    NSLog(@"query attach:%@", query);

    return [DataUtil BuilQueryGetListWithListFields:[DTOWidgetObject allFields] selectQuery:query valueParameter:nil];
}


-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where status=1 and %@  like '%@' order by %@ asc",[[DTOWidgetObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTODASHBOARDCONFIGURATION, strKey,strValue, DTOWIDGET_confId];

    NSLog(@"query = %@", query);

    return [DataUtil BuilQueryGetListWithListFields:[DTOWidgetObject allFields] selectQuery:query valueParameter:[NSArray arrayWithObjects:nil]];

}

-(BOOL) insertToDBWithEntity:(NSMutableDictionary*) entity{

    if ([[entity allKeys] containsObject:DTOWIDGET_confId]) {
        return [self updateToDBWithEntity:entity];
    }

    return [super addToDBWithTableName:TABLENAME_DTODASHBOARDCONFIGURATION dictionary:entity];

}

-(BOOL) updateToDBWithEntity:(NSMutableDictionary*) entity{

    NSDictionary *dicCondition = [[NSDictionary alloc]initWithObjectsAndKeys:[entity objectForKey:DTOWIDGET_confId] , DTOWIDGET_confId, nil];

    return [super updateToTableName:TABLENAME_DTODASHBOARDCONFIGURATION withFields:entity withCondition:dicCondition];

}

-(BOOL) deleteEntityWithConfId:(NSString *)confId{

    NSMutableDictionary *dicFieldSet = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0", nil] forKeys:[NSArray arrayWithObjects:DTOWIDGET_status, nil]];
    NSMutableDictionary *dicFieldCondition = [[NSMutableDictionary alloc]initWithObjects:[NSArray arrayWithObjects:confId, nil] forKeys:[NSArray arrayWithObjects:DTOWIDGET_confId, nil]];

    return [super updateToTableName:TABLENAME_DTODASHBOARDCONFIGURATION withFields:dicFieldSet withCondition:dicFieldCondition];
}


@end
