//
//  Declarations.m
//  AlertaMX
//
//  Created by Walter on 08/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Declarations.h"

//Arrays for XML
//Alert
NSMutableArray      *mmaMsgID;
NSMutableArray      *mmaSenderID;
NSMutableArray      *mmaSentTime;
NSMutableArray      *mmaMsgStatus;
NSMutableArray      *mmaMsgType;
NSMutableArray      *mmaSource;
NSMutableArray      *mmaScope;
NSMutableArray      *mmaRestriction;
NSMutableArray      *mmaAddresses;
NSMutableArray      *mmaHandlingCode;
NSMutableArray      *mmaNote;
NSMutableArray      *mmaReferenceIDs;
NSMutableArray      *mmaIncidentIDs;

//Info
NSMutableArray      *mmaLanguage;
NSMutableArray      *mmaCategory;
NSMutableArray      *mmaEvent;
NSMutableArray      *mmaResponseType;
NSMutableArray      *mmaUrgency;
NSMutableArray      *mmaSeverity;
NSMutableArray      *mmaCertainty;
NSMutableArray      *mmaAudience;
NSMutableArray      *mmaEventCode;
NSMutableArray      *mmaEffective;
NSMutableArray      *mmaOnset;
NSMutableArray      *mmaExpires;
NSMutableArray      *mmaSenderName;
NSMutableArray      *mmaHeadline;
NSMutableArray      *mmaDescription;
NSMutableArray      *mmaInstruction;
NSMutableArray      *mmaWeb;
NSMutableArray      *mmaContact;
NSMutableArray      *mmaParameter[1000];

//Resource
NSMutableArray      *mmaResourceDesc;
NSMutableArray      *mmaMIMEType;
NSMutableArray      *mmaFileSize;
NSMutableArray      *mmaURI;
NSMutableArray      *mmaDeferencedURI;
NSMutableArray      *mmaDigest;

//Area
NSMutableArray      *mmaAreaDesc;
NSMutableArray      *mmaAreaPolygon;
NSMutableArray      *mmaAreaPolygon2;
NSMutableArray      *mmaAreaCircle;
NSMutableArray      *mmaAreaGeocode;
NSMutableArray      *mmaAltitude;
NSMutableArray      *mmaCeiling;

//GeoJson
NSMutableArray      *mmaTypeMaster;
NSMutableArray      *mmaFeaturesMaster;
NSMutableArray      *mmaTypeChild;
NSMutableArray      *mmaGeometryChild;
NSMutableArray      *mmaGeometryType;
NSMutableArray      *mmaGeometryCoordinates;
NSMutableArray      *mmaPropertiesChild;
NSMutableArray      *mmaPropertiesObjectID;
NSMutableArray      *mmaPropertiesZona;
NSMutableArray      *mmaPropertiesAreaKM;
NSMutableArray      *mmaPropertiesObjectID;
NSMutableArray      *mmaPropertiesObjectID;
NSMutableArray      *mmaPropertiesObjectID;


//NSDictionary
NSDictionary        *mGeoJson1;

//NSMutableArray
NSMutableArray      *mmaRiskZoneItems;

//Parameter
NSMutableArray      *mmaDirection;

//Storyboard
UIStoryboard        *mStoryboard;

//Unsigned int
unsigned int        muiTotalRiskZonesItems = 0;

//User Defaults
NSUserDefaults      *mUserDefaults;



@implementation Declarations

/*******************************************************************************
 1 Get User Info
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postGetGeoJson1
{
    NSLog(@"postGetGeoJson1");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadGetGeoJson1) object:nil];
    [queue addOperation:operation];
}
//-------------------------------------------------------------------------------
- (void) loadGetGeoJson1
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@""];
        NSLog(@"postGetGeoJson1: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://www.anr.gob.mx:6081/adaptor/rest/services/ANR/GoogleCrisis/MapServer/exts/GeoJSONServer/GeoJSON?query=1=1&layer=4&f=geojson"];
        NSLog(@"URL postGetGeoJson1 = %@", url);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//-------------------------------------------------------------------------------
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            mGeoJson1 = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            NSLog(@"mGeoJson1 %@", mGeoJson1);
        }
        else
        {
            if (error)
            {
                NSLog(@"Error");
                
            }
            else
            {
                NSLog(@"Conect Fail");
            }
        }
//-------------------------------------------------------------------------------
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception");

    }
}
@end
