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
#import <AWSRuntime/AWSRuntime.h>
#import <AWSS3/AWSS3.h>

//AWS
#define nAWSAccessKeyID     @"AKIAICY3725B4Q7AMUNQ"
#define nAWSSecretKey       @"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"

//Phone Memory
#define     pmstrAlreadyRegistered  @"pmstrAlreadyRegistered"
#define     pmstrUserID             @"pmstrUserID"
#define     pmstrPlaces             @"pmstrPlaces"
#define     pmstrLogin              @"pmstrLogin"
#define     pmstrSetReport          @"pmstrSetReport"
#define     pmstrGetUserReport      @"pmstrGetUserReport"

//Colors
#define nRedGoogle100           colorWithRed:217/255.0 green:74/255.0 blue:56/255.0 alpha:1.00
#define nRedGoogle85            colorWithRed:217/255.0 green:74/255.0 blue:56/255.0 alpha:0.85
#define nLightGray85            colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.85
#define nBlack70                colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7
#define nRedMap                 colorWithRed:170/255.0 green:0/255.0 blue:0/255.0 alpha:0.5
#define nRedMap100              colorWithRed:170/255.0 green:0/255.0 blue:0/255.0 alpha:1.0

#define nBlueGoogle100          colorWithRed:74/255.0 green:139/255.0 blue:246/255.0 alpha:1.00
#define nGreenGoogle100         colorWithRed:10/255.0 green:161/255.0 blue:93/255.0 alpha:1.00

//Constants
#define nScrollingDown          0
#define nScrollingUp            1
#define nTextEmpty              0
#define nTextNoEmpty            1

//Texts
#define     nNoInfoText         @"No hay información"

//URLS
//Types
#define     nFalla                      @"1"
#define     nQueja                      @"2"

//Subtypes
#define     nNoHayLuzCasa               @"1"
#define     nNoHayLuzCuadra             @"2"
#define     nVariacionVoltajeCasa       @"3"
#define     nVariacionVoltajeCuadra     @"4"
#define     nCFEMaticoNoFunciona        @"5"

#define     nAltoConsumoRecibo          @"1"
#define     nMalaAtencionCAC            @"2"
#define     nExtorsionCorrupcion        @"3"
#define     nOtros                      @"4"

//Status
#define     nStatusPending              @"1"
#define     nStatusInProgress           @"2"
#define     nStatusSolved               @"3"
#define     nStatusClosed               @"4"

//Application
extern UIApplication       *mApp;

//BOOL
extern BOOL                 mboAlreadyRegistered;
extern BOOL                 mboFirstLoad;

extern  CLLocationManager   *mlocationManager;
extern  CLLocation          *mlocation;

extern  float               mlatitude;
extern  float               mlongitude;

//NSDictionary
extern  NSDictionary        *mJsonLogin;
extern  NSMutableArray      *mmaReports;
extern  NSMutableArray      *mmaReportsDate;
extern  NSMutableArray      *mmaReportsDesc;
extern  NSMutableArray      *mmaReportsId;
extern  NSMutableArray      *mmaReportsLastUpdate;
extern  NSMutableArray      *mmaReportsLat;
extern  NSMutableArray      *mmaReportsLng;
extern  NSMutableArray      *mmaReportsPubComments;
extern  NSMutableArray      *mmaReportsStatus;
extern  NSMutableArray      *mmaReportsType;
extern  NSMutableArray      *mmaReportsSubType;

//Places
extern  NSDictionary        *mJsonPlaces;
extern  NSMutableArray      *mmaPlacesLat;
extern  NSMutableArray      *mmaPlacesLng;
extern  NSMutableArray      *mmaPlacesAddress;
extern  NSMutableArray      *mmaPlacesSuburb;
extern  NSMutableArray      *mmaPlacesWorkdays;
extern  NSMutableArray      *mmaPlacesWorkTime;
extern  NSMutableArray      *mmaPlacesOffices;
extern  NSMutableArray      *mmaPlacesATM;

extern  NSDictionary        *mJsonSetReport;
extern  NSString            *mstrReportID;

//NSMutableArray

//NSString
extern  NSString            *mstrUserPushToken;
extern  NSString            *mstrUserID;
extern  NSString            *mstrRequestedReport;
extern  NSString            *mstrUserTwitter;
extern  UIImage             *mimgReport;

extern  NSString            *mstrReqLat;
extern  NSString            *mstrReqLat;
extern  NSString            *mstrReqLng;
extern  NSString            *mstrReqType;
extern  NSString            *mstrReqSubType;
extern  NSString            *mstrReqDesc;
extern  NSString            *mstrReqCity;
extern  NSString            *mstrReqEmail;
extern  NSString            *mstrReqTwitter;
extern  NSString            *mstrReqRPU;

extern  NSDictionary        *mJsonGetUserReport;
extern  NSMutableArray      *mmaMyReports;
extern  NSMutableArray      *mmaMyReportsDate;
extern  NSMutableArray      *mmaMyReportsDesc;
extern  NSMutableArray      *mmaMyReportsId;
extern  NSMutableArray      *mmaMyReportsLastUpdate;
extern  NSMutableArray      *mmaMyReportsLat;
extern  NSMutableArray      *mmaMyReportsLng;
extern  NSMutableArray      *mmaMyReportsPubComments;
extern  NSMutableArray      *mmaMyReportsStatus;
extern  NSMutableArray      *mmaMyReportsType;
extern  NSMutableArray      *mmaMyReportsSubType;
extern  NSMutableArray      *mmaMyPubComments;
extern  NSMutableArray      *mmaMyPubDateComments;

extern  unsigned int        uiReqIndex;
//Storyboard
extern  UIStoryboard        *mStoryboard;

//User Defaults
extern  NSUserDefaults      *mUserDefaults;

@interface Declarations : NSObject
- (void) loadLogin;
- (void) postLogin;
- (void) parseReports;
- (void) postPlaces;
- (void) loadPlaces;
- (void) parsePlaces;
- (void) postSetReport;
- (void) loadSetReport;
- (void) parseSetReport;
- (void) postGetUserReport;
- (void) loadGetUserReport;
- (void) parseGetUserReport;
- (void) postUploadPhoto;
- (void) loadUploadPhoto;

@end
