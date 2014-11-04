//
//  MyReportsDetails.h
//  reporteCFE
//
//  Created by Walter Gonzalez Domenzain on 01/11/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "Declarations.h"

@interface MyReportDetails : UIViewController

//------------------------------------------------------------------
//Variables
@property (nonatomic,strong) Declarations   *Declarations;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleMyReportDetails;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleReport;
@property (strong, nonatomic) IBOutlet UILabel *lblReportID;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblDateCreated;
@property (strong, nonatomic) IBOutlet UILabel *lblLastUpdated;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblTitlePubComments;
@property (strong, nonatomic) IBOutlet UILabel *lblComments;

@property (strong, nonatomic) IBOutlet UITableView *tblComments;
@property (strong, nonatomic) IBOutlet UIImageView *imgStatus;




@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *viewReportDetails;
@property (strong, nonatomic) IBOutlet UIView *viewDesc;
@property (strong, nonatomic) IBOutlet UIView *viewPubComments;



//Actions
- (IBAction)btnRefreshPressed:(id)sender;
- (IBAction)btnBackPressed:(id)sender;

@end
