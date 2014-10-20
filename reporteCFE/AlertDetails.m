//
//  AlertDetails.m
//  AlertaMX
//
//  Created by Walter on 19/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "AlertDetails.h"
#import "Declarations.h"

@interface AlertDetails ()

@end

@implementation AlertDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
}

- (void)didReceiveMemoryWarning {
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
    
    self.navigationController.navigationItem.backBarButtonItem.tintColor    = [UIColor nRedGoogle100];
    self.navigationController.navigationBar.tintColor                       = [UIColor clearColor];
    
    
    self.scrollAlerts.contentSize   = CGSizeMake(self.scrollAlerts.frame.size.width, 885);
    
    self.lblTitleMain.font          = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleInfo.font          = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleLocation.font      = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleMore.font          = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleInstructions.font  = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblCertainty.font          = [UIFont fontWithName: @"OpenSans-Light" size: 15.0];
    self.lblUrgency.font            = [UIFont fontWithName: @"OpenSans-Light" size: 15.0];
    self.lblSeverity.font           = [UIFont fontWithName: @"OpenSans-Light" size: 15.0];
    self.lblLocation.font           = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblStates.font             = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblInstructions.font       = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblDescription.font        = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblStatesTitle.font        = [UIFont fontWithName: @"OpenSans" size: 12.0];

    self.lblPostDateTitle.font      = [UIFont fontWithName: @"OpenSans" size: 12.0];
    self.lblPostDate.font           = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblPostExpiresTitle.font   = [UIFont fontWithName: @"OpenSans" size: 12.0];
    self.lblPostExpires.font        = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    
    self.lblTitleMain.text          = mmaHeadline[mintReqIndex][0];
    self.lblLocation.text           = mmaDirection[mintReqIndex];
    self.lblStates.text             = mmaAreaDesc[mintReqIndex][0];
    self.lblInstructions.text       = mmaInstruction[mintReqIndex][0];
    self.lblDescription.text        = mmaDescription[mintReqIndex][0];
    
    self.lblTitleMain.adjustsFontSizeToFitWidth     = YES;
    self.lblLocation.adjustsFontSizeToFitWidth      = YES;
    self.lblStates.adjustsFontSizeToFitWidth        = YES;
    self.lblInstructions.adjustsFontSizeToFitWidth  = YES;
    self.lblDescription.adjustsFontSizeToFitWidth   = YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
