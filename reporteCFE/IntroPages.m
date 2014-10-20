//
//  Page1.m
//  AlertaMX
//
//  Created by Walter on 07/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "IntroPages.h"
#import "Declarations.h"
#import "Welcome.h"
#import "TabBar.h"

@interface IntroPages ()

@end

@implementation IntroPages

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********************************************************************************************
 Initialization
**********************************************************************************************/
- (void) initViewController
{//-------------------------------------------------------------------------------
    //Google Analytics
    //self.screenName = nScreenNameAnalytics;
    
    //Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //Set the content size of our scrollview according to the total width of our imageView objects.
    self.scrollView.contentSize     = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height);
    
    self.lblMsg1.font               = [UIFont fontWithName: @"OpenSans" size: 34.0];
    self.lblDescription1.font       = [UIFont fontWithName: @"OpenSans-Light" size: 16.0];
    self.lblMsg2.font               = [UIFont fontWithName: @"OpenSans" size: 34.0];
    self.lblDescription2.font       = [UIFont fontWithName: @"OpenSans-Light" size: 16.0];
    self.lblMsg3.font               = [UIFont fontWithName: @"OpenSans" size: 34.0];
    self.lblDescription3.font       = [UIFont fontWithName: @"OpenSans-Light" size: 16.0];
    self.lblMsg4.font               = [UIFont fontWithName: @"OpenSans" size: 34.0];
    self.lblDescription4.font       = [UIFont fontWithName: @"OpenSans-Light" size: 16.0];
    
    self.lblBtnSkip.font            = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
}

/**********************************************************************************************
 Scroll View
 **********************************************************************************************/
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageCtrl.currentPage = page;
    NSLog(@"page = %d",page);
    
    if (page == 3)
    {
        self.lblBtnSkip.text        = @"Ya entendí";
    }
}

- (IBAction)btnSkipPressed:(id)sender
{
    NSLog(@"btnEnterPressed");
    TabBar *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"TabBar"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];

}
@end
