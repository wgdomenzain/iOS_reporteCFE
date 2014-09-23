//
//  Alerts.h
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfiniteScrollPicker.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface Alerts : UIViewController<UITableViewDelegate, UITableViewDataSource>

//Images
@property (strong, nonatomic) IBOutlet UIButton *imgHelp;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleAlerts;
@property (strong, nonatomic) IBOutlet UILabel *lblUpdated;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnHelp;
@property (strong, nonatomic) IBOutlet UILabel *lblHelpTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblHelpDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblHelpCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblAskHelp;

//Scrollview
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewAlerts;


//Tables
@property (strong, nonatomic) IBOutlet UITableView *tblAlerts;

//Tab Bar
//@property (strong, nonatomic) IBOutlet UITabBarItem *tabBarItem;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewHelp;
@property (strong, nonatomic) IBOutlet UIView *viewAlerts;
@property (strong, nonatomic) IBOutlet UIView *viewAlpha;


//Actions
- (IBAction)btnMenuAlertsPressed:(id)sender;
- (IBAction)btnRefreshPressed:(id)sender;
- (IBAction)btnHelpAlertsPressed:(id)sender;
- (IBAction)btnHelpAlertCancelPressed:(id)sender;
- (IBAction)btnHelpAskPressed:(id)sender;

@end
