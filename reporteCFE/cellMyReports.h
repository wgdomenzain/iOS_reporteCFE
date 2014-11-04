//
//  cellAlerts.h
//  AlertaMX
//
//  Created by Walter on 11/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellMyReports : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgReport;
@property (strong, nonatomic) IBOutlet UIImageView *imgStatus;

@property (strong, nonatomic) IBOutlet UILabel *lblReportDate;
@property (strong, nonatomic) IBOutlet UILabel *lblReportTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblReportStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblReportID;

@end
