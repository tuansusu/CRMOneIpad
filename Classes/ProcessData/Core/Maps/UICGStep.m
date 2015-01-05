//
//  UICGStep.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGStep.h"
#import "StringRemoval.h"

@implementation UICGStep

@synthesize dictionaryRepresentation;
@synthesize distanceText,distanceValue;
@synthesize durationText,durationValue;
@synthesize startLocation,endLocation;
@synthesize polylineIndex,polyline;
@synthesize htmlInstructions;
@synthesize travel_mode;
@synthesize maneuver;

+ (UICGStep *)stepWithDictionaryRepresentation:(NSDictionary *)dictionary {
	UICGStep *step = [[UICGStep alloc] initWithDictionaryRepresentation:dictionary];
	return step;
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
	self = [super init];
	if (self != nil) {
		NSDictionary *distanceDic = [dictionary objectForKey:@"distance"];
        if ([distanceDic valueForKey:@"text"]) {
            distanceText = [distanceDic valueForKey:@"text"];
        }
        if ([distanceDic valueForKey:@"value"]) {
            distanceValue = [distanceDic valueForKey:@"value"];
        }
        NSDictionary *durationDic = [dictionary objectForKey:@"duration"];
        if ([durationDic valueForKey:@"text"]) {
            durationText = [durationDic valueForKey:@"text"];
        }
        if ([durationDic valueForKey:@"value"]) {
            durationValue = [durationDic valueForKey:@"value"];
        }
        
        NSDictionary *startLocationDic = [dictionary objectForKey:@"start_location"];
        CLLocationDegrees startLatitude;
        CLLocationDegrees startLongitude;
        if ([startLocationDic valueForKey:@"lat"]) {
            startLatitude  = [[startLocationDic valueForKey:@"lat"] doubleValue];
        }
        if ([startLocationDic valueForKey:@"lng"]) {
            startLongitude = [[startLocationDic valueForKey:@"lng"] doubleValue];
        }
        startLocation = [[CLLocation alloc] initWithLatitude:startLatitude longitude:startLongitude] ;
        
        NSDictionary *endLocationDic = [dictionary objectForKey:@"end_location"];
        CLLocationDegrees endLatitude;
        CLLocationDegrees endLongitude;
        if ([endLocationDic valueForKey:@"lat"]) {
            endLatitude  = [[endLocationDic valueForKey:@"lat"] doubleValue];
        }
		if ([endLocationDic valueForKey:@"lng"]) {
            endLongitude = [[endLocationDic valueForKey:@"lng"] doubleValue];
        }
		endLocation = [[CLLocation alloc] initWithLatitude:endLatitude longitude:endLongitude] ;
		
        if ([dictionary objectForKey:@"html_instructions"]) {
            htmlInstructions = [[[dictionary objectForKey:@"html_instructions"]description] stringByStrippingHTML];
        }
		
        if ([dictionary valueForKey:@"maneuver"]) {
            maneuver = [dictionary valueForKey:@"maneuver"];
        }
	}
	return self;
}


@end
