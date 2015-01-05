//
//  UICGRoute.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGRoute.h"

@implementation UICGRoute

@synthesize dictionaryRepresentation;
@synthesize numerOfSteps;
@synthesize steps;
@synthesize distance;
@synthesize duration;
@synthesize summaryHtml;
@synthesize startGeocode;
@synthesize endGeocode;
@synthesize endLocation;
@synthesize polylineEndIndex;

+ (UICGRoute *)routeWithDictionaryRepresentation:(NSDictionary *)dictionary {
	UICGRoute *route = [[UICGRoute alloc] initWithDictionaryRepresentation:dictionary];
	return route;
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
	self = [super init];
	if (self != nil) {
      
		NSArray *stepDics = [dictionary objectForKey:@"steps"];
		numerOfSteps = [stepDics count];
		steps = [[NSMutableArray alloc] initWithCapacity:numerOfSteps];
		for (NSDictionary *stepDic in stepDics) {
			[(NSMutableArray *)steps addObject:[UICGStep stepWithDictionaryRepresentation:stepDic]];
		}
		
		distance = [dictionary objectForKey:@"distance"];
		duration = [dictionary objectForKey:@"duration"];
        
        _startAddress = [dictionary objectForKey:@"start_address"];
        _endAddress = [[dictionary objectForKey:@"end_address"] description];
        
        NSDictionary *startLocationDic = [dictionary objectForKey:@"start_location"];
        CLLocationDegrees startLongitude = [[startLocationDic objectForKey:@"lat"] doubleValue];
        CLLocationDegrees startLatitude  = [[startLocationDic objectForKey:@"lng"] doubleValue];
        _startLocation = [[CLLocation alloc] initWithLatitude:startLatitude longitude:startLongitude];
        
		NSDictionary *endLocationDic = [dictionary objectForKey:@"end_location"];
		CLLocationDegrees endLongitude = [[endLocationDic objectForKey:@"lat"] doubleValue];
		CLLocationDegrees endLatitude  = [[endLocationDic objectForKey:@"lng"] doubleValue];
		endLocation = [[CLLocation alloc] initWithLatitude:endLatitude longitude:endLongitude];
	}
	return self;
}

- (UICGStep *)stepAtIndex:(NSInteger)index {
	return [steps objectAtIndex:index];;
}

@end
