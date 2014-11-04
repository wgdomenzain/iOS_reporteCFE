//
//  Declarations.m
//  AlertaMX
//
//  Created by Walter on 08/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Declarations.h"

//Application
UIApplication       *mApp;

//BOOL
BOOL                mboAlreadyRegistered;
BOOL                mboFirstLoad = TRUE;

//Int
int                 mintReqIndex;

CLLocationManager   *mlocationManager;
CLLocation          *mlocation;

float               mlatitude;
float               mlongitude;

//NSDictionary
NSDictionary        *mJsonLogin;
NSMutableArray      *mmaReports;
NSMutableArray      *mmaReportsDate;
NSMutableArray      *mmaReportsDesc;
NSMutableArray      *mmaReportsId;
NSMutableArray      *mmaReportsLastUpdate;
NSMutableArray      *mmaReportsLat;
NSMutableArray      *mmaReportsLng;
NSMutableArray      *mmaReportsPubComments;
NSMutableArray      *mmaReportsStatus;
NSMutableArray      *mmaReportsType;
NSMutableArray      *mmaReportsSubType;

//Places
NSDictionary        *mJsonPlaces;
NSMutableArray      *mmaPlacesLat;
NSMutableArray      *mmaPlacesLng;
NSMutableArray      *mmaPlacesAddress;
NSMutableArray      *mmaPlacesSuburb;
NSMutableArray      *mmaPlacesWorkdays;
NSMutableArray      *mmaPlacesWorkTime;
NSMutableArray      *mmaPlacesOffices;
NSMutableArray      *mmaPlacesATM;

//Places
NSDictionary        *mJsonSetReport;
NSString            *mstrReportID;

//NSMutableArray

//NSString
NSString            *mstrRequestedReport;
NSString            *mstrUserPushToken;
NSString            *mstrUserID;
NSString            *mstrUserTwitter;
UIImage             *mimgReport;

NSString            *mstrReqLat;
NSString            *mstrReqLat;
NSString            *mstrReqLng;
NSString            *mstrReqType;
NSString            *mstrReqSubType;
NSString            *mstrReqDesc;
NSString            *mstrReqCity;
NSString            *mstrReqEmail;
NSString            *mstrReqTwitter;
NSString            *mstrReqRPU;

NSDictionary        *mJsonGetUserReport;
NSMutableArray      *mmaMyReports;
NSMutableArray      *mmaMyReportsDate;
NSMutableArray      *mmaMyReportsDesc;
NSMutableArray      *mmaMyReportsId;
NSMutableArray      *mmaMyReportsLastUpdate;
NSMutableArray      *mmaMyReportsLat;
NSMutableArray      *mmaMyReportsLng;
NSMutableArray      *mmaMyReportsPubComments;
NSMutableArray      *mmaMyReportsStatus;
NSMutableArray      *mmaMyReportsType;
NSMutableArray      *mmaMyReportsSubType;
NSMutableArray      *mmaMyPubComments;
NSMutableArray      *mmaMyPubDateComments;

unsigned int        uiReqIndex;
//Storyboard
UIStoryboard        *mStoryboard;

//Unsigned int


//User Defaults
NSUserDefaults      *mUserDefaults;



@implementation Declarations

/*******************************************************************************
1 Login
*******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postLogin
{
    NSLog(@"postLogin");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadLogin) object:nil];
    [queue addOperation:operation];
}
//-------------------------------------------------------------------------------
- (void) loadLogin
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"pushToken=%@&lat=%@&lng=%@", mstrUserPushToken, [NSString stringWithFormat:@"%f", mlatitude], [NSString stringWithFormat:@"%f", mlongitude]];
        NSLog(@"postLogin: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-69-204-188.us-west-2.compute.amazonaws.com/user/auth/login"];
        NSLog(@"URL postLogin = %@", url);
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
            mJsonLogin = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
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
    if (mJsonLogin.count > 0)
    {
        NSLog(@"mJsonLogin%@", mJsonLogin);
        [mUserDefaults setObject: mJsonLogin forKey: pmstrLogin];
        mmaReports              = [mJsonLogin valueForKey: @"reports"];
        mmaReportsDate          = [mmaReports valueForKey: @"creationDate"];
        mmaReportsDesc          = [mmaReports valueForKey: @"desc"];
        mmaReportsId            = [mmaReports valueForKey: @"id"];
        mmaReportsLastUpdate    = [mmaReports valueForKey: @"lastUpdate"];
        mmaReportsLat           = [mmaReports valueForKey: @"lat"];
        mmaReportsLng           = [mmaReports valueForKey: @"lng"];
        mmaReportsPubComments   = [mmaReports valueForKey: @"publicComments"];
        
        mmaReportsStatus        = [mmaReports valueForKey: @"status"];
        mmaReportsType          = [mmaReports valueForKey: @"type"];
        mmaReportsSubType       = [mmaReports valueForKey: @"subType"];
        
        NSLog(@"mmaReports %@", mmaReports);
        NSLog(@"mmaReportsDate %@", mmaReportsDate);
        NSLog(@"mmaReportsDesc %@", mmaReportsDesc);
        NSLog(@"mmaReportsId %@", mmaReportsId);
        NSLog(@"mmaReportsStatus %@", mmaReportsStatus);
        NSLog(@"mmaReportsType %@", mmaReportsType);
        NSLog(@"mmaReportsStatus %@", mmaReportsStatus);
        NSLog(@"mmaReportsLat %@", mmaReportsLat);
        NSLog(@"mmaReportsLng %@", mmaReportsLng);
        
        mstrUserID = [mJsonLogin valueForKey: @"userID"];
        NSLog(@"mstrUserID %@", mstrUserID);
        [mUserDefaults setObject: mstrUserID forKey: pmstrUserID];
        [mUserDefaults setObject: @"YES" forKey: pmstrAlreadyRegistered];
    }
    else
    {
        NSLog(@"PostFail");
    }
}
- (void) parseReports
{
    mmaReports              = [mJsonLogin valueForKey: @"reports"];
    mmaReportsDate          = [mmaReports valueForKey: @"creationDate"];
    mmaReportsDesc          = [mmaReports valueForKey: @"desc"];
    mmaReportsId            = [mmaReports valueForKey: @"id"];
    mmaReportsLastUpdate    = [mmaReports valueForKey: @"lastUpdate"];
    mmaReportsLat           = [mmaReports valueForKey: @"lat"];
    mmaReportsLng           = [mmaReports valueForKey: @"lng"];
    mmaReportsPubComments   = [mmaReports valueForKey: @"publicComments"];
    mmaReportsStatus        = [mmaReports valueForKey: @"status"];
    mmaReportsType          = [mmaReports valueForKey: @"type"];
    mmaReportsSubType       = [mmaReports valueForKey: @"subType"];
}
/*******************************************************************************
 2 Places
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postPlaces
{
    NSLog(@"postPlaces");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadPlaces) object:nil];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadPlaces
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@""];
        NSLog(@"postPlaces: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-69-204-188.us-west-2.compute.amazonaws.com/get/attention_center/centers"];
        NSLog(@"URL postLogin = %@", url);
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
            mJsonPlaces = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
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
    if (mJsonPlaces.count > 0)
    {
        NSLog(@"mJsonPlaces%@", mJsonPlaces);
        [mUserDefaults setObject: mJsonPlaces forKey: pmstrPlaces];
        mmaPlacesLat        = [mJsonPlaces valueForKey: @"lat"];
        mmaPlacesLng        = [mJsonPlaces valueForKey: @"lng"];
        mmaPlacesAddress    = [mJsonPlaces valueForKey: @"address"];
        mmaPlacesSuburb     = [mJsonPlaces valueForKey: @"suburb"];
        mmaPlacesWorkdays   = [mJsonPlaces valueForKey: @"workDays"];
        mmaPlacesWorkTime   = [mJsonPlaces valueForKey: @"workTime"];
        mmaPlacesOffices    = [mJsonPlaces valueForKey: @"agencia"];
        mmaPlacesATM        = [mJsonPlaces valueForKey: @"cfmatico"];
    }
    else
    {
        NSLog(@"PostFail");
    }
}

- (void) parsePlaces
{
    NSLog(@"parsePlaces");
    mmaPlacesLat        = [mJsonPlaces valueForKey: @"lat"];
    mmaPlacesLng        = [mJsonPlaces valueForKey: @"lng"];
    mmaPlacesAddress    = [mJsonPlaces valueForKey: @"address"];
    mmaPlacesSuburb     = [mJsonPlaces valueForKey: @"suburb"];
    mmaPlacesWorkdays   = [mJsonPlaces valueForKey: @"workDays"];
    mmaPlacesWorkTime   = [mJsonPlaces valueForKey: @"workTime"];
    mmaPlacesOffices    = [mJsonPlaces valueForKey: @"agencia"];
    mmaPlacesATM        = [mJsonPlaces valueForKey: @"cfmatico"];
}

/*******************************************************************************
 3 Set Report
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postSetReport
{
    NSLog(@"postSetReport");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadSetReport) object:nil];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadSetReport
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"userID=%@&lat=%@&lng=%@&type=%@&subType=%@&desc=%@&city=%@&rpu=%@&email=%@&twitter=%@", mstrUserID, mstrReqLat, mstrReqLng, mstrReqType, mstrReqSubType, mstrReqDesc, mstrReqCity, mstrReqRPU, mstrReqEmail, mstrReqTwitter];
        NSLog(@"postSetReport: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-69-204-188.us-west-2.compute.amazonaws.com/set/user/report"];
        NSLog(@"URL postLogin = %@", url);
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
            mJsonSetReport = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
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
    if (mJsonSetReport.count > 0)
    {
        NSLog(@"mJsonSetReport%@", mJsonSetReport);
        [mUserDefaults setObject: mJsonSetReport forKey: pmstrSetReport];
        mmaReports              = [mJsonSetReport valueForKey: @"reports"];
        mmaReportsDate          = [mmaReports valueForKey: @"creationDate"];
        mmaReportsDesc          = [mmaReports valueForKey: @"desc"];
        mmaReportsId            = [mmaReports valueForKey: @"id"];
        mmaReportsLastUpdate    = [mmaReports valueForKey: @"lastUpdate"];
        mmaReportsLat           = [mmaReports valueForKey: @"lat"];
        mmaReportsLng           = [mmaReports valueForKey: @"lng"];
        mmaReportsPubComments   = [mmaReports valueForKey: @"publicComments"];
        
        mmaReportsStatus        = [mmaReports valueForKey: @"status"];
        mmaReportsType          = [mmaReports valueForKey: @"type"];
        mmaReportsSubType       = [mmaReports valueForKey: @"subType"];
        
        mstrReportID            = [mJsonSetReport valueForKey: @"reportID"];
        
        NSLog(@"mmaReports %@", mmaReports);
        NSLog(@"mmaReportsDate %@", mmaReportsDate);
        NSLog(@"mmaReportsDesc %@", mmaReportsDesc);
        NSLog(@"mmaReportsId %@", mmaReportsId);
        NSLog(@"mmaReportsStatus %@", mmaReportsStatus);
        NSLog(@"mmaReportsType %@", mmaReportsType);
        NSLog(@"mmaReportsStatus %@", mmaReportsStatus);
        NSLog(@"mmaReportsLat %@", mmaReportsLat);
        NSLog(@"mmaReportsLng %@", mmaReportsLng);
        NSLog(@"mstrReportID %@", mstrReportID);
    }
    else
    {
        NSLog(@"PostFail");
    }
}

- (void) parseSetReport
{
    NSLog(@"parseSetReport");
    mmaReports              = [mJsonLogin valueForKey: @"reports"];
    mmaReportsDate          = [mmaReports valueForKey: @"creationDate"];
    mmaReportsDesc          = [mmaReports valueForKey: @"desc"];
    mmaReportsId            = [mmaReports valueForKey: @"id"];
    mmaReportsLastUpdate    = [mmaReports valueForKey: @"lastUpdate"];
    mmaReportsLat           = [mmaReports valueForKey: @"lat"];
    mmaReportsLng           = [mmaReports valueForKey: @"lng"];
    mmaReportsPubComments   = [mmaReports valueForKey: @"publicComments"];
    mmaReportsStatus        = [mmaReports valueForKey: @"status"];
    mmaReportsType          = [mmaReports valueForKey: @"type"];
    mmaReportsSubType       = [mmaReports valueForKey: @"subType"];
    mstrReportID            = [mJsonSetReport valueForKey: @"reportID"];
}

/*******************************************************************************
 4 Get User Report
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postGetUserReport
{
    NSLog(@"postGetUserReport");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadGetUserReport) object:nil];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadGetUserReport
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"userID=%@", mstrUserID];
        NSLog(@"postGetUserReport: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-69-204-188.us-west-2.compute.amazonaws.com/get/user/reports"];
        NSLog(@"URL postGetUserReport = %@", url);
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
            mJsonGetUserReport = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
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
    if (mJsonGetUserReport.count > 0)
    {
        NSLog(@"mJsonGetUserReport%@", mJsonGetUserReport);
        [mUserDefaults setObject: mJsonGetUserReport forKey: pmstrGetUserReport];
        
        //mmaMyPubComments            =  @"";
        mmaMyReports                = [mJsonGetUserReport valueForKey: @"reports"];
        mmaMyReportsDate            = [mmaMyReports valueForKey: @"creationDate"];
        mmaMyReportsDesc            = [mmaMyReports valueForKey: @"desc"];
        mmaMyReportsId              = [mmaMyReports valueForKey: @"id"];
        mmaMyReportsLastUpdate      = [mmaMyReports valueForKey: @"lastUpdate"];
        mmaMyReportsLat             = [mmaMyReports valueForKey: @"lat"];
        mmaMyReportsLng             = [mmaMyReports valueForKey: @"lng"];
        mmaMyReportsPubComments     = [mmaMyReports valueForKey: @"publicComments"];
        mmaMyPubComments            = [mmaMyReportsPubComments valueForKey: @"comment"];
        mmaMyPubDateComments        = [mmaMyReportsPubComments valueForKey: @"date"];
        
        NSLog(@"mmaMyPubComments %@", mmaMyPubComments);
        
        mmaMyReportsStatus          = [mmaMyReports valueForKey: @"status"];
        mmaMyReportsType            = [mmaMyReports valueForKey: @"type"];
        mmaMyReportsSubType         = [mmaMyReports valueForKey: @"subType"];
    }
    else
    {
        NSLog(@"PostFail");
    }
}

- (void) parseGetUserReport
{
    NSLog(@"parseGetUserReport");
    //mmaMyPubComments            =  @"";
    mmaMyReports                = [mJsonGetUserReport valueForKey: @"reports"];
    mmaMyReportsDate            = [mmaMyReports valueForKey: @"creationDate"];
    mmaMyReportsDesc            = [mmaMyReports valueForKey: @"desc"];
    mmaMyReportsId              = [mmaMyReports valueForKey: @"id"];
    mmaMyReportsLastUpdate      = [mmaMyReports valueForKey: @"lastUpdate"];
    mmaMyReportsLat             = [mmaMyReports valueForKey: @"lat"];
    mmaMyReportsLng             = [mmaMyReports valueForKey: @"lng"];
    mmaMyReportsPubComments     = [mmaMyReports valueForKey: @"publicComments"];
    mmaMyPubComments            = [mmaMyReportsPubComments valueForKey: @"comment"];
    mmaMyPubDateComments        = [mmaMyReportsPubComments valueForKey: @"date"];
    
    mmaMyReportsStatus          = [mmaMyReports valueForKey: @"status"];
    mmaMyReportsType            = [mmaMyReports valueForKey: @"type"];
    mmaMyReportsSubType         = [mmaMyReports valueForKey: @"subType"];
}

/*******************************************************************************
 20 Upload User Photo
 *******************************************************************************/
- (void) postUploadPhoto
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadUploadPhoto) object:nil];
    [queue addOperation:operation];
}
//-------------------------------------------------------------------------------
- (void) loadUploadPhoto
{
    AmazonS3Client *s3 = [[AmazonS3Client alloc] initWithAccessKey:nAWSAccessKeyID withSecretKey:nAWSSecretKey];
    NSData *imageData = UIImageJPEGRepresentation(mimgReport, 1.0);
    
    NSString *strTemp = [mstrReportID stringByAppendingString:@".jpeg"];
    
    NSString *strTempBug = [NSString stringWithFormat:@"%@", strTemp];
    S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:[@"reportImages/" stringByAppendingString: strTempBug] inBucket:@"reportecfe"];
    por.contentType = @"image/jpeg";
    por.data = imageData;
    [s3 putObject:por];
}

/*
 NSLog(@"mmaPlacesLat %@", mmaPlacesLat);
 NSLog(@"mmaPlacesLng %@", mmaPlacesLng);
 NSLog(@"mmaPlacesLng %@", mmaPlacesAddress);
 NSLog(@"mmaPlacesLng %@", mmaPlacesWorkdays);
 NSLog(@"mmaPlacesLng %@", mmaPlacesWorkTime);
 NSLog(@"mmaPlacesLng %@", mmaPlacesOffices);
 NSLog(@"mmaPlacesLng %@", mmaPlacesATM);
 NSLog(@"mmaPlacesLat[0] %@", mmaPlacesLat[0]);
 NSLog(@"mmaPlacesLng[0] %@", mmaPlacesLng[0]);
 */
@end
