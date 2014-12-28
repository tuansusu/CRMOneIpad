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

#define KEY_ROUTES_OF_DIRECTIONS_AT_INDEX @"routesOfDirectionAtIndex%d"

#define KEY_MARKER_KHDM @"khdmMarkerAtIndex%d"
#define KEY_MARKER_KH360 @"kh360MarkerAtIndex%d"

#define KEY_MARKER_STRING_KHDM @"khdmMarkerStringAtIndex%d"
#define KEY_MARKER_STRING_KH360 @"kh360MarkerStringAtIndex%d"

#define KEY_POLYLINE_KHDM @"khdmPolylineAtIndex%d"
#define KEY_POLYLINE_KH360 @"kh360PolylineAtIndex%d"

#define ICON_START_ROUTES_OF_DIRECTION @"iconArrowUp"
#define ICON_END_ROUTES_OF_DIRECTION @"iconMarker"