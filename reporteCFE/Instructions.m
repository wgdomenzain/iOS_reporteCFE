//
//  Instructions.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Instructions.h"
#import "Declarations.h"
#import "Welcome.h"

@interface Instructions ()

@end

@implementation Instructions

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
    
    self.lblTitleInstructions.font         = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    
}

- (IBAction)btnMenuInstructionsPressed:(id)sender
{
    NSLog(@"btnMenuInstructionsPressed");
    Welcome *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"Welcome"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}
@end
