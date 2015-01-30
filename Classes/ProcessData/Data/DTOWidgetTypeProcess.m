//
//  DTOWidgetTypeProcess.m
//  OfficeOneMB
//
//  Created by macpro on 1/20/15.
//
//

#import "DTOWidgetTypeProcess.h"

#import "DataUtil.h"

#import "DTOWidgetTypeObject.h"

#import "Items.h"

#define TABLENAME_DTOWIDGETTYPE @"dtoWidgetType"

@implementation DTOWidgetTypeProcess

-(NSMutableArray*) filter{
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ order by %@ asc",[[DTOWidgetTypeObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTOWIDGETTYPE, DTOWIDGET_widgetId];

    NSLog(@"query attach:%@", query);

    return [DataUtil BuilQueryGetListWithListFields:[DTOWidgetTypeObject allFields] selectQuery:query valueParameter:nil];
}

-(NSMutableArray*) filterWithKey : (NSString*) strKey withValue : (NSString*) strValue{
    NSString *query = [NSString stringWithFormat:@"Select %@ from %@ where %@  like '%@' order by %@ asc",[[DTOWidgetTypeObject allFields] componentsJoinedByString:@"," ] , TABLENAME_DTOWIDGETTYPE, strKey,strValue, DTOWIDGET_widgetId];

    NSLog(@"query = %@", query);

    return [DataUtil BuilQueryGetListWithListFields:[DTOWidgetTypeObject allFields] selectQuery:query valueParameter:[NSArray arrayWithObjects:nil]];
    
}

@end
