//
//  AlertDetails.h
//  AlertaMX
//
//  Created by Walter on 19/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertDetails : UIViewController


//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgMap;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleMain;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblCer1;
@property (strong, nonatomic) IBOutlet UILabel *lblCer2;
@property (strong, nonatomic) IBOutlet UILabel *lblCer3;
@property (strong, nonatomic) IBOutlet UILabel *lblCer4;
@property (strong, nonatomic) IBOutlet UILabel *lblCertainty;
@property (strong, nonatomic) IBOutlet UILabel *lblUrg1;
@property (strong, nonatomic) IBOutlet UILabel *lblUrg2;
@property (strong, nonatomic) IBOutlet UILabel *lblUrg3;
@property (strong, nonatomic) IBOutlet UILabel *lblUrg4;
@property (strong, nonatomic) IBOutlet UILabel *lblUrgency;
@property (strong, nonatomic) IBOutlet UILabel *lblSev1;
@property (strong, nonatomic) IBOutlet UILabel *lblSev2;
@property (strong, nonatomic) IBOutlet UILabel *lblSev3;
@property (strong, nonatomic) IBOutlet UILabel *lblSev4;
@property (strong, nonatomic) IBOutlet UILabel *lblSeverity;
@property (strong, nonatomic) IBOutlet UILabel *lblSemaphore;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblStatesTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblStates;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleMore;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleInstructions;
@property (strong, nonatomic) IBOutlet UILabel *lblInstructions;
@property (strong, nonatomic) IBOutlet UILabel *lblPostDateTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPostDate;
@property (strong, nonatomic) IBOutlet UILabel *lblPostExpiresTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPostExpires;

//ScrollViews
@property (strong, nonatomic) IBOutlet UIScrollView *scrollAlerts;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewInfo;
@property (strong, nonatomic) IBOutlet UIView *viewLocation;
@property (strong, nonatomic) IBOutlet UIView *viewMore;
@property (strong, nonatomic) IBOutlet UIView *viewInstructions;
@property (strong, nonatomic) IBOutlet UIView *viewTime;



@end
