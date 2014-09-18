//
//  RiskZones.h
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "Declarations.h"

@interface RiskZones : UIViewController

//------------------------------------------------------------------
//Variables
@property (nonatomic,strong) Declarations   *Declarations;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleRiskZones;
@property (strong, nonatomic) IBOutlet UILabel *lblItem1;
@property (strong, nonatomic) IBOutlet UILabel *lblItem2;
@property (strong, nonatomic) IBOutlet UILabel *lblItem3;
@property (strong, nonatomic) IBOutlet UILabel *lblItem4;
@property (strong, nonatomic) IBOutlet UILabel *lblItem5;


//ScrollViews
@property (strong, nonatomic) IBOutlet UIScrollView *scrollTop;

//Actions
- (IBAction)btnMenuRiskZonesPressed:(id)sender;

@end
