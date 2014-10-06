//
//  ViewController.h
//  AlertaMX
//
//  Created by Walter on 04/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

@interface Welcome : UIViewController

//Video
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewAlerts;
@property (strong, nonatomic) IBOutlet UIView *viewZones;
@property (strong, nonatomic) IBOutlet UIView *viewVideoAlerts;
@property (strong, nonatomic) IBOutlet UIView *viewInstructions;
@property (strong, nonatomic) IBOutlet UIView *viewFamily;
@property (strong, nonatomic) IBOutlet UIView *viewHelp;
@property (strong, nonatomic) IBOutlet UIView *viewAlertsFlipBack;
@property (strong, nonatomic) IBOutlet UIView *viewAlertsFlipFront;

//Image
@property (strong, nonatomic) IBOutlet UIImageView *imgBackAlerts;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackZones;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackInstructions;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackFamily;
@property (strong, nonatomic) IBOutlet UIImageView *imgBackHelp;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleAlert;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleZones;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleInstructions;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleFamily;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleHelp;

//Actions
- (IBAction)btnAlertsPressed:(id)sender;
- (IBAction)btnRiskZonesPressed:(id)sender;
- (IBAction)btnInstructionsPressed:(id)sender;
- (IBAction)btnFamilyPressed:(id)sender;
- (IBAction)btnHelpPressed:(id)sender;



@end
