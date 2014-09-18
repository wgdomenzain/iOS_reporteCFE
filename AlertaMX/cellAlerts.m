//
//  cellAlerts.m
//  AlertaMX
//
//  Created by Walter on 11/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "cellAlerts.h"

@implementation cellAlerts

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
    self.lblHeader.font         = [UIFont fontWithName: @"OpenSans" size: 19.0];
    self.lblTime.font           = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
    self.lblCertainty.font      = [UIFont fontWithName: @"OpenSans-Light" size: 15.0];
    self.lblUrgency.font        = [UIFont fontWithName: @"OpenSans-Light" size: 15.0];
    self.lblSeverity.font       = [UIFont fontWithName: @"OpenSans-Light" size: 15.0];
    self.lblLocation.font       = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
