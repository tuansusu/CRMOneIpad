//
//  ModelEvent.h
//  KunKun
//
//  Created by Nguyen Quang Hieu on 11/24/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionEvent.h"

@interface ModelEvent : NSObject {
	ActionEvent *actionEvent;
	id modelData;
	int modelCode;
	NSString *modelMessage;
	int bankErrorCode;
}


@property (nonatomic, retain) ActionEvent *actionEvent;
@property (nonatomic, retain) id modelData;
@property (nonatomic, retain) NSString *modelMessage;
@property (nonatomic, assign) int modelCode;
@property (nonatomic, assign) int bankErrorCode;
@end
