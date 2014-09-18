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
    [self initVariables];
    [self initViewController];
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
        //self.lblExplanation.alpha = 0.0;
        
    }
    completion:^(BOOL completed)
    {
        [UILabel animateWithDuration:1.0 animations:^{
            self.lblExplanation.alpha   = 1.0;
            self.lblBtnEnter.alpha      = 1.0;
            self.lblBtnTutorial.alpha   = 1.0;
            lblEnter.alpha              = 1.0;
        }];
        self.lblMainDot.hidden          = NO;
    }];
}
/**********************************************************************************************
 Variables
 **********************************************************************************************/
- (void) initVariables
{
    //Storyboard
    mStoryboard         = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
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
    for (int i = 0; i<1000; i++)
    {
        mmaParameter[i] = [NSMutableArray array];
    }
    
    mmaResourceDesc     = [[NSMutableArray alloc] init];
    mmaMIMEType         = [[NSMutableArray alloc] init];
    mmaFileSize         = [[NSMutableArray alloc] init];
    mmaURI              = [[NSMutableArray alloc] init];
    mmaDeferencedURI    = [[NSMutableArray alloc] init];
    mmaDigest           = [[NSMutableArray alloc] init];
    mmaAreaDesc         = [[NSMutableArray alloc] init];
    mmaAreaPolygon      = [[NSMutableArray alloc] init];
    mmaAreaCircle       = [[NSMutableArray alloc] init];
    mmaAreaGeocode      = [[NSMutableArray alloc] init];
    mmaAltitude         = [[NSMutableArray alloc] init];
    mmaCeiling          = [[NSMutableArray alloc] init];
    
    mmaAreaPolygon2     = [[NSMutableArray alloc] init];
    mmaDirection        = [[NSMutableArray alloc] init];
    
    mmaRiskZoneItems    = [[NSMutableArray alloc] init];
    
    mmaMsgID            = [mUserDefaults objectForKey:pmmaMsgID];
    mmaSenderID         = [mUserDefaults objectForKey:pmmaSenderID];
    mmaSentTime         = [mUserDefaults objectForKey:pmmaSentTime];
    mmaMsgStatus        = [mUserDefaults objectForKey:pmmaMsgStatus];
    mmaMsgType          = [mUserDefaults objectForKey:pmmaMsgType];
    mmaSource           = [mUserDefaults objectForKey:pmmaSource];
    mmaScope            = [mUserDefaults objectForKey:pmmaScope];
    mmaRestriction      = [mUserDefaults objectForKey:pmmaRestriction];
    mmaAddresses        = [mUserDefaults objectForKey:pmmaAddresses];
    mmaHandlingCode     = [mUserDefaults objectForKey:pmmaHandlingCode];
    mmaNote             = [mUserDefaults objectForKey:pmmaNote];
    mmaReferenceIDs     = [mUserDefaults objectForKey:pmmaReferenceIDs];
    mmaIncidentIDs      = [mUserDefaults objectForKey:pmmaIncidentIDs];
    mmaLanguage         = [mUserDefaults objectForKey:pmmaLanguage];
    mmaCategory         = [mUserDefaults objectForKey:pmmaCategory];
    mmaResponseType     = [mUserDefaults objectForKey:pmmaResponseType];
    mmaUrgency          = [mUserDefaults objectForKey:pmmaUrgency];
    mmaSeverity         = [mUserDefaults objectForKey:pmmaSeverity];
    mmaCertainty        = [mUserDefaults objectForKey:pmmaCertainty];
    mmaAudience         = [mUserDefaults objectForKey:pmmaAudience];
    mmaEventCode        = [mUserDefaults objectForKey:pmmaEventCode];
    mmaEffective        = [mUserDefaults objectForKey:pmmaEffective];
    mmaExpires          = [mUserDefaults objectForKey:pmmaExpires];
    mmaSenderName       = [mUserDefaults objectForKey:pmmaSenderName];
    mmaHeadline         = [mUserDefaults objectForKey:pmmaHeadline];
    mmaDescription      = [mUserDefaults objectForKey:pmmaDescription];
    mmaInstruction      = [mUserDefaults objectForKey:pmmaInstruction];
    mmaWeb              = [mUserDefaults objectForKey:pmmaWeb];
    mmaContact          = [mUserDefaults objectForKey:pmmaContact];
    //mmaParameter        = [mUserDefaults objectForKey:pmmaParameter];
    mmaResourceDesc     = [mUserDefaults objectForKey:pmmaResourceDesc];
    mmaMIMEType         = [mUserDefaults objectForKey:pmmaMIMEType];
    mmaFileSize         = [mUserDefaults objectForKey:pmmaFileSize];
    mmaURI              = [mUserDefaults objectForKey:pmmaURI];
    mmaDeferencedURI    = [mUserDefaults objectForKey:pmmaDeferencedURI];
    mmaDigest           = [mUserDefaults objectForKey:pmmaDigest];
    mmaAreaDesc         = [mUserDefaults objectForKey:pmmaAreaDesc];
    mmaAreaPolygon      = [mUserDefaults objectForKey:pmmaAreaPolygon];
    //mmaAreaPolygon2     = [mUserDefaults objectForKey:pmmaAreaPolygon2];
    mmaMsgID            = [mUserDefaults objectForKey:pmmaMsgID];
    mmaAreaCircle       = [mUserDefaults objectForKey:pmmaAreaCircle];
    mmaAreaGeocode      = [mUserDefaults objectForKey:pmmaAreaGeocode];
    mmaAltitude         = [mUserDefaults objectForKey:pmmaAltitude];
    mmaCeiling          = [mUserDefaults objectForKey:pmmaCeiling];
    
    if (!(nil == [mUserDefaults objectForKey:pmmaDirection]))
    {
       // mmaDirection    = [mUserDefaults objectForKey:pmmaDirection];
    }
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
    
    [self animateTitle];
    
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
