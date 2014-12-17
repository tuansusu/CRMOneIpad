//
//  MDDirectionService.h
//  OfficeOneMB
//
//  Created by macpro on 12/15/14.
//
//

#import <Foundation/Foundation.h>

@interface MDDirectionService : NSObject

- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector
              withDelegate:(id)delegate;
- (void)retrieveDirections:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSData *)data withSelector:(SEL)selector
       withDelegate:(id)delegate;

@end
