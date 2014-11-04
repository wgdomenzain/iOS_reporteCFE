//
//  cellAlerts.m
//  AlertaMX
//
//  Created by Walter on 11/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "cellMyReports.h"

@implementation cellMyReports

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.lblReportTitle.font        = [UIFont fontWithName: @"OpenSans-Light" size: 19.0];
    self.lblReportDate.font         = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblReportStatus.font       = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblReportID.font           = [UIFont fontWithName: @"OpenSans" size: 12.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
