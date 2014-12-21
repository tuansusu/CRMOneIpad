//
//  Items.m
//  Best Player iOS App
//
//  Created by Admin on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Items.h"

@implementation Items

@synthesize itemDictionary;

- (id)init
{
    self = [super init];
    if (self) {
        itemDictionary = [[NSMutableDictionary alloc] initWithObjects:nil forKeys:nil];
    }
    
    return self;
}

- (id)initWithKeys:(NSArray*)keyArray
{
    self = [super init];
    if (self) {
        NSMutableArray * valueArray = [[NSMutableArray alloc] init] ;
        
        for (int i = 0; i < keyArray.count; i++) {
            [valueArray addObject:@""];
        }
        
        itemDictionary = [[NSMutableDictionary alloc] initWithObjects:valueArray forKeys:keyArray];
    }
    return self;
}

- (id)valueForKey:(NSString *)key
{
    return [itemDictionary valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [itemDictionary setValue:value forKey:key];
}

- (NSArray*)allKeys
{
    return [itemDictionary allKeys];
}

- (NSArray*)allValues
{
    return [itemDictionary allValues];
}

@end