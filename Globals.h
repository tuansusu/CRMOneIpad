//
//  Globals.h
//  OfficeOneMB
//
//  Created by macpro on 12/28/14.
//
//

#ifndef OfficeOneMB_Globals_h
#define OfficeOneMB_Globals_h


#endif


typedef enum {
    typeGraphLine = 0,
    typeGraphColumnVertical =1,
    typeGraphColumnHorizontal =2,
    typeGraphFunnel =3
} TypeGraphs;

typedef enum {
    typeKHDM,
    typeKH360
} CustomerType;

#define MAX_ROW_A_PAGE 20
#define MAX_ROW_A_PAGE_IN_DASHBOARD 10

#define CORNER_RADIUS_BUTTON 5
#define CORNER_RADIUS_VIEW 20

//Lemon add 2013-09-05
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


//=============================Widget Type========================

#define WIDGET_TYPE_TONG_HOP 1
#define WIDGET_TYPE_HUY_DONG_VON 2
#define WIDGET_TYPE_TIN_DUNG 3
#define WIDGET_TYPE_BAO_LANH 4
#define WIDGET_TYPE_PTKH 5
#define WIDGET_TYPE_GHI_CHU 6
#define WIDGET_TYPE_DTTM_CO_HOI 7
#define WIDGET_TYPE_TKH_TIEN_GUI 8
#define WIDGET_TYPE_TKH_TIN_DUNG 9
#define WIDGET_TYPE_Y_KIEN_KH 10
#define WIDGET_TYPE_THEO_DOI 11
#define WIDGET_TYPE_SU_KIEN_SAP_DIEN_RA 12

//=============================Product Type========================

#define PRODUCT_TYPE_THANH_TOAN 100
#define PRODUCT_TYPE_TIN_DUNG 103
#define PRODUCT_TYPE_BAO_LANH 104
#define PRODUCT_TYPE_THANH_TOAN_QUOC_TE 105
#define PRODUCT_TYPE_THE 200
#define PRODUCT_TYPE_NGAN_HANG_DIEN_TU 400
#define PRODUCT_TYPE_TIET_KIEM 101
#define PRODUCT_TYPE_KIEU_HOI 106
#define PRODUCT_TYPE_ATM_POS 202
#define PRODUCT_TYPE_BANK_PLUS 500
#define PRODUCT_TYPE_DAI_TRA 300
#define PRODUCT_TYPE_DU_AN 301
#define PRODUCT_TYPE_LOI 302

//=============================Calendar Notification====================

#define CALENDAR_SELECTE_EVENT_NOTIFICATION @"calendarSelectedEventNotification"

//=============================Map Configuration========================
#define KEY_ROUTES_OF_DIRECTIONS_AT_INDEX @"routesOfDirectionAtIndex%d"

#define KEY_MARKER_KHDM @"khdmMarkerAtIndex%d"
#define KEY_MARKER_KH360 @"kh360MarkerAtIndex%d"

#define KEY_MARKER_STRING_KHDM @"khdmMarkerStringAtIndex%d"
#define KEY_MARKER_STRING_KH360 @"kh360MarkerStringAtIndex%d"

#define KEY_POLYLINE_KHDM @"khdmPolylineAtIndex%d"
#define KEY_POLYLINE_KH360 @"kh360PolylineAtIndex%d"

#define ICON_START_ROUTES_OF_DIRECTION @"iconArrowUp"
#define ICON_END_ROUTES_OF_DIRECTION @"iconMarker"

#define VEHICLES_SELECTED @"vehiclesSelected"
#define VEHICLES_DRIVING @"driving"
#define VEHICLES_CYCLING @"cycling"
#define VEHICLES_WALKING @"walking"

#define KEY_CURRENT_LOCATION @"currentLocation"


//=============================Maneuver Configuration========================

#define MANEUVER_KEY @"maneuverKey"

#define MANEUVER_TURN_SHARP_LEFT_KEY @"turn-sharp-left"
#define MANEUVER_TURN_SHARP_LEFT_VALUE @"iconTurnSharpLeft"

#define MANEUVER_TURN_SHARP_RIGHT_KEY @"turn-sharp-right"
#define MANEUVER_TURN_SHARP_RIGHT_VALUE @"iconTurnSharpRight"

#define MANEUVER_UTURN_LEFT_KEY @"uturn-left"
#define MANEUVER_UTURN_LEFT_VALUE @"iconUturnLeft"

#define MANEUVER_UTURN_RIGHT_KEY @"uturn-right"
#define MANEUVER_UTURN_RIGHT_VALUE @"iconUturnRight"

#define MANEUVER_TURN_SLIGHT_LEFT_KEY @"turn-slight-left"
#define MANEUVER_TURN_SLIGHT_LEFT_VALUE @"iconTurnSlightLeft"

#define MANEUVER_TURN_SLIGHT_RIGHT_KEY @"turn-slight-right"
#define MANEUVER_TURN_SLIGHT_RIGHT_VALUE @"iconTurnSlightRight"

#define MANEUVER_MERGE_KEY @"merge"
#define MANEUVER_MERGE_VALUE @"iconMerge"

#define MANEUVER_ROUND_ABOUT_LEFT_KEY @"roundabout-left"
#define MANEUVER_ROUND_ABOUT_LEFT_VALUE @"iconRoundAboutLeft"

#define MANEUVER_ROUND_ABOUT_RIGHT_KEY @"roundabout-right"
#define MANEUVER_ROUND_ABOUT_RIGHT_VALUE @"iconRoundAboutRight"

#define MANEUVER_TURN_LEFT_KEY @"turn-left"
#define MANEUVER_TURN_LEFT_VALUE @"iconTurnLeft"

#define MANEUVER_TURN_RIGHT_KEY @"turn-right"
#define MANEUVER_TURN_RIGHT_VALUE @"iconTurnRight"

#define MANEUVER_RAMP_RIGHT_KEY @"ramp-right"
#define MANEUVER_RAMP_RIGHT_VALUE @"iconRampRight"

#define MANEUVER_RAMP_LEFT_KEY @"ramp-left"
#define MANEUVER_RAMP_LEFT_VALUE @"iconRampLeft"

#define MANEUVER_FORK_RIGHT_KEY @"fork-right"
#define MANEUVER_FORK_RIGHT_VALUE @"iconForkRight"

#define MANEUVER_FORK_LEFT_KEY @"fork-left"
#define MANEUVER_FORK_LEFT_VALUE @"iconForkLeft"

#define MANEUVER_STRAIGHT_KEY @"straight"
#define MANEUVER_STRAIGHT_VALUE @"iconStraight"

#define MANEUVER_FERRY_KEY @"ferry"
#define MANEUVER_FERRY_VALUE @"iconFerry"

#define MANEUVER_FERRY_TRAIN_KEY @"ferry-train"
#define MANEUVER_FERRY_TRAIN_VALUE @"iconFerryTrain"

#define MANEUVER_KEEP_LEFT_KEY @"keep-left"
#define MANEUVER_KEEP_LEFT_VALUE @"iconKeepLeft"

#define MANEUVER_KEEP_RIGHT_KEY @"keep-right"
#define MANEUVER_KEEP_RIGHT_VALUE @"iconKeepRight"











