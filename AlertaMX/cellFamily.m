//
//  cellFamily.m
//  AlertaMX
//
//  Created by Walter on 22/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "cellFamily.h"

@implementation cellFamily

- (void)awakeFromNib {
    // Initialization code

    self.lblName.font           = [UIFont fontWithName: @"OpenSans" size: 18.0];
    self.lblStatus.font         = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    self.lblUpdated.font        = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
