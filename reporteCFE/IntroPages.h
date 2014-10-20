//
//  Page1.h
//  AlertaMX
//
//  Created by Walter on 07/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface IntroPages : UIViewController<UIScrollViewDelegate>

//Variables
@property NSUInteger uiPageIndex;

//Views
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;

//Page Control
@property (strong, nonatomic) IBOutlet UIPageControl *pageCtrl;


//Label
@property (strong, nonatomic) IBOutlet UILabel *lblBtnSkip;
@property (strong, nonatomic) IBOutlet UILabel *lblMsg1;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription1;
@property (strong, nonatomic) IBOutlet UILabel *lblMsg2;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription2;
@property (strong, nonatomic) IBOutlet UILabel *lblMsg3;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription3;
@property (strong, nonatomic) IBOutlet UILabel *lblMsg4;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription4;


//Images
@property (strong, nonatomic) IBOutlet UIImageView *img1Msg1;
@property (strong, nonatomic) IBOutlet UIImageView *img1Msg2;
@property (strong, nonatomic) IBOutlet UIImageView *img1Msg3;
@property (strong, nonatomic) IBOutlet UIImageView *img1Msg4;

- (IBAction)btnSkipPressed:(id)sender;

@end
