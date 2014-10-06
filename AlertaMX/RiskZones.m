//
//  RiskZones.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "RiskZones.h"
#import "Welcome.h"
#import "SBJson.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"

UILabel *lblBtnItem;
UILabel *lblBtnItemLine;
UIButton *btnItem;

@interface RiskZones ()
{
    GMSMapView *mapView_[10];
}
@end

@implementation RiskZones

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
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.694857
                                                            longitude:-103.035121
                                                                 zoom:3.8];
    
    for (int i = 0; i < 6; i++)
    {
        mapView_[i] = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_[i].frame = CGRectMake(0, 108, 320, 460);
        mapView_[i].myLocationEnabled = YES;
    }

    
    NSString *strItem;
    strItem = @"0";

    // Create a rectangular path
    GMSMutablePath *rect = [GMSMutablePath path];
    
    for (int k = 0; k < [mmaGJFtGeometryType[[strItem intValue]] count]; k++)
    {
        if ([mmaGJFtGeometryType[[strItem intValue]][k] isEqual:@"MultiPolygon"])
        {
            for (int i = 0; i< [mmaGJFtGeometryCoord[[strItem intValue]][0][0][0] count]; i++)
            {
                CGFloat fllatitude = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][0][0][0][i][1] floatValue];
                CGFloat fllongitud = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][0][0][0][i][0] floatValue];
                [rect addCoordinate:CLLocationCoordinate2DMake(fllatitude, fllongitud)];
            }
        }
    }
    
    //NSLog(@"[mmaGJFtGeometryCoord[[strItem intValue]][0][0][0] count] %lu",(unsigned long)[mmaGJFtGeometryCoord[[strItem intValue]][0][0][0] count]);
    //NSLog(@"[mmaGJFtGeometryCoord[strItem intValue]][0][0][0] %@",mmaGJFtGeometryCoord[[strItem intValue]][0][0][0]);
    
    //NSLog(@"latitude %f", fllatitude);
    //NSLog(@"langitud %f", fllongitud);
    //NSLog(@"latitude %f",[mmaGJFtGeometryCoord[[strItem intValue]][0][0][0][i][1] floatValue]);
    //NSLog(@"longitude %f",[mmaGJFtGeometryCoord[[strItem intValue]][0][0][0][i][0] floatValue]);
    // Create the polygon, and assign it to the map.
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
    polygon.fillColor = [UIColor nRedMap];
    
    polygon.strokeColor = [UIColor nRedGoogle100];
    polygon.strokeWidth = 2;
    polygon.map = mapView_[0];
    
    [self.view addSubview:mapView_[0]];
    
    /*
    // Create a rectangular path
    GMSMutablePath *rect = [GMSMutablePath path];
    [rect addCoordinate:CLLocationCoordinate2DMake(37.36, -122.0)];
    [rect addCoordinate:CLLocationCoordinate2DMake(37.45, -122.0)];
    [rect addCoordinate:CLLocationCoordinate2DMake(37.45, -122.2)];
    [rect addCoordinate:CLLocationCoordinate2DMake(37.36, -122.2)];
    
    // Create the polygon, and assign it to the map.
    GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
    polygon.fillColor = [UIColor nRedMap];

    polygon.strokeColor = [UIColor clearColor];
    polygon.strokeWidth = 2;
    polygon.map = mapView_;
    
    [self.view addSubview:mapView_];
     */
    
    
    [self.Declarations postGetGeoJson:@"0"];
    [self.Declarations postGetGeoJson:@"1"];
    [self.Declarations postGetGeoJson:@"2"];
    [self.Declarations postGetGeoJson:@"3"];
    [self.Declarations postGetGeoJson:@"4"];
    [self.Declarations postGetGeoJson:@"5"];
    
    
}

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
        
    self.lblTitleRiskZones.font         = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    
    muiTotalRiskZonesItems = 5;
    mmaRiskZoneItems[0] = [NSString stringWithFormat:@"Hundimientos"];
    mmaRiskZoneItems[1] = [NSString stringWithFormat:@"Deslizamientos"];
    mmaRiskZoneItems[2] = [NSString stringWithFormat:@"Tsunamis"];
    mmaRiskZoneItems[3] = [NSString stringWithFormat:@"Volcanes"];
    mmaRiskZoneItems[4] = [NSString stringWithFormat:@"Cenizas"];
    
    for (int i = 0; i < muiTotalRiskZonesItems; i++)
    {
        self.scrollTop.contentSize      = CGSizeMake((i+1)*320/3, self.scrollTop.frame.size.height);
        lblBtnItem             = [[UILabel alloc] initWithFrame:CGRectMake(i*320/3 + 5,0,320/3 - 10,44)];
        lblBtnItem.backgroundColor      = [UIColor clearColor];
        lblBtnItem.textColor            = [UIColor darkGrayColor];
        lblBtnItem.text                 = mmaRiskZoneItems[i];
        lblBtnItem.numberOfLines        = 2;
        lblBtnItem.font                 = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
        lblBtnItem.textAlignment        = NSTextAlignmentCenter;
        lblBtnItem.tag = i+1;
        
        btnItem                         = [[UIButton alloc] initWithFrame:CGRectMake(i*320/3 + 5,0,320/3 - 10,44)];
        [btnItem addTarget:self action:@selector(btnItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        btnItem.showsTouchWhenHighlighted = YES;
        btnItem.backgroundColor = [UIColor clearColor];
        [self.scrollTop addSubview:lblBtnItem];
        [self.scrollTop addSubview:btnItem];
        btnItem.tag = i+1;
        if (lblBtnItem.tag == 1)
        {
            lblBtnItem.textColor            = [UIColor darkGrayColor];
            lblBtnItem.font                 = [UIFont fontWithName: @"OpenSans" size: 13.0];
        }
        NSLog(@"lblBtnItem.text  %@",lblBtnItem.text );
    }
}

/**********************************************************************************************
 Buttons
 **********************************************************************************************/
- (IBAction)btnItemPressed:(UIButton*)sender
{
    NSString *strItem = [NSString stringWithFormat:@"%d", (int)sender.tag - 1];
    dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"Tag btnItemPressed %ld",(long)sender.tag);
    
    for (int i = 1; i <= muiTotalRiskZonesItems; i++)
    {
        UILabel *lblSender  = (UILabel *)[self.scrollTop viewWithTag:i];
        lblSender.font      = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
    }
    UILabel *lblSender  = (UILabel *)[self.scrollTop viewWithTag:(long)sender.tag];
    lblSender.font      = [UIFont fontWithName: @"OpenSans" size: 13.0];
    lblSender.adjustsFontSizeToFitWidth = YES;
    
    [self.Declarations postGetGeoJson:strItem];
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    });
    
    [mapView_[[strItem intValue]] clear];
    
    GMSMarker *marker;
    
    //for (int j = 0; j <  [mmaGJFeatures[[strItem intValue]] count]; j++)
    //{
        // Create map
        NSLog(@"[mmaGJFtGeometryType[[strItem intValue]] count] %lu", (unsigned long)[mmaGJFtGeometryType[[strItem intValue]] count]);
        for (int k = 0; k < [mmaGJFtGeometryType[[strItem intValue]] count]; k++)
        {
            GMSMutablePath *rect    = [GMSMutablePath path];
            if ([mmaGJFtGeometryType[[strItem intValue]][k] isEqual:@"MultiPolygon"])
            {
                for (int i = 0; i< [mmaGJFtGeometryCoord[[strItem intValue]][k][0][0] count]; i++)
                {
                    CGFloat fllatitude = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][k][0][0][i][1] floatValue];
                    CGFloat fllongitud = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][k][0][0][i][0] floatValue];
                    [rect addCoordinate:CLLocationCoordinate2DMake(fllatitude, fllongitud)];
                }
            }
            else if ([mmaGJFtGeometryType[[strItem intValue]][k] isEqual:@"Point"])
            {
                for (int i = 0; i< [mmaGJFtGeometryCoord[[strItem intValue]][k] count]; i++)
                {
                    CGFloat fllatitude = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][i][1] floatValue];
                    CGFloat fllongitud = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][i][0] floatValue];
                    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(fllatitude, fllongitud);
                    marker = [GMSMarker markerWithPosition:position];
                    marker.map = mapView_[[strItem intValue]];
                }
            }
            else if ([mmaGJFtGeometryType[[strItem intValue]][k] isEqual:@"Circle"])
            {
                for (int i = 0; i< [mmaGJFtGeometryCoord[[strItem intValue]][k] count]; i++)
                {
                    CGFloat fllatitude = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][i][1] floatValue];
                    CGFloat fllongitud = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][i][0] floatValue];
                    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(fllatitude, fllongitud);
                    marker = [GMSMarker markerWithPosition:position];
                    
                    marker.map = mapView_[[strItem intValue]];
                    /*CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(fllatitude,fllongitud);
                     circ = [GMSCircle circleWithPosition:circleCenter
                     radius:1000];*/
                }
            }
            
            
            
            GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
            polygon.fillColor = [UIColor nRedMap];
            
            polygon.strokeColor = [UIColor nRedGoogle100];
            polygon.strokeWidth = 2;
            polygon.map = mapView_[[strItem intValue]];
            
            /*
            circ.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0 alpha:0.05];
            circ.strokeColor = [UIColor redColor];
            circ.strokeWidth = 5;
            circ.map = mapView_[[strItem intValue]];
             */
        }
    //}
    
    [mapView_[[strItem intValue]] removeFromSuperview];
    [self.view addSubview:mapView_[[strItem intValue]]];
}
- (IBAction)btnMenuRiskZonesPressed:(id)sender
{
    NSLog(@"btnMenuRiskZonesPressed");
    Welcome *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"Welcome"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}

//-------------------------------------------------------------------------------
- (void) postMap:(NSString*)strItem
{
    NSLog(@"postMap");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadMap:) object:strItem];
    [queue addOperation:operation];
}

//-------------------------------------------------------------------------------
- (void) loadMap:(NSString*)strItem
{
    [mapView_[[strItem intValue]] clear];
    
    // Create map
    NSLog(@"[mmaGJFtGeometryType[[strItem intValue]] count] %lu", (unsigned long)[mmaGJFtGeometryType[[strItem intValue]] count]);
    for (int k = 0; k < [mmaGJFtGeometryType[[strItem intValue]] count]; k++)
    {
        GMSMutablePath *rect = [GMSMutablePath path];
        
        if ([mmaGJFtGeometryType[[strItem intValue]][k] isEqual:@"MultiPolygon"])
        {
            for (int i = 0; i< [mmaGJFtGeometryCoord[[strItem intValue]][k][0][0] count]; i++)
            {
                CGFloat fllatitude = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][k][0][0][i][1] floatValue];
                CGFloat fllongitud = (CGFloat)[mmaGJFtGeometryCoord[[strItem intValue]][k][0][0][i][0] floatValue];
                [rect addCoordinate:CLLocationCoordinate2DMake(fllatitude, fllongitud)];
            }
        }
        GMSPolygon *polygon = [GMSPolygon polygonWithPath:rect];
        polygon.fillColor = [UIColor nRedMap];
        
        polygon.strokeColor = [UIColor nRedGoogle100];
        polygon.strokeWidth = 2;
        polygon.map = mapView_[[strItem intValue]];
    }
    [mapView_[[strItem intValue]] removeFromSuperview];
    [self.view addSubview:mapView_[[strItem intValue]]];
}
@end
