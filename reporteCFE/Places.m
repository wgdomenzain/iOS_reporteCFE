//
//  Family.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Places.h"
#import "SBJson.h"
#import "Declarations.h"
#import "cellMyReports.h"
#import "SendReport.h"
#import "SBJson.h"
#import "AppDelegate.h"

NSArray* controlData;

GMSMapView  *mapView;
GMSMarker   *markerLocation;

float       latitudePlaces;
float       longitudePlaces;

NSMutableArray *records;

UILabel *lblItemAlert;
UILabel *lblItemLineAlert;
UIButton *btnItemAlert;

UILabel         *lblEnter;

//BOOL
BOOL    boScrollTable           = nScrollingUp;

//Float
float   flLastContentOffset     = 0;

//int
unsigned int uiIndex = 0;

//URL
NSURL       *urlMap;

NSString    *strMap;

@interface Places ()
{
    InfiniteScrollPicker *isp;
}
@end

@implementation Places

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
    [self initViewController];
    //mapView = nil;
    markerLocation.map = nil;
    [self paintMap];
    [self.Declarations postPlaces];
    [self paintMarkers];
}
/*
-(UIView *)mapView:(GMSMapView *) aMapView markerInfoWindow:(GMSMarker*) marker
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 4, 240, 240)];
    //customize the UIView, for example, in your case, add a UILabel as the subview of the view
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
    [view addSubview:lblEnter];
    NSLog(@"markerInfoWindow");
    
    return view;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    CGPoint point = [mapView.projection pointForCoordinate:marker.position];
    point.y = point.y - 100;
    GMSCameraUpdate *camera =
    [GMSCameraUpdate setTarget:[mapView.projection coordinateForPoint:point]];
    [mapView animateWithCameraUpdate:camera];
    
    mapView.selectedMarker = marker;
    NSLog(@"didTapMarker");
    return YES;
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (void) initViewController
{//-------------------------------------------------------------------------------
    //Google Analytics
    //self.screenName = nScreenNameAnalytics;
    
    self.Declarations = [[Declarations alloc] init];
    //Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.lblTitlePlaces.font        = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    
    self.lblSubViewTitle.font       = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.lblSubViewDesc.font        = [UIFont fontWithName: @"OpenSans" size: 21.0];
    self.lblSubViewCancel.font      = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblSubViewOK.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"OpenSans-Light" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBar appearance] setTintColor:[UIColor nGreenGoogle100]];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}

- (void) paintMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                            longitude:mlongitude
                                                                 zoom:13.0];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame = CGRectMake(0, 64, 320, 460);
    mapView.myLocationEnabled = YES;
    mapView.delegate = self;
    
    [self.viewFailureLocation addSubview:mapView];
}
- (void) paintMarkers
{
    CLLocationCoordinate2D position;
    markerLocation.icon = [GMSMarker markerImageWithColor:[UIColor nGreenGoogle100]];
    
    UIImage *imgMarker = [GMSMarker markerImageWithColor:[UIColor nGreenGoogle100]];
    for (int i = 0; i<mmaPlacesLat.count; i++)
    {
        
        CGFloat lat = (CGFloat)[mmaPlacesLat[i] floatValue];
        CGFloat lng = (CGFloat)[mmaPlacesLng[i] floatValue];
        position = CLLocationCoordinate2DMake(lat, lng);
        //NSLog(@"lat %f, long %f", lat, lng);
        markerLocation      = [GMSMarker markerWithPosition:position];
        markerLocation.icon = imgMarker;//[GMSMarker markerImageWithColor:[UIColor nGreenGoogle100]];
        
        if ([mmaPlacesATM[i] isEqual:@"1"])
        {
            markerLocation.title = @"Centro de Atención y CFEMático";
        }
        else
        {
            markerLocation.title = @"Centro de Atención y CFEMático";
        }
        
        NSString *strTemp   = [mmaPlacesAddress[i] stringByAppendingString:@"\n"];
        //strTemp             = [strTemp stringByAppendingString:mmaPlacesSuburb[i]];
        //strTemp             = [strTemp stringByAppendingString:@"\n"];
        strTemp             = [strTemp stringByAppendingString:mmaPlacesWorkdays[i]];
        strTemp             = [strTemp stringByAppendingString:@", "];
        strTemp             = [strTemp stringByAppendingString:mmaPlacesWorkTime[i]];
        markerLocation.snippet = strTemp;
        markerLocation.map = mapView;
    }
    NSLog(@"doneMap");
}
/**********************************************************************************************
 Buttons
 **********************************************************************************************/
- (IBAction)btnMenuPressed:(id)sender
{
    NSLog(@"btnMenuAlertsPressed");

}
//-------------------------------------------------------------------------------
- (IBAction)btnRefreshPressed:(id)sender
{
    NSLog(@"btnRefreshPressed");
    [self.Declarations postPlaces];
    [self paintMarkers];
}
//-------------------------------------------------------------------------------
- (IBAction)btnReportCancelPressed:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^ {
        self.viewFailureLocation.userInteractionEnabled   = TRUE;
        self.viewSubView.frame                 = CGRectMake(self.viewSubView.frame.origin.x + 320, self.viewSubView.frame.origin.y, self.viewSubView.frame.size.width, self.viewSubView.frame.size.height);
    }];
    self.viewAlpha.hidden = YES;
}

- (IBAction)btnReportSendPressed:(id)sender
{

}

@end
