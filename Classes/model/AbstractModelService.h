//
//  AbstractModelService.h
//  KunKun
//
//  Created by Nguyen Quang Hieu on 12/6/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPObserver.h"
#import "ActionEvent.h"

@interface AbstractModelService : NSObject <HTTPObserver> {

}

-(void) sentModelRequest: (ActionEvent*) actionEvent ;

@end
