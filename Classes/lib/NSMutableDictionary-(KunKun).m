//
//  NSMutableDictionary-(KunKun).m
//  KunKun
//
//  Created by Viet Quoc on 12/2/11.
//  Copyright 2011 Viettel. All rights reserved.
//

#import "NSMutableDictionary-(KunKun).h"


@implementation NSMutableDictionary (MyCustomNSMutableDictionary)

-(void) setMyObject:(id)anObject forKey:(id)aKey {
	if (anObject && aKey) {
		[self setObject: anObject forKey: aKey];
	}
}

@end
