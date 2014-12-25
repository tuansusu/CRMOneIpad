//
//  UICGStep.h
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UICGStep : NSObject {
	NSDictionary *dictionaryRepresentation;

    NSString *distanceText;
    NSString *distanceValue;
    NSString *durationText;
    NSString *durationValue;
    CLLocation *startLocation;
    CLLocation *endLocation;
	NSInteger polylineIndex;
	NSString *htmlInstructions;
	NSString *polyline;
    NSString *travel_mode;
}

@property (nonatomic, retain, readonly) NSDictionary *dictionaryRepresentation;
@property (nonatomic, retain, readonly) NSDictionary *distance;
@property (nonatomic, retain, readonly) NSDictionary *duration;
@property (nonatomic, retain, readonly) CLLocation *startLocation;
@property (nonatomic, retain, readonly) CLLocation *endLocation;
@property (nonatomic, readonly) NSInteger polylineIndex;
@property (nonatomic, retain, readonly) NSString *htmlInstructions;
@property (nonatomic, retain, readonly) NSString *polyline;
@property (nonatomic, retain, readonly) NSString *travel_mode;

+ (UICGStep *)stepWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary;

@end
