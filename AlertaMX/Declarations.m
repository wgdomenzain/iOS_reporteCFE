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
NSMutableArray      *mmaParameter;
NSMutableArray      *mmaParameterAll;

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
NSMutableArray      *mmaAreaPolygonAll;
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

//SubArrays
NSMutableArray      *mmaDirection;
NSMutableArray      *mmaAuthor;
NSMutableArray      *mmaReviewer;
NSMutableArray      *mmaSemaphore;
NSMutableArray      *mmaParameterCategory;
NSMutableArray      *mmaDistance;


//GeoJsons
NSMutableArray      *mmaGJType[10];
NSMutableArray      *mmaGJFeatures[10];
NSMutableArray      *mmaGJFtType[10];
NSMutableArray      *mmaGJFtGeometry[10];
NSMutableArray      *mmaGJFtGeometryType[10];
NSMutableArray      *mmaGJFtGeometryCoord[10];
NSMutableArray      *mmaGJFtProp[10];

//Application
UIApplication       *mApp;

//BOOL
BOOL                mboAlreadyRegistered;

//Int
int                 mintReqIndex;

//NSDictionary
NSDictionary        *mGeoJson[10];
NSDictionary        *mJSRegister;
NSDictionary        *mJSFamily;

//NSMutableArray
NSMutableArray      *mmaAlertsCAPSNames;
NSMutableArray      *mmaRiskZoneItems;

NSMutableArray      *mmaFamilyMembers;
NSMutableArray      *mmaFamilyMembersName;
NSMutableArray      *mmaFamilyMembersStatus;
NSMutableArray      *mmaFamilyMembersMobile;
NSMutableArray      *mmaFamilyMembersTime;
NSMutableArray      *mmaFamilyMembersType;

//NSString
NSString            *mstrUrlCAPS[10];
NSString            *mstrUserName;
NSString            *mstrUserMobile;
NSString            *mstrUserPushToken;
NSString            *mstrUserType;
NSString            *mstrUserID;
NSString            *mstrFamilyMobile;

//Storyboard
UIStoryboard        *mStoryboard;

//Unsigned int
unsigned int        muiTotalAlertCAPS       = 0;
unsigned int        muiTotalRiskZonesItems  = 0;

//User Defaults
NSUserDefaults      *mUserDefaults;



@implementation Declarations

/*******************************************************************************
 1 Get GeoJson
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postGetGeoJson:(NSString*)strItem
{
    NSLog(@"postGetGeoJson");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadGetGeoJson:) object:strItem];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadGetGeoJson:(NSString*)strItem
{
    @try
    {
        NSLog(@"strItem = %@", strItem);
        NSString *post = [[NSString alloc] initWithFormat:@""];
        NSLog(@"postGetGeoJson: %@",post);
        NSURL *url = [NSURL URLWithString:mstrUrlCAPS[[strItem intValue]]];
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
            mGeoJson[[strItem intValue]] = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            //NSLog(@"mGeoJson[%d] %@", [strItem intValue], mGeoJson[[strItem intValue]]);
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
//-------------------------------------------------------------------------------
//Save json in memory phone
    if (mGeoJson[[strItem intValue]].count > 0)
    {
        NSString *strTemp;
        strTemp = [pmmaGeoJson stringByAppendingString:strItem];
        [mUserDefaults setObject: mGeoJson[[strItem intValue]] forKey: strTemp];
        NSLog(@"mGeoJsonCompleted%@", strItem);
        mmaGJType[[strItem intValue]]               = [mGeoJson[[strItem intValue]] valueForKey: @"type"];
        mmaGJFeatures[[strItem intValue]]           = [mGeoJson[[strItem intValue]] valueForKey: @"features"];
        mmaGJFtType[[strItem intValue]]             = [mmaGJFeatures[[strItem intValue]] valueForKey: @"type"];
        mmaGJFtGeometry[[strItem intValue]]         = [mmaGJFeatures[[strItem intValue]] valueForKey: @"geometry"];
        mmaGJFtGeometryType[[strItem intValue]]     = [mmaGJFtGeometry[[strItem intValue]] valueForKey: @"type"];
        mmaGJFtGeometryCoord[[strItem intValue]]     = [mmaGJFtGeometry[[strItem intValue]] valueForKey: @"coordinates"];
        
        /*
        NSLog(@"mmaGJType %@", mmaGJType[[strItem intValue]]);
        NSLog(@"mmaGJFeatures %@", mmaGJFeatures[[strItem intValue]]);
        NSLog(@"mmaGJFtGeometry %@", mmaGJFtGeometry[[strItem intValue]]);
        NSLog(@"mmaGJFtGeometryType %@", mmaGJFtGeometryType[[strItem intValue]]);
        NSLog(@"mmaGJFtGeometryCoord %@", mmaGJFtGeometryCoord[[strItem intValue]]);
        
        NSLog(@"mmaGJFtGeometryCoord[0][0][0][0] %@", mmaGJFtGeometryCoord[[strItem intValue]][0][0][0]);
         */
    }
    else
    {
        NSLog(@"PostFail");
    }
}

/*******************************************************************************
2 Register
*******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postRegister
{
    NSLog(@"postGetGeoJson");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadRegister) object:nil];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadRegister
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"mobile=%@&name=%@&pushToken=%@&type=%@", mstrUserMobile, mstrUserName, mstrUserPushToken, mstrUserType];
        NSLog(@"postGetGeoJson: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-68-158-184.us-west-2.compute.amazonaws.com/user/auth/register"];
        NSLog(@"URL postRegister = %@", url);
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
            mJSRegister = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            //NSLog(@"mGeoJson[%d] %@", [strItem intValue], mGeoJson[[strItem intValue]]);
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
    //-------------------------------------------------------------------------------
    //Save json in memory phone
    if (mJSRegister.count > 0)
    {
        NSLog(@"mJSRegister%@", mJSRegister);
        mstrUserID = [mJSRegister valueForKey: @"userID"];
        NSLog(@"mstrUserID %@", mstrUserID);
        [mUserDefaults setObject: mstrUserID forKey: pmstrUserID];
        [mUserDefaults setObject: @"YES" forKey: pmstrAlreadyRegistered];
    }
    else
    {
        NSLog(@"PostFail");
    }
}
/*******************************************************************************
 3 Add Family
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postAddFamily
{
    NSLog(@"postAddFamily");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadAddFamily) object:nil];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadAddFamily
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"userID=%@&mobile=%@", mstrUserID, mstrFamilyMobile];
        NSLog(@"postGetGeoJson: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-68-158-184.us-west-2.compute.amazonaws.com/add/family/member"];
        NSLog(@"URL postRegister = %@", url);
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
            mJSFamily = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            //NSLog(@"mGeoJson[%d] %@", [strItem intValue], mGeoJson[[strItem intValue]]);
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
    //-------------------------------------------------------------------------------
    //Save json in memory phone
    if (mJSFamily.count > 0)
    {
        NSLog(@"mJSFamily%@", mJSFamily);
        mmaFamilyMembers            = [mJSFamily valueForKey: @"familyMembers"];
        mmaFamilyMembersName        = [mmaFamilyMembers valueForKey: @"name"];
        mmaFamilyMembersStatus      = [mmaFamilyMembers valueForKey: @"status"];
        mmaFamilyMembersMobile      = [mmaFamilyMembers valueForKey: @"mobile"];
        mmaFamilyMembersTime        = [mmaFamilyMembers valueForKey: @"hour"];
        mmaFamilyMembersType        = [mmaFamilyMembers valueForKey: @"type"];
        
        NSLog(@"mmaFamilyMembers %@", mmaFamilyMembers);
        NSLog(@"mmaFamilyMembersName %@", mmaFamilyMembersName);
        NSLog(@"mmaFamilyMembersStatus %@", mmaFamilyMembersStatus);
        NSLog(@"mmaFamilyMembersMobile %@", mmaFamilyMembersMobile);
        NSLog(@"mmaFamilyMembersTime %@", mmaFamilyMembersTime);
        NSLog(@"mmaFamilyMembersType %@", mmaFamilyMembersType);
    }
    else
    {
        NSLog(@"PostFail");
    }
}
/*******************************************************************************
 4 Get Family
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postGetFamily
{
    NSLog(@"postGetFamily");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadGetFamily) object:nil];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadGetFamily
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"userID=%@", mstrUserID];
        NSLog(@"postGetGeoJson: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-68-158-184.us-west-2.compute.amazonaws.com/get/family/members"];
        NSLog(@"URL postRegister = %@", url);
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
            mJSFamily = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
            //NSLog(@"mGeoJson[%d] %@", [strItem intValue], mGeoJson[[strItem intValue]]);
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
    //-------------------------------------------------------------------------------
    //Save json in memory phone
    if (mJSFamily.count > 0)
    {
        NSLog(@"mJSFamily%@", mJSFamily);
        mmaFamilyMembers            = [mJSFamily valueForKey: @"familyMembers"];
        mmaFamilyMembersName        = [mmaFamilyMembers valueForKey: @"name"];
        mmaFamilyMembersStatus      = [mmaFamilyMembers valueForKey: @"status"];
        mmaFamilyMembersMobile      = [mmaFamilyMembers valueForKey: @"mobile"];
        mmaFamilyMembersTime        = [mmaFamilyMembers valueForKey: @"hour"];
        mmaFamilyMembersType        = [mmaFamilyMembers valueForKey: @"type"];
        
        NSLog(@"mmaFamilyMembers %@", mmaFamilyMembers);
        NSLog(@"mmaFamilyMembersName %@", mmaFamilyMembersName);
        NSLog(@"mmaFamilyMembersStatus %@", mmaFamilyMembersStatus);
        NSLog(@"mmaFamilyMembersMobile %@", mmaFamilyMembersMobile);
        NSLog(@"mmaFamilyMembersTime %@", mmaFamilyMembersTime);
        NSLog(@"mmaFamilyMembersType %@", mmaFamilyMembersType);
    }
    else
    {
        NSLog(@"PostFail");
    }
}
@end
