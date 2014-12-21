//
//  Items.h
//  Best Player iOS App
//
//  Created by Admin on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Items : NSObject
{
    NSMutableDictionary * itemDictionary;
    
}

@property (nonatomic, retain) NSMutableDictionary * itemDictionary;

- (id)initWithKeys:(NSArray*)keyArray;

- (id)valueForKey:(NSString*)key;

- (void)setValue:(id)value forKey:(NSString *)key;

- (NSArray*)allKeys;

- (NSArray*)allValues;

@end
