//
//  Alerts.h
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface Alerts : UIViewController<UITableViewDelegate, UITableViewDataSource>

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleAlerts;
@property (strong, nonatomic) IBOutlet UILabel *lblUpdated;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnHelp;

//Tables
@property (strong, nonatomic) IBOutlet UITableView *tblAlerts;

//Tab Bar
//@property (strong, nonatomic) IBOutlet UITabBarItem *tabBarItem;


//Actions
- (IBAction)btnMenuAlertsPressed:(id)sender;
- (IBAction)btnRefreshPressed:(id)sender;
- (IBAction)btnHelpAlertsPressed:(id)sender;

@end
