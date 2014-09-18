//
//  cellAlerts.h
//  AlertaMX
//
//  Created by Walter on 11/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellAlerts : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblHeader;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblCertainty;
@property (strong, nonatomic) IBOutlet UILabel *lblUrgency;
@property (strong, nonatomic) IBOutlet UILabel *lblSeverity;
@property (strong, nonatomic) IBOutlet UILabel *lblSevBar1;
@property (strong, nonatomic) IBOutlet UILabel *lblSevBar2;
@property (strong, nonatomic) IBOutlet UILabel *lblSevBar3;
@property (strong, nonatomic) IBOutlet UILabel *lblSevBar4;
@property (strong, nonatomic) IBOutlet UILabel *lblUrgBar1;
@property (strong, nonatomic) IBOutlet UILabel *lblUrgBar2;
@property (strong, nonatomic) IBOutlet UILabel *lblUrgBar3;
@property (strong, nonatomic) IBOutlet UILabel *lblUrgBar4;
@property (strong, nonatomic) IBOutlet UILabel *lblCerBar1;
@property (strong, nonatomic) IBOutlet UILabel *lblCerBar2;
@property (strong, nonatomic) IBOutlet UILabel *lblCerBar3;
@property (strong, nonatomic) IBOutlet UILabel *lblCerBar4;
@property (strong, nonatomic) IBOutlet UILabel *lblLocation;

//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgMap;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewData;




@end
