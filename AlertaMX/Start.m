//
//  Start.m
//  AlertaMX
//
//  Created by Walter on 07/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Start.h"
#import "Declarations.h"
#import "Welcome.h"
#import "TabBar.h"
#import "IntroPages.h"
#import "AppDelegate.h"

NSTimer         *timerStart;
UILabel         *lblEnter;

NSString        *strUserLocation = @"None";

@interface Start ()

@end

@implementation Start

/**********************************************************************************************
 Start
 **********************************************************************************************/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewController];
    [self initVariables];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**********************************************************************************************
 Animations
 **********************************************************************************************/
- (void) animateTitle
{
    [UIView animateWithDuration:1.4f animations:^
    {
        self.lblMainTitle.frame     = CGRectMake(self.lblMainTitle.frame.origin.x-8, self.lblMainTitle.frame.origin.y, self.lblMainTitle.frame.size.width, self.lblMainTitle.frame.size.height);
        self.lblMainTitle2.frame    = CGRectMake(self.lblMainTitle2.frame.origin.x+8, self.lblMainTitle2.frame.origin.y, self.lblMainTitle2.frame.size.width, self.lblMainTitle2.frame.size.height);
        
        self.lblExplanation.alpha   = 1.0;
        self.lblBtnEnter.alpha      = 1.0;
        self.lblBtnTutorial.alpha   = 1.0;
        lblEnter.alpha              = 1.0;
        self.lblMainDot.hidden          = NO;
        //self.lblExplanation.alpha = 0.0;
        
    }
    completion:^(BOOL completed)
    {
        /*
        [UILabel animateWithDuration:0.5 animations:^{
            self.lblExplanation.alpha   = 1.0;
            self.lblBtnEnter.alpha      = 1.0;
            self.lblBtnTutorial.alpha   = 1.0;
            lblEnter.alpha              = 1.0;
        }];
        self.lblMainDot.hidden          = NO;
         */
    }];
}
/**********************************************************************************************
 Variables
 **********************************************************************************************/
- (void) initVariables
{
    //Phone memory
    mUserDefaults       = [NSUserDefaults standardUserDefaults];
    
    //Arrays
    mmaMsgID            = [[NSMutableArray alloc] init];
    mmaSenderID         = [[NSMutableArray alloc] init];
    mmaSentTime         = [[NSMutableArray alloc] init];
    mmaMsgStatus        = [[NSMutableArray alloc] init];
    mmaMsgType          = [[NSMutableArray alloc] init];
    mmaSource           = [[NSMutableArray alloc] init];
    mmaScope            = [[NSMutableArray alloc] init];
    mmaRestriction      = [[NSMutableArray alloc] init];
    mmaAddresses        = [[NSMutableArray alloc] init];
    mmaHandlingCode     = [[NSMutableArray alloc] init];
    mmaNote             = [[NSMutableArray alloc] init];
    mmaReferenceIDs     = [[NSMutableArray alloc] init];
    mmaIncidentIDs      = [[NSMutableArray alloc] init];
    mmaLanguage         = [[NSMutableArray alloc] init];
    mmaCategory         = [[NSMutableArray alloc] init];
    mmaEvent            = [[NSMutableArray alloc] init];
    mmaResponseType     = [[NSMutableArray alloc] init];
    mmaUrgency          = [[NSMutableArray alloc] init];
    mmaSeverity         = [[NSMutableArray alloc] init];
    mmaCertainty        = [[NSMutableArray alloc] init];
    mmaAudience         = [[NSMutableArray alloc] init];
    mmaEventCode        = [[NSMutableArray alloc] init];
    mmaEffective        = [[NSMutableArray alloc] init];
    mmaOnset            = [[NSMutableArray alloc] init];
    mmaExpires          = [[NSMutableArray alloc] init];
    mmaSenderName       = [[NSMutableArray alloc] init];
    mmaHeadline         = [[NSMutableArray alloc] init];
    mmaDescription      = [[NSMutableArray alloc] init];
    mmaInstruction      = [[NSMutableArray alloc] init];
    mmaWeb              = [[NSMutableArray alloc] init];
    mmaContact          = [[NSMutableArray alloc] init];
    mmaParameter        = [[NSMutableArray alloc] init];
    mmaParameterAll     = [[NSMutableArray alloc] init];
    mmaResourceDesc     = [[NSMutableArray alloc] init];
    mmaMIMEType         = [[NSMutableArray alloc] init];
    mmaFileSize         = [[NSMutableArray alloc] init];
    mmaURI              = [[NSMutableArray alloc] init];
    mmaDeferencedURI    = [[NSMutableArray alloc] init];
    mmaDigest           = [[NSMutableArray alloc] init];
    mmaAreaDesc         = [[NSMutableArray alloc] init];
    mmaAreaPolygon      = [[NSMutableArray alloc] init];
    mmaAreaPolygonAll   = [[NSMutableArray alloc] init];
    mmaAreaCircle       = [[NSMutableArray alloc] init];
    mmaAreaGeocode      = [[NSMutableArray alloc] init];
    mmaAltitude         = [[NSMutableArray alloc] init];
    mmaCeiling          = [[NSMutableArray alloc] init];
    
    mmaDirection        = [[NSMutableArray alloc] init];
    mmaAuthor           = [[NSMutableArray alloc] init];
    mmaReviewer         = [[NSMutableArray alloc] init];
    mmaSemaphore        = [[NSMutableArray alloc] init];
    mmaParameterCategory    = [[NSMutableArray alloc] init];
    mmaDistance         = [[NSMutableArray alloc] init];
    
    mmaAreaPolygon2     = [[NSMutableArray alloc] init];
    
    mmaRiskZoneItems    = [[NSMutableArray alloc] init];
    mmaAlertsCAPSNames  = [[NSMutableArray alloc] init];
    
    mboAlreadyRegistered    = NO;
    
    NSString *strItem = @"0";
    mstrUrlCAPS[0]      = nURLGeoJson0;
    mstrUrlCAPS[1]      = nURLGeoJson1;
    mstrUrlCAPS[2]      = nURLGeoJson2;
    mstrUrlCAPS[3]      = nURLGeoJson3;
    mstrUrlCAPS[4]      = nURLGeoJson4;

    //Initialize GeoJsons
    for (int i = 0; i < 5; i++)
    {
        strItem = [NSString stringWithFormat:@"%d", i];
        NSString *strTemp;
        strTemp = [pmmaGeoJson stringByAppendingString:strItem];
        
        
        if (!(nil == [mUserDefaults objectForKey:strTemp]) && !([@"" isEqual:[mUserDefaults objectForKey:strTemp]]))
        {
            mGeoJson[[strItem intValue]]                = [mUserDefaults objectForKey:strTemp];
            mmaGJType[[strItem intValue]]               = [mGeoJson[[strItem intValue]] valueForKey: @"type"];
            mmaGJFeatures[[strItem intValue]]           = [mGeoJson[[strItem intValue]] valueForKey: @"features"];
            mmaGJFtType[[strItem intValue]]             = [mmaGJFeatures[[strItem intValue]] valueForKey: @"type"];
            mmaGJFtGeometry[[strItem intValue]]         = [mmaGJFeatures[[strItem intValue]] valueForKey: @"geometry"];
            mmaGJFtGeometryType[[strItem intValue]]     = [mmaGJFtGeometry[[strItem intValue]] valueForKey: @"type"];
            mmaGJFtGeometryCoord[[strItem intValue]]    = [mmaGJFtGeometry[[strItem intValue]] valueForKey: @"coordinates"];
        }
        
        //NSLog(@"mGeoJson[[%@]] %@", strItem, mGeoJson[[strItem intValue]]);
        /*
         NSLog(@"mmaGJType %@", mmaGJType[[strItem intValue]]);
         NSLog(@"mmaGJFeatures %@", mmaGJFeatures[[strItem intValue]]);
         NSLog(@"mmaGJFtGeometry %@", mmaGJFtGeometry[[strItem intValue]]);
         NSLog(@"mmaGJFtGeometryType %@", mmaGJFtGeometryType[[strItem intValue]]);
         NSLog(@"mmaGJFtGeometryCoord %@", mmaGJFtGeometryCoord[[strItem intValue]]);
         
         //NSLog(@"mmaGJFtGeometryCoord[0][0][0][0] %@", mmaGJFtGeometryCoord[[strItem intValue]][0][0][0]);
         */
        
    }
    
    if (!(nil == [mUserDefaults objectForKey:pmstrUserID]) && !([@"" isEqual:[mUserDefaults objectForKey:pmstrUserID]]))
    {
        mstrUserID          = [mUserDefaults objectForKey:pmstrUserID];
        NSLog(@"mstrUserID %@", mstrUserID);
        
    }
    if ([@"YES" isEqual:[mUserDefaults objectForKey:pmstrAlreadyRegistered]])
    {
        mboAlreadyRegistered = YES;
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaMsgID]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaMsgID]]))
    {
        mmaMsgID            = [mUserDefaults objectForKey:pmmaMsgID];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaSenderID]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaSenderID]]))
    {
        mmaSenderID         = [mUserDefaults objectForKey:pmmaSenderID];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaSentTime]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaSentTime]]))
    {
        mmaSentTime         = [mUserDefaults objectForKey:pmmaSentTime];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaMsgStatus]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaMsgStatus]]))
    {
        mmaMsgStatus        = [mUserDefaults objectForKey:pmmaMsgStatus];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaMsgStatus]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaMsgStatus]]))
    {
        mmaMsgType          = [mUserDefaults objectForKey:pmmaMsgType];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaSource]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaSource]]))
    {
        mmaSource           = [mUserDefaults objectForKey:pmmaSource];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaScope]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaScope]]))
    {
        mmaScope            = [mUserDefaults objectForKey:pmmaScope];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaRestriction]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaRestriction]]))
    {
        mmaRestriction      = [mUserDefaults objectForKey:pmmaRestriction];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAddresses]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAddresses]]))
    {
        mmaAddresses        = [mUserDefaults objectForKey:pmmaAddresses];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaHandlingCode]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaHandlingCode]]))
    {
        mmaHandlingCode     = [mUserDefaults objectForKey:pmmaHandlingCode];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaNote]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaNote]]))
    {
        mmaNote             = [mUserDefaults objectForKey:pmmaNote];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaReferenceIDs]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaReferenceIDs]]))
    {
        mmaReferenceIDs     = [mUserDefaults objectForKey:pmmaReferenceIDs];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaIncidentIDs]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaIncidentIDs]]))
    {
        mmaIncidentIDs      = [mUserDefaults objectForKey:pmmaIncidentIDs];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaLanguage]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaLanguage]]))
    {
        mmaLanguage         = [mUserDefaults objectForKey:pmmaLanguage];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaCategory]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaCategory]]))
    {
        mmaCategory         = [mUserDefaults objectForKey:pmmaCategory];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaResponseType]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaResponseType]]))
    {
        mmaResponseType     = [mUserDefaults objectForKey:pmmaResponseType];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaUrgency]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaUrgency]]))
    {
        mmaUrgency          = [mUserDefaults objectForKey:pmmaUrgency];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaSeverity]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaSeverity]]))
    {
        mmaSeverity         = [mUserDefaults objectForKey:pmmaSeverity];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaCertainty]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaCertainty]]))
    {
        mmaCertainty        = [mUserDefaults objectForKey:pmmaCertainty];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAudience]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAudience]]))
    {
        mmaAudience         = [mUserDefaults objectForKey:pmmaAudience];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaEventCode]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaEventCode]]))
    {
        mmaEventCode        = [mUserDefaults objectForKey:pmmaEventCode];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaEffective]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaEffective]]))
    {
        mmaEffective        = [mUserDefaults objectForKey:pmmaEffective];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaExpires]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaExpires]]))
    {
        mmaExpires          = [mUserDefaults objectForKey:pmmaExpires];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaSenderName]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaSenderName]]))
    {
        mmaSenderName       = [mUserDefaults objectForKey:pmmaSenderName];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaHeadline]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaHeadline]]))
    {
        mmaHeadline         = [mUserDefaults objectForKey:pmmaHeadline];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaDescription]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaDescription]]))
    {
        mmaDescription      = [mUserDefaults objectForKey:pmmaDescription];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaInstruction]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaInstruction]]))
    {
        mmaInstruction      = [mUserDefaults objectForKey:pmmaInstruction];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaWeb]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaWeb]]))
    {
        mmaWeb              = [mUserDefaults objectForKey:pmmaWeb];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaContact]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaContact]]))
    {
        mmaContact          = [mUserDefaults objectForKey:pmmaContact];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaParameter]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaParameter]]))
    {
        mmaParameter        = [mUserDefaults objectForKey:pmmaParameter];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaParameterAll]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaParameterAll]]))
    {
        mmaParameterAll     = [mUserDefaults objectForKey:pmmaParameterAll];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaResourceDesc]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaResourceDesc]]))
    {
        mmaResourceDesc     = [mUserDefaults objectForKey:pmmaResourceDesc];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaMIMEType]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaMIMEType]]))
    {
        mmaMIMEType         = [mUserDefaults objectForKey:pmmaMIMEType];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaFileSize]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaFileSize]]))
    {
        mmaFileSize         = [mUserDefaults objectForKey:pmmaFileSize];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaURI]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaURI]]))
    {
        mmaURI              = [mUserDefaults objectForKey:pmmaURI];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaDeferencedURI]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaDeferencedURI]]))
    {
        mmaDeferencedURI    = [mUserDefaults objectForKey:pmmaDeferencedURI];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaDigest]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaDigest]]))
    {
        mmaDigest           = [mUserDefaults objectForKey:pmmaDigest];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAreaDesc]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAreaDesc]]))
    {
        mmaAreaDesc         = [mUserDefaults objectForKey:pmmaAreaDesc];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAreaPolygon]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAreaPolygon]]))
    {
        mmaAreaPolygon      = [mUserDefaults objectForKey:pmmaAreaPolygon];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAreaPolygonAll]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAreaPolygonAll]]))
    {
        mmaAreaPolygonAll      = [mUserDefaults objectForKey:pmmaAreaPolygonAll];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaMsgID]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaMsgID]]))
    {
        mmaMsgID            = [mUserDefaults objectForKey:pmmaMsgID];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAreaCircle]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAreaCircle]]))
    {
        mmaAreaCircle       = [mUserDefaults objectForKey:pmmaAreaCircle];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAreaGeocode]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAreaGeocode]]))
    {
        mmaAreaGeocode      = [mUserDefaults objectForKey:pmmaAreaGeocode];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAltitude]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAltitude]]))
    {
        mmaAltitude         = [mUserDefaults objectForKey:pmmaAltitude];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaCeiling]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaCeiling]]))
    {
        mmaCeiling          = [mUserDefaults objectForKey:pmmaCeiling];
    }
//-------------------------------------------------------------------------------
//Sub Arrays
    if (!(nil == [mUserDefaults objectForKey:pmmaDirection]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaDirection]]))
    {
        mmaDirection          = [mUserDefaults objectForKey:pmmaDirection];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaAuthor]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaAuthor]]))
    {
        mmaAuthor          = [mUserDefaults objectForKey:pmmaAuthor];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaReviewer]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaReviewer]]))
    {
        mmaReviewer          = [mUserDefaults objectForKey:pmmaReviewer];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaSemaphore]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaSemaphore]]))
    {
        mmaSemaphore          = [mUserDefaults objectForKey:pmmaSemaphore];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaParameterCategory]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaParameterCategory]]))
    {
        mmaParameterCategory    = [mUserDefaults objectForKey:pmmaParameterCategory];
    }
    if (!(nil == [mUserDefaults objectForKey:pmmaDistance]) && !([@"" isEqual:[mUserDefaults objectForKey:pmmaDistance]]))
    {
        mmaDistance          = [mUserDefaults objectForKey:pmmaDistance];
    }

    //mmaAreaPolygon2     = [mUserDefaults objectForKey:pmmaAreaPolygon2];
    //NSLog(@"ARRAY mmaDirection =  %@", mmaDirection);
    //NSLog(@"ARRAY mmaAreaPolygon =  %@", mmaAreaPolygon);
    /*
    NSLog(@"ARRAY mmaMsgID =  %@", mmaMsgID);
    NSLog(@"ARRAY mmaSenderID =  %@", mmaSenderID);
    NSLog(@"ARRAY mmaSentTime =  %@", mmaSentTime);
    NSLog(@"ARRAY mmaMsgStatus =  %@", mmaMsgStatus);
    NSLog(@"ARRAY mmaMsgType =  %@", mmaMsgType);
    NSLog(@"ARRAY mmaSource =  %@", mmaSource);
    NSLog(@"ARRAY mmaScope =  %@", mmaScope);
    NSLog(@"ARRAY mmaRestriction =  %@", mmaRestriction);
    NSLog(@"ARRAY mmaAddresses =  %@", mmaAddresses);
    NSLog(@"ARRAY mmaSenderID =  %@", mmaHandlingCode);
    NSLog(@"ARRAY mmaSenderID =  %@", mmaNote);
    NSLog(@"ARRAY mmaSenderID =  %@", mmaReferenceIDs);
    NSLog(@"ARRAY mmaSenderID =  %@", mmaIncidentIDs);
    //-------------------------------------------------------------------------------
    NSLog(@"ARRAY mmaLanguage =  %@", mmaLanguage);
    NSLog(@"ARRAY mmaCategory =  %@", mmaCategory);
    NSLog(@"ARRAY mmaEvent =  %@", mmaEvent);
    NSLog(@"ARRAY mmaResponseType =  %@", mmaResponseType);
    NSLog(@"ARRAY mmaUrgency =  %@", mmaUrgency);
    NSLog(@"ARRAY mmaSeverity =  %@", mmaSeverity);
    NSLog(@"ARRAY mmaCertainty =  %@", mmaCertainty);
    NSLog(@"ARRAY mmaAudience =  %@", mmaAudience);
    NSLog(@"ARRAY mmaEventCode =  %@", mmaEventCode);
    NSLog(@"ARRAY mmaEffective =  %@", mmaEffective);
    NSLog(@"ARRAY mmaOnset =  %@", mmaOnset);
    NSLog(@"ARRAY mmaExpires =  %@", mmaExpires);
    NSLog(@"ARRAY mmaSenderName =  %@", mmaSenderName);
    NSLog(@"ARRAY mmaHeadline =  %@", mmaHeadline);
    NSLog(@"ARRAY mmaDescription =  %@", mmaDescription);
    NSLog(@"ARRAY mmaInstruction =  %@", mmaInstruction);
    NSLog(@"ARRAY mmaWeb =  %@", mmaWeb);
    NSLog(@"ARRAY mmaContact =  %@", mmaContact);
    NSLog(@"ARRAY mmaParameter =  %@", mmaParameter);
     */
    
    
}
/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (void) initViewController
{//-------------------------------------------------------------------------------
    //Google Analytics
    //self.screenName = nScreenNameAnalytics;
    
    //Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //Storyboard
    mStoryboard         = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    mApp            = [UIApplication sharedApplication];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self animateTitle];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    });
    
    //Prepare labels
    self.lblExplanation.alpha       = 0;
    self.lblBtnEnter.alpha          = 0;
    self.lblBtnTutorial.alpha       = 0;
    
    self.lblMainTitle.font          = [UIFont fontWithName: @"OpenSans-Light" size: 34.0];
    self.lblMainTitle2.font         = [UIFont fontWithName: @"OpenSans-Light" size: 34.0];
    self.lblMainDot.font            = [UIFont fontWithName: @"OpenSans-Semibold" size: 34.0];
    self.lblBtnTutorial.font        = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.lblExplanation.font        = [UIFont fontWithName: @"OpenSans-Light" size: 16.0];
    self.lblBtnEnter.font           = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    self.lblMainDot.hidden          = YES;
    
    lblEnter = [[UILabel alloc] initWithFrame:CGRectMake(215,self.view.frame.size.height - 60,100,42)];
    [lblEnter setFont:[UIFont fontWithName: @"OpenSans-Light" size: 16.0]];
    lblEnter.textColor = [UIColor darkGrayColor];
    lblEnter.textAlignment = NSTextAlignmentLeft;
    lblEnter.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Empezar"]];
    [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                      range:(NSRange){0,[attString length]}];
    lblEnter.attributedText = attString;
    lblEnter.alpha                  = 0;
    [self.viewStart addSubview:lblEnter];
    
    //-------------------------------------------------------------------------------
    //Location
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    [self.locationManager startUpdatingLocation];
}
/**********************************************************************************************
 Localization
 **********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
    NSLog( @"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             NSString *addressName = [placemark name];
             NSString *city = [placemark locality];
             NSString *administrativeArea = [placemark administrativeArea];
             NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"gstrUserLocation = %@", strUserLocation);
         }
     }];
}
//-------------------------------------------------------------------------------
- (NSString *)getUserLatitude
{
    NSString *userLatitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
    return userLatitude;
}
//-------------------------------------------------------------------------------
- (NSString *)getUserLongitude
{
    NSString *userLongitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    return userLongitude;
}
/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (IBAction)btnStartTutorialPressed:(id)sender
{
    NSLog(@"btnStartTutorialPressed");
    IntroPages *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"IntroPages"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
    
}
//-------------------------------------------------------------------------------
- (IBAction)btnEnterPressed:(id)sender
{
    NSLog(@"btnEnterPressed");
    TabBar *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"TabBar"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}
@end
