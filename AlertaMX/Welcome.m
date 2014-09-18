//
//  ViewController.m
//  AlertaMX
//
//  Created by Walter on 04/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Welcome.h"
#import "Declarations.h"
#import "UIImage+animatedGIF.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "TabBar.h"

@interface Welcome ()

@end

@implementation Welcome

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Welcome");
    [self initViewController];
    NSLog(@"Welcome2");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
    
    //Play gif
    /*
    NSURL *url                      = [[NSBundle mainBundle] URLForResource:@"gifRain03" withExtension:@"gif"];
    [self.imgBackAlerts setClipsToBounds:YES];
    self.imgBackAlerts.image        = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    self.imgBackAlerts.contentMode  = UIViewContentModeScaleAspectFill;
    
    url                             = [[NSBundle mainBundle] URLForResource:@"gifTsunami01" withExtension:@"gif"];
    [self.imgBackZones setClipsToBounds:YES];
    self.imgBackZones.image         = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    self.imgBackZones.contentMode  = UIViewContentModeScaleAspectFill;
     */
    
    [self.imgBackAlerts setClipsToBounds:YES];
    [self.imgBackZones setClipsToBounds:YES];
    [self.imgBackInstructions setClipsToBounds:YES];
    [self.imgBackFamily setClipsToBounds:YES];
    [self.imgBackHelp setClipsToBounds:YES];
    
    self.imgBackAlerts.contentMode          = UIViewContentModeScaleAspectFill;
    self.imgBackZones.contentMode           = UIViewContentModeScaleAspectFill;
    self.imgBackInstructions.contentMode    = UIViewContentModeScaleAspectFill;
    self.imgBackFamily.contentMode          = UIViewContentModeScaleAspectFill;
    self.imgBackHelp.contentMode            = UIViewContentModeScaleAspectFill;
    
//-------------------------------------------------------------------------------
//Format labels
    self.lblTitleAlert.font         = [UIFont fontWithName: @"OpenSans-Light" size: 30.0];
    self.lblTitleZones.font         = [UIFont fontWithName: @"OpenSans-Light" size: 30.0];
    self.lblTitleInstructions.font  = [UIFont fontWithName: @"OpenSans-Light" size: 30.0];
    self.lblTitleFamily.font        = [UIFont fontWithName: @"OpenSans-Light" size: 30.0];
    self.lblTitleHelp.font          = [UIFont fontWithName: @"OpenSans-Light" size: 30.0];
}

- (IBAction)btnAlertsPressed:(id)sender
{
    NSLog(@"btnStartTutorialPressed");
    TabBar *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"TabBar"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}

- (IBAction)btnRiskZonesPressed:(id)sender {
}

- (IBAction)btnInstructionsPressed:(id)sender {
}

- (IBAction)btnFamilyPressed:(id)sender {
}

- (IBAction)btnHelpPressed:(id)sender {
}
@end

/*
 //-------------------------------------------------------------------------------
 //Play video
 NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"rain01" ofType:@"mp4"];
 NSURL*videoUrl = [NSURL fileURLWithPath:videoPath];
 
 self.moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
 [self.moviePlayer.view setFrame:CGRectMake(0, 0, 160, 220)];
 [self.moviePlayer prepareToPlay];
 [self.moviePlayer setShouldAutoplay:YES];
 [self.moviePlayer setRepeatMode:MPMovieRepeatModeOne];
 self.moviePlayer.controlStyle = MPMovieControlStyleNone;
 [self.viewVideoAlerts addSubview:self.moviePlayer.view];
 [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication] queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
 [self.moviePlayer play];
 }];
*/

/*
 self.mode = MPTransitionModeFold;
 self.foldStyle = MPFoldStyleCubic;
 self.flipStyle = MPFlipStyleOrientationVertical;
 
 UIView *previousView = [[self.viewAlertsFlipBack subviews] objectAtIndex:0];
 UIView *nextView = self.viewAlertsFlipFront;
 BOOL forwards = nextView.tag > previousView.tag;
 
 
 [MPFlipTransition transitionFromView:previousView
 toView:nextView
 duration:[MPTransition defaultDuration]
 style:forwards? [self flipStyle]	: MPFlipStyleFlipDirectionBit([self flipStyle])
 transitionAction:MPTransitionActionAddRemove
 completion:^(BOOL finished) {
 }
 ];
 */
