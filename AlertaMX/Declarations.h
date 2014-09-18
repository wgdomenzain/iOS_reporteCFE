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
#define     pmmaResourceDesc    @"pmmaResourceDesc"
#define     pmmaMIMEType        @"pmmaMIMEType"
#define     pmmaFileSize        @"pmmaFileSize"
#define     pmmaURI             @"pmmaURI"
#define     pmmaDeferencedURI   @"pmmaDeferencedURI"
#define     pmmaDigest          @"pmmaDigest"
#define     pmmaAreaDesc        @"pmmaAreaDesc"
#define     pmmaAreaPolygon     @"pmmaAreaPolygon"
#define     pmmaAreaPolygon2    @"pmmaAreaPolygon2"
#define     pmmaAreaCircle      @"pmmaAreaCircle"
#define     pmmaAreaGeocode     @"pmmaAreaGeocode"
#define     pmmaAltitude        @"pmmaAltitude"
#define     pmmaCeiling         @"pmmaCeiling"
#define     pmmaDirection       @"pmmaDirection"

#define     pmmaAlertUpdatedTime        @"pmmaAlertUpdatedTime"

//Colors
#define nRedGoogle100            colorWithRed:217/255.0 green:74/255.0 blue:56/255.0 alpha:1.00
#define nRedGoogle85            colorWithRed:217/255.0 green:74/255.0 blue:56/255.0 alpha:0.85
#define nLightGray85            colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.85

//Constants
#define nScrollingDown          0
#define nScrollingUp            1

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
extern  NSMutableArray      *mmaParameter[1000];

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
extern  NSMutableArray      *mmaAreaPolygon2;
extern  NSMutableArray      *mmaAreaCircle;
extern  NSMutableArray      *mmaAreaGeocode;
extern  NSMutableArray      *mmaAltitude;
extern  NSMutableArray      *mmaCeiling;

//NSDictionary
extern  NSDictionary        *mGeoJson1;

//NSMutableArray
extern  NSMutableArray      *mmaRiskZoneItems;

//Parameter
extern  NSMutableArray      *mmaDirection;

//Storyboard
extern  UIStoryboard        *mStoryboard;

//Unsigned int
extern  unsigned int        muiTotalRiskZonesItems;

//User Defaults
extern  NSUserDefaults      *mUserDefaults;

@interface Declarations : NSObject
- (void) postGetGeoJson1;
- (void) loadGetGeoJson1;
@end
