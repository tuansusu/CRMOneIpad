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
    getListDocument,
    getUnreadDocumentCount,
    getAllDocumentCount,
    showListDocument,
    getDocumentDetail,
    getQuickSearch,
    showMainView,
    getListTreeGroup,
    showListTreeGroup,
    getListTreeUser,
    showListTreeUser,
    getListMyMeeting,
    getListStaffGroupByParentId,
    searchListStaff,
    getListNotice,
    staffIsCorrectOldPassord, //kiem tra xem mat khau cu co giong mat khau moi ?
    staffSaveChangePassword, //thay doi mat khau
    getTaskGiveByLeaderCount,
    getTaskGiveByMeCount,
    getTaksGroupByDeptCount,
    getMyTaskCount,
    saveChangePassword,
    searchMyTask,
    searchTaskByICreate,
    searchTaskByGroup,
    showTaskByGroup,
    searchTaskByLeader,
    showTaskByLeader,
    getTaskDetail,
    getTaskHistory, //lay lich su xu ly cong viec
    moveTask, //chuyen xu ly cong viec
    replyTask, //phan hoi cong viec
    showTaskDetail,
    getUmTaskComment,
    showUmTaskComment,
    getTaskComment,
    showTaskComment,
    getAllChildTask,
    showAllChildTask,
    getUmTaskRequest,
    showUmTaskRequest,
    createTask,
    updateTask,
    createUmTask,
    sendDocumentToStaff,
    sendDocumentToGroup,
    getListStaffDoc,
    getSearchListStaff,
    getTreeGroup,
    updateTaskProcess,
    updateUmTaskProcess,
    createUmTaskRequest,
    isUpdateProgress,
    isEditedTask,
    deleteUmtask,
    deleteTask,
    getListTaskFromDoc,
    countText,
    showCountText,
    searchText,
    getDetail,
    actionDigitalDocument,
    rejectSignDocumentAction,
    getListLeaderFromAssistant,
    denyApproveTask,
    approveTask,
    getParentTaskDetail,
    errorCode = 404,
    searchStaffMgroup,
    getRoleDocumentSend,
    getTasks,
    getDocumentSignByUser,
    getCountDocumentSignInfo,
    getDetailDocumentSignInfo,
    processDocument, //xu ly van ban
    confirmDocument, // xac nhan xu ly van ban
    rejectSignDocumentInfo,
    getListMyTask,
    createOrEditTask,
    countHomeData,
    getListDocumentInUserNoRead,
    updateStatusConfirm,
    getConfigByKey,
    getPermission,
    updateReadDocument,
    normalDocumentSignInfo
    //tim kiem theo nhieu don vi
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
enum TypeOfDatabase{
    TypeOfDatabase_Bussiness,
    TypeOfDatabase_Tech
};
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
