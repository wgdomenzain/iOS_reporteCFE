

//
//  Alerts.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "PatientSearch.h"
#import "Welcome.h"
#import "cellAlerts.h"
#import "AlertDetails.h"
#import <GoogleMaps/GoogleMaps.h>

NSArray* controlData;

GMSMapView *mapView;

NSMutableArray *records;

UILabel *lblItemAlert;
UILabel *lblItemLineAlert;
UIButton *btnItemAlert;

//BOOL
BOOL    boScrollTable           = nScrollingUp;

//Float
float   flLastContentOffset     = 0;

//int
unsigned int uiIndex = 0;

//URL
NSURL       *urlMap;

NSString    *strMap;

@interface PatientSearch ()
{
     InfiniteScrollPicker *isp;
}

@end


@implementation PatientSearch

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
    [self paintMap];
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
    
    //Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.lblTitleAlerts.font        = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblUpdated.font            = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    
    self.lblUpdated.text            = [mUserDefaults objectForKey:pmmaAlertUpdatedTime];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"OpenSans-Light" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBar appearance] setTintColor:[UIColor nBlueGoogle100]];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //Initialize the informtion to feed the control
    NSString* plistPath = [[NSBundle mainBundle] pathForResource: @"SectionData"
                                                          ofType: @"plist"];
    // Build the array from the plist
    controlData = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //[NSArray arrayWithObjects: @"Leela", @"Fry", @"Professor", @"Zoidberg", @"Bender", nil];
    
    
    [self.horizontalSelect setDelegate:self];
    [self.horizontalSelect setCurrentIndex:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.horizontalSelect = [[KLHorizontalSelect alloc] initWithFrame: self.view.bounds];
    [self.horizontalSelect setTableData: controlData];
    [self.viewSelectBar addSubview: self.horizontalSelect];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.horizontalSelect setTableData: controlData];
    [self.horizontalSelect setDelegate:self];
    //Customize the initially selected index - Note section is redundant but should always be 0
    [self.horizontalSelect setCurrentIndex:[NSIndexPath indexPathForRow:1 inSection:0]];
    [self.horizontalSelect reloadInputViews];
}

- (void) paintMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                        longitude:mlongitude
                                                             zoom:14.0];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame = CGRectMake(0, 108, 320, 460);
    mapView.myLocationEnabled = YES;
    
    [self.view addSubview:mapView];
}
/**********************************************************************************************
 Image Picker
 **********************************************************************************************/
- (void)infiniteScrollPicker:(InfiniteScrollPicker *)infiniteScrollPicker didSelectAtImage:(UIImage *)image
{
    if (image == [UIImage imageNamed:@"1_Ok.png"])
    {
        NSLog(@"selected s1_0");
        self.lblHelpDesc.text = @"Estoy bien";
    }
    else if (image == [UIImage imageNamed:@"2_Trapped.png"])
    {
        NSLog(@"selected s1_1");
        self.lblHelpDesc.text = @"Estoy Atrapado";
    }
    else if (image == [UIImage imageNamed:@"3_MedicalAid.png"])
    {
        NSLog(@"selected s1_2");
        self.lblHelpDesc.text = @"Estoy Lastimado";
    }
    else
    {
        NSLog(@"selected %@", image);
    }
}
/**********************************************************************************************
 Buttons
 **********************************************************************************************/
- (IBAction)btnItemPressed:(UIButton*)sender
{
    /*
    NSString *strItem = [NSString stringWithFormat:@"%d", (int)sender.tag - 1];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Tag btnItemPressed %ld",(long)sender.tag);
    });
     */
}
- (IBAction)btnMenuAlertsPressed:(id)sender
{
    NSLog(@"btnMenuAlertsPressed");
    Welcome *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"Welcome"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}
//-------------------------------------------------------------------------------
- (IBAction)btnRefreshPressed:(id)sender
{

}
//-------------------------------------------------------------------------------
- (IBAction)btnHelpAlertsPressed:(id)sender
{
    self.viewAlpha.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^
    {
        //self.viewDark.hidden                    = NO;
        self.viewAlerts.userInteractionEnabled  = FALSE;
        self.viewHelp.frame                     = CGRectMake(self.viewHelp.frame.origin.x - 320, self.viewHelp.frame.origin.y, self.viewHelp.frame.size.width, self.viewHelp.frame.size.height);
    }];
}
//-------------------------------------------------------------------------------
- (IBAction)btnHelpAlertCancelPressed:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^ {
        self.viewAlerts.userInteractionEnabled   = TRUE;
        self.viewHelp.frame                 = CGRectMake(self.viewHelp.frame.origin.x + 320, self.viewHelp.frame.origin.y, self.viewHelp.frame.size.width, self.viewHelp.frame.size.height);
    }];
    self.viewAlpha.hidden = YES;
}

- (IBAction)btnHelpAskPressed:(id)sender {
}

#pragma - mark KLHorizontalSelectDelegate implementation
- (void) horizontalSelect:(id)horizontalSelect didSelectCell:(KLHorizontalSelectCell *)cell
{
    NSLog(@"Selected Cell: %@", cell.label.text);
    
    NSLog(@"mboFirstLoad %d", mboFirstLoad);
    /*
    if (([cell.label.text isEqual:@"Ubicación"]) && (1))
    {
        cell.label.highlighted = YES;
        mboFirstLoad = FALSE;
        cell.label.textColor = [UIColor blueColor];
        NSLog(@"cellForRowAtIndexPath Highlighted");
    }
     */

    
    //[self.horizontalSelect removeFromSuperview];


}

#pragma mark -
#pragma mark Table View Data Source Methods
//User’s finger touches up after dragging content
//-------------------------------------------------------------------------------
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    boScrollTable = nScrollingDown;
    if (!decelerate)
    {
        [self scrollingFinish];
    }
}
//-------------------------------------------------------------------------------
//Scroll moves
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (flLastContentOffset < scrollView.contentOffset.y)
    {//Scroll up
        NSLog(@"> 0");
        boScrollTable = nScrollingUp;
    }
    else
    {
        NSLog(@"< 0");
        boScrollTable = nScrollingDown;
    }
    
    flLastContentOffset = scrollView.contentOffset.y;
}
//-------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollingFinish];
}
//-------------------------------------------------------------------------------
- (void)scrollingFinish
{
}
/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mmaHeadline.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}
//-------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (boScrollTable == nScrollingUp)
    {
        //1. Setup the CATransform3D structure
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
        rotation.m34 = 1.0/ -600;
        
        //2. Define the initial state (Before the animation)
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        
        //3. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.4];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        
        //Reassure that cell its in its place (WaGo)
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView commitAnimations];
    }
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellAlerts");
    static NSString *CellIdentifier = @"cellAlerts";
    
    cellAlerts *cell = (cellAlerts *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellAlerts alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//-------------------------------------------------------------------------------
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblHeader.text = [NSString stringWithFormat:@"%@", mmaHeadline[indexPath.row][0]];
    
    //cell.lblHeader.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lblHeader.numberOfLines = 2;
    cell.lblHeader.adjustsFontSizeToFitWidth = YES;
//-------------------------------------------------------------------------------
//Direction
    if (!(nil == mmaDirection) && !([@"" isEqual:mmaDirection]) && (mmaDirection.count > 0))
    {
        cell.lblLocation.text = [NSString stringWithFormat:@"%@", mmaDirection[indexPath.row]];
    }
    cell.lblLocation.adjustsFontSizeToFitWidth = YES;
    
//-------------------------------------------------------------------------------
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
