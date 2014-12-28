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

}

@property (nonatomic, retain, readonly) NSDictionary *dictionaryRepresentation;

@property (nonatomic, retain, readonly) NSString *distanceText;
@property (nonatomic, retain, readonly) NSString *distanceValue;
@property (nonatomic, retain, readonly) NSString *durationText;
@property (nonatomic, retain, readonly) NSString *durationValue;
@property (nonatomic, retain, readonly) CLLocation *startLocation;
@property (nonatomic, retain, readonly) CLLocation *endLocation;
@property (nonatomic, assign) NSInteger polylineIndex;
@property (nonatomic, retain, readonly) NSString *htmlInstructions;
@property (nonatomic, retain, readonly) NSString *polyline;
@property (nonatomic, retain, readonly) NSString *travel_mode;
@property (nonatomic, retain, readonly) NSString *maneuver;

+ (UICGStep *)stepWithDictionaryRepresentation:(NSDictionary *)dictionary;
- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary;

@end
