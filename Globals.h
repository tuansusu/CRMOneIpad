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
    typeGraphLine,
    typeGraphColumn
} TypeGraphs;

typedef enum {
    typeKHDM,
    typeKH360
} CustomerType;

//=============================Product Type========================

#define PRODUCT_TYPE_THANH_TOAN 1
#define PRODUCT_TYPE_TIN_DUNG 2
#define PRODUCT_TYPE_BAO_LANH 3
#define PRODUCT_TYPE_THANH_TOAN_QUOC_TE 4
#define PRODUCT_TYPE_THE 5
#define PRODUCT_TYPE_NGAN_HANG_DIEN_TU 6
#define PRODUCT_TYPE_TIET_KIEM 7
#define PRODUCT_TYPE_KIEU_HOI 8
#define PRODUCT_TYPE_ATM_POS 9
#define PRODUCT_TYPE_BANK_PLUS 10
#define PRODUCT_TYPE_DAI_TRA 11
#define PRODUCT_TYPE_DU_AN 12
#define PRODUCT_TYPE_LOI 13

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











