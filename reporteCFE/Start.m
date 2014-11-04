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
        self.lblBtnDoctor.alpha     = 1.0;
        lblEnter.alpha              = 1.0;
    }
    completion:^(BOOL completed)
    {
        self.lblMainDot.hidden          = NO;
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
    if (!(nil == [mUserDefaults objectForKey:pmstrPlaces]) && !([@"" isEqual:[mUserDefaults objectForKey:pmstrPlaces]]))
    {
        mJsonPlaces = [mUserDefaults objectForKey:pmstrPlaces];
        [self.Declarations parsePlaces];
    }
    if (!(nil == [mUserDefaults objectForKey:pmstrLogin]) && !([@"" isEqual:[mUserDefaults objectForKey:pmstrLogin]]))
    {
        mJsonLogin = [mUserDefaults objectForKey:pmstrLogin];
        [self.Declarations parseReports];
    }
    if (!(nil == [mUserDefaults objectForKey:pmstrGetUserReport]) && !([@"" isEqual:[mUserDefaults objectForKey:pmstrGetUserReport]]))
    {
        mJsonGetUserReport = [mUserDefaults objectForKey:pmstrGetUserReport];
        [self.Declarations parseGetUserReport];
    }
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if(granted) {
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
            
            if ([accountsArray count] > 0) {
                ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
                NSLog(@"Twitter Username %@",twitterAccount.username);
                mstrUserTwitter = twitterAccount.username;
                NSLog(@"Twitter Account Type %@",twitterAccount.accountType);
            }
        }
    }];
}
/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (void) initViewController
{//-------------------------------------------------------------------------------
    //Google Analytics
    //self.screenName = nScreenNameAnalytics;
    
    self.Declarations   = [[Declarations alloc] init];
    mApp                = [UIApplication sharedApplication];
    
    //Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //Storyboard
    mStoryboard         = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    mApp                = [UIApplication sharedApplication];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self animateTitle];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    });
    
    //Prepare labels
    self.lblMainTitle.font          = [UIFont fontWithName: @"OpenSans-Light" size: 34.0];
    self.lblMainTitle2.font         = [UIFont fontWithName: @"OpenSans-Light" size: 34.0];
    self.lblMainDot.font            = [UIFont fontWithName: @"OpenSans-Semibold" size: 34.0];
    self.lblBtnDoctor.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblBtnPatient.font         = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
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
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager  requestAlwaysAuthorization];
    
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
             mstrReqCity = city;
             NSString *administrativeArea = [placemark administrativeArea];
             NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"gstrUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         NSLog(@"mlatitude = %f", mlatitude);
         mlongitude = self.locationManager.location.coordinate.longitude;
         NSLog(@"mlongitude = %f", mlongitude);
     }];
}
//-------------------------------------------------------------------------------
- (NSString *)getUserLatitude
{
    NSString *userLatitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
    
    mlatitude = self.locationManager.location.coordinate.latitude;
    NSLog(@"mlatitude = %f", mlatitude);
    
    return userLatitude;
}
//-------------------------------------------------------------------------------
- (NSString *)getUserLongitude
{
    NSString *userLongitude = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    mlongitude = self.locationManager.location.coordinate.longitude;
    NSLog(@"mlongitude = %f", mlongitude);
    
    return userLongitude;
}
/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (IBAction)btnTutorialPressed:(id)sender
{
    NSLog(@"btnTutorialPressed");
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
