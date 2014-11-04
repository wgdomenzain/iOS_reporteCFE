//
//  cellMyReportDetails.m
//  reporteCFE
//
//  Created by Walter Gonzalez Domenzain on 01/11/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "cellMyReportDetails.h"

@implementation cellMyReportDetails

- (void)awakeFromNib {
    // Initialization code
    
    self.lblComment.font        = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblDateComment.font    = [UIFont fontWithName: @"OpenSans" size: 12.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
