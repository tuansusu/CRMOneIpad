//
//  ActionEvent.h
//  KunKun
//
//  Created by Nguyen Quang Hieu on 11/24/10.
//  Copyright 2010 Viettel. All rights reserved.
//

#import <Foundation/Foundation.h>


enum ActionEventEnum {
	none,
    login,
    logout,
    sync_get_sysorganization,
    sync_get_account,
    sync_get_group,
    sync_get_industry,
    sync_get_employee,
    sync_get_lead,
    sync_get_accountCrosssell,
    sync_get_leadCrosssell,
    sync_get_contact,
    sync_get_oppContact,
    sync_get_accContact,
    sync_get_leadContact,
    sync_get_oppCompetitor,
    sync_get_competitor,
    sync_get_industryAccount,
    sync_get_industryLead,
    sync_get_employeeAccount,
    sync_get_relationship,
    sync_get_accRelationship,
    sync_get_leadRelationship,
    sync_get_relationshipType,
    sync_get_rmDailyKh,
    sync_get_orgType,
    sync_get_rmDailyCard,
    sync_get_rmDailyThanhtoan,
    sync_get_rmDailyTietkiem,
    sync_get_rmDailyTindung,
    sync_get_rmMonthlyHdv,
    sync_get_rmMonthlyTindung
    
    
};

@interface ActionEvent : NSObject {
	NSString *_textSender;
	NSString *_json;
	enum ActionEventEnum action;
	BOOL cancel;
	NSInteger tag;
	int request;
	id _viewData;
	id _sender;
	id _userData;
    NSString *_methodName;
}
@property(nonatomic, retain) NSString *textSender;
@property(nonatomic, retain) NSString *json;
@property(nonatomic, assign) enum ActionEventEnum action;
@property(nonatomic, assign) NSInteger tag;
@property(nonatomic, assign) int request;
@property(nonatomic, assign) BOOL cancel;
@property(nonatomic, retain) id viewData;
@property(nonatomic, retain) id sender;
@property(nonatomic, retain) id userData;
@property(nonatomic, retain) id tempData;
@property(nonatomic, retain) NSDate *timeSend;
@property(nonatomic, retain) NSString *methodName;

@end
