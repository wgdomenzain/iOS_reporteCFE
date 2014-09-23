//
//  cellFamily.h
//  AlertaMX
//
//  Created by Walter on 22/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellFamily : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgFamily;
@property (strong, nonatomic) IBOutlet UIImageView *imgStatus;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblUpdated;


@end
