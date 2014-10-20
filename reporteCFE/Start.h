//
//  Start.h
//  AlertaMX
//
//  Created by Walter on 07/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Declarations.h"
#import "IntroPages.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <Pushwoosh/PushNotificationManager.h>

@interface Start : UIViewController<CLLocationManagerDelegate>
//Variables
@property (nonatomic,strong) PushNotificationManager    *PushNotificationManager;

//View
@property (strong, nonatomic) IBOutlet UIView *viewStart;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblMainTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblMainTitle2;
@property (strong, nonatomic) IBOutlet UILabel *lblMainDot;
@property (strong, nonatomic) IBOutlet UILabel *lblExplanation;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnDoctor;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnEnter;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnPatient;

//Images

//Description:  Users's location manager
@property (strong, nonatomic) CLLocationManager     *locationManager;
@property (strong, nonatomic) CLLocation            *location;


//Actions
- (IBAction)btnDoctorPressed:(id)sender;
- (IBAction)btnEnterPressed:(id)sender;
- (IBAction)btnPatientPressed:(id)sender;

@end
