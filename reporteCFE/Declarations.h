//
//  Declarations.h
//  AlertaMX
//
//  Created by Walter on 08/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "TBXML.h"
#import "TBXML+HTTP.h"
#import "TBXML+Compression.h"

//Phone Memory
#define     pmmaMsgID           @"pmmaMsgID"
#define     pmmaSenderID        @"pmmaSenderID"
#define     pmmaSentTime        @"pmmaSentTime"
#define     pmmaMsgStatus       @"pmmaMsgStatus"
#define     pmmaMsgType         @"pmmaMsgType"
#define     pmmaSource          @"pmmaSource"
#define     pmmaScope           @"pmmaScope"
#define     pmmaRestriction     @"pmmaRestriction"
#define     pmmaAddresses       @"pmmaAddresses"
#define     pmmaHandlingCode    @"pmmaHandlingCode"
#define     pmmaNote            @"pmmaNote"
#define     pmmaReferenceIDs    @"pmmaReferenceIDs"
#define     pmmaIncidentIDs     @"pmmaIncidentIDs"
#define     pmmaLanguage        @"pmmaLanguage"
#define     pmmaCategory        @"pmmaCategory"
#define     pmmaEvent           @"pmmaEvent"
#define     pmmaResponseType    @"pmmaResponseType"
#define     pmmaUrgency         @"pmmaUrgency"
#define     pmmaSeverity        @"pmmaSeverity"
#define     pmmaCertainty       @"pmmaCertainty"
#define     pmmaAudience        @"pmmaAudience"
#define     pmmaEventCode       @"pmmaEventCode"
#define     pmmaEffective       @"pmmaEffective"
#define     pmmaOnset           @"pmmaOnset"
#define     pmmaExpires         @"pmmaExpires"
#define     pmmaSenderName      @"pmmaSenderName"
#define     pmmaHeadline        @"pmmaHeadline"
#define     pmmaDescription     @"pmmaDescription"
#define     pmmaInstruction     @"pmmaInstruction"
#define     pmmaWeb             @"pmmaWeb"
#define     pmmaContact         @"pmmaContact"
#define     pmmaParameter       @"pmmaParameter"
#define     pmmaParameterAll    @"pmmaParameterAll"
#define     pmmaResourceDesc    @"pmmaResourceDesc"
#define     pmmaMIMEType        @"pmmaMIMEType"
#define     pmmaFileSize        @"pmmaFileSize"
#define     pmmaURI             @"pmmaURI"
#define     pmmaDeferencedURI   @"pmmaDeferencedURI"
#define     pmmaDigest          @"pmmaDigest"
#define     pmmaAreaDesc        @"pmmaAreaDesc"
#define     pmmaAreaPolygon     @"pmmaAreaPolygon"
#define     pmmaAreaPolygonAll  @"mmaAreaPolygonAll"
#define     pmmaAreaPolygon2    @"pmmaAreaPolygon2"
#define     pmmaAreaCircle      @"pmmaAreaCircle"
#define     pmmaAreaGeocode     @"pmmaAreaGeocode"
#define     pmmaAltitude        @"pmmaAltitude"
#define     pmmaCeiling         @"pmmaCeiling"
#define     pmmaDirection       @"pmmaDirection"
#define     pmmaAuthor          @"pmmaAuthor"
#define     pmmaReviewer        @"pmmaReviewer"
#define     pmmaSemaphore       @"pmmaSemaphore"
#define     pmmaDistance        @"pmmaDistance"
#define     pmmaParameterCategory   @"pmmaParameterCategory"

#define     pmmaAlertUpdatedTime    @"pmmaAlertUpdatedTime"
#define     pmstrAlreadyRegistered  @"pmstrAlreadyRegistered"
#define     pmstrUserID             @"pmstrUserID"

//GeoJsons
#define     pmmaGeoJson         @"pmmaGeoJson"
#define     pmmaGeoJson0        @"pmmaGeoJson0"
#define     pmmaGeoJson1        @"pmmaGeoJson1"
#define     pmmaGeoJson2        @"pmmaGeoJson2"
#define     pmmaGeoJson3        @"pmmaGeoJson3"
#define     pmmaGeoJson4        @"pmmaGeoJson4"
#define     pmmaGeoJson5        @"pmmaGeoJson5"
#define     pmmaGeoJson6        @"pmmaGeoJson6"
#define     pmmaGeoJson7        @"pmmaGeoJson7"
#define     pmmaGeoJson8        @"pmmaGeoJson8"
#define     pmmaGeoJson9        @"pmmaGeoJson9"

//Colors
#define nRedGoogle100           colorWithRed:217/255.0 green:74/255.0 blue:56/255.0 alpha:1.00
#define nRedGoogle85            colorWithRed:217/255.0 green:74/255.0 blue:56/255.0 alpha:0.85
#define nLightGray85            colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.85
#define nBlack70                colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7
#define nRedMap                 colorWithRed:170/255.0 green:0/255.0 blue:0/255.0 alpha:0.5
#define nRedMap100              colorWithRed:170/255.0 green:0/255.0 blue:0/255.0 alpha:1.0

#define nBlueGoogle100          colorWithRed:74/255.0 green:139/255.0 blue:246/255.0 alpha:1.00
//#define nBlack70                colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7

//Constants
#define nScrollingDown          0
#define nScrollingUp            1
#define nTextEmpty              0
#define nTextNoEmpty            1

//Texts
#define     nNoInfoText         @"No hay información"

//URLS
#define     nURLCAP1            @"https://correo1.conagua.gob.mx/feedsmn/feedalert.aspx"
#define     nURLCAP2            @"http://ec2-54-191-42-137.us-west-2.compute.amazonaws.com/user/conagua"

//Title: Hundimientos
#define     nURLGeoJson0        @"http://www.anr.gob.mx:6081/adaptor/rest/services/ANR/GoogleCrisis/MapServer/exts/GeoJSONServer/GeoJSON?query=1=1&layer=4&f=geojson"
//Title: Deslizamientos
#define     nURLGeoJson1        @"http://www.anr.gob.mx:6081/adaptor/rest/services/ANR/GoogleCrisis/MapServer/exts/GeoJSONServer/GeoJSON?query=1=1&layer=3&f=geojson"
//Title: Tsunamis
#define     nURLGeoJson2        @"http://www.anr.gob.mx:6081/adaptor/rest/services/ANR/GoogleCrisis/MapServer/exts/GeoJSONServer/GeoJSON?query=1=1&layer=2&f=geojson"
//Title: Volcanes
#define     nURLGeoJson3        @"http://www.anr.gob.mx:6081/adaptor/rest/services/ANR/GoogleCrisis/MapServer/exts/GeoJSONServer/GeoJSON?query=1=1&layer=0&f=geojson"
//Title: Cenizas
#define     nURLGeoJson4        @"http://www.anr.gob.mx:6081/adaptor/rest/services/ANR/GoogleCrisis/MapServer/exts/GeoJSONServer/GeoJSON?query=1=1&layer=1&f=geojson"

//User
#define     nMan                @"1"
#define     nWoman              @"2"
#define     nChild              @"3"
#define     nPregnant           @"4"
#define     nHandicap           @"5"

//Arrays for XML
extern  NSMutableArray      *mmaMsgID;
extern  NSMutableArray      *mmaSenderID;
extern  NSMutableArray      *mmaSentTime;
extern  NSMutableArray      *mmaMsgStatus;
extern  NSMutableArray      *mmaMsgType;
extern  NSMutableArray      *mmaSource;
extern  NSMutableArray      *mmaScope;
extern  NSMutableArray      *mmaRestriction;
extern  NSMutableArray      *mmaAddresses;
extern  NSMutableArray      *mmaHandlingCode;
extern  NSMutableArray      *mmaNote;
extern  NSMutableArray      *mmaReferenceIDs;
extern  NSMutableArray      *mmaIncidentIDs;

//Info
extern  NSMutableArray      *mmaLanguage;
extern  NSMutableArray      *mmaCategory;
extern  NSMutableArray      *mmaEvent;
extern  NSMutableArray      *mmaResponseType;
extern  NSMutableArray      *mmaUrgency;
extern  NSMutableArray      *mmaSeverity;
extern  NSMutableArray      *mmaCertainty;
extern  NSMutableArray      *mmaAudience;
extern  NSMutableArray      *mmaEventCode;
extern  NSMutableArray      *mmaEffective;
extern  NSMutableArray      *mmaOnset;
extern  NSMutableArray      *mmaExpires;
extern  NSMutableArray      *mmaSenderName;
extern  NSMutableArray      *mmaHeadline;
extern  NSMutableArray      *mmaDescription;
extern  NSMutableArray      *mmaInstruction;
extern  NSMutableArray      *mmaWeb;
extern  NSMutableArray      *mmaContact;
extern  NSMutableArray      *mmaParameter;
extern  NSMutableArray      *mmaParameterAll;

//Resource
extern  NSMutableArray      *mmaResourceDesc;
extern  NSMutableArray      *mmaMIMEType;
extern  NSMutableArray      *mmaFileSize;
extern  NSMutableArray      *mmaURI;
extern  NSMutableArray      *mmaDeferencedURI;
extern  NSMutableArray      *mmaDigest;

//Area
extern  NSMutableArray      *mmaAreaDesc;
extern  NSMutableArray      *mmaAreaPolygon;
extern  NSMutableArray      *mmaAreaPolygonAll;
extern  NSMutableArray      *mmaAreaPolygon2;
extern  NSMutableArray      *mmaAreaCircle;
extern  NSMutableArray      *mmaAreaGeocode;
extern  NSMutableArray      *mmaAltitude;
extern  NSMutableArray      *mmaCeiling;

//Sub Arrays
extern  NSMutableArray      *mmaDirection;
extern  NSMutableArray      *mmaAuthor;
extern  NSMutableArray      *mmaReviewer;
extern  NSMutableArray      *mmaSemaphore;
extern  NSMutableArray      *mmaParameterCategory;
extern  NSMutableArray      *mmaDistance;

//GeoJsons
extern NSMutableArray      *mmaGJType[10];
extern NSMutableArray      *mmaGJFeatures[10];
extern NSMutableArray      *mmaGJFtType[10];
extern NSMutableArray      *mmaGJFtGeometry[10];
extern NSMutableArray      *mmaGJFtGeometryType[10];
extern NSMutableArray      *mmaGJFtGeometryCoord[10];
extern NSMutableArray      *mmaGJFtProp[10];

//Application
extern UIApplication       *mApp;

//BOOL
extern BOOL                mboAlreadyRegistered;
extern BOOL                mboFirstLoad;

//Int
extern  int                         mintReqIndex;

extern  CLLocationManager   *mlocationManager;
extern  CLLocation          *mlocation;

extern  float               mlatitude;
extern  float               mlongitude;

//NSDictionary
extern  NSDictionary        *mGeoJson[10];
extern  NSDictionary        *mJSRegister;
extern  NSDictionary        *mJSFamily;

//NSMutableArray
extern  NSMutableArray      *mmaAlertsCAPSNames;
extern  NSMutableArray      *mmaRiskZoneItems;

extern  NSMutableArray      *mmaFamilyMembers;
extern  NSMutableArray      *mmaFamilyMembersName;
extern  NSMutableArray      *mmaFamilyMembersStatus;
extern  NSMutableArray      *mmaFamilyMembersMobile;
extern  NSMutableArray      *mmaFamilyMembersTime;
extern  NSMutableArray      *mmaFamilyMembersType;

//NSString
extern  NSString            *mstrUrlCAPS[10];
extern  NSString            *mstrUserName;
extern  NSString            *mstrUserMobile;
extern  NSString            *mstrUserPushToken;
extern  NSString            *mstrUserType;
extern  NSString            *mstrUserID;
extern  NSString            *mstrFamilyMobile;

//Storyboard
extern  UIStoryboard        *mStoryboard;

//Unsigned int
extern  unsigned int        muiTotalAlertCAPS;
extern  unsigned int        muiTotalRiskZonesItems;

//User Defaults
extern  NSUserDefaults      *mUserDefaults;

@interface Declarations : NSObject
- (void) postGetGeoJson:(id)uiItem;
- (void) loadGetGeoJson:(id)uiItem;
- (void) loadRegister;
- (void) postRegister;
- (void) postAddFamily;
- (void) loadAddFamily;
- (void) loadGetFamily;
- (void) postGetFamily;

@end
