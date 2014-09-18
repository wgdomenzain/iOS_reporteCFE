//
//  RiskZones.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "RiskZones.h"
#import "Welcome.h"
#import "SBJson.h"

UILabel *lblBtnItem;
UILabel *lblBtnItemLine;
UIButton *btnItem;

@interface RiskZones ()

@end

@implementation RiskZones

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
    [self initViewController];
    
    [self.Declarations postGetGeoJson1];
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
    self.Declarations = [[Declarations alloc] init];
    
    //Status Bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.lblTitleRiskZones.font         = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    
    muiTotalRiskZonesItems = 5;
    mmaRiskZoneItems[0] = [NSString stringWithFormat:@"Hundimientos\ny Agretamientos"];
    mmaRiskZoneItems[1] = [NSString stringWithFormat:@"Susceptibles de Deslizamientos"];
    mmaRiskZoneItems[2] = [NSString stringWithFormat:@"Peligro por Inundaciones"];
    mmaRiskZoneItems[3] = [NSString stringWithFormat:@"Tsunamis Lejanos y Locales"];
    mmaRiskZoneItems[4] = [NSString stringWithFormat:@"Actividad Volcánica"];
    
    for (int i = 0; i < muiTotalRiskZonesItems; i++)
    {
        self.scrollTop.contentSize      = CGSizeMake((i+1)*320/3, self.scrollTop.frame.size.height);
        lblBtnItem             = [[UILabel alloc] initWithFrame:CGRectMake(i*320/3 + 5,0,320/3 - 10,44)];
        lblBtnItem.backgroundColor      = [UIColor clearColor];
        lblBtnItem.textColor            = [UIColor whiteColor];
        lblBtnItem.text                 = mmaRiskZoneItems[i];
        lblBtnItem.numberOfLines        = 2;
        lblBtnItem.font                 = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
        lblBtnItem.textAlignment        = NSTextAlignmentCenter;
        lblBtnItem.tag = i+1;
        
        btnItem                         = [[UIButton alloc] initWithFrame:CGRectMake(i*320/3 + 5,0,320/3 - 10,44)];
        [btnItem addTarget:self action:@selector(btnItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        btnItem.showsTouchWhenHighlighted = YES;
        btnItem.backgroundColor = [UIColor clearColor];
        [self.scrollTop addSubview:lblBtnItem];
        [self.scrollTop addSubview:btnItem];
        btnItem.tag = i+1;
        if (lblBtnItem.tag == 1)
        {
            lblBtnItem.textColor            = [UIColor whiteColor];
            NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:lblBtnItem.text];
            [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                              value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                              range:(NSRange){0,[attString length]}];
            lblBtnItem.attributedText = attString;

            
            /*
            lblBtnItemLine                  = [[UILabel alloc] initWithFrame:CGRectMake(i*320/3 + 5,40,320/3 - 10,1)];
            lblBtnItemLine.backgroundColor  = [UIColor whiteColor];
            [self.scrollTop addSubview:lblBtnItemLine];
             */
        }
        NSLog(@"lblBtnItem.text  %@",lblBtnItem.text );
    }
    
    
}
- (IBAction)btnItemPressed:(UIButton*)sender
{
    NSLog(@"Tag btnItemPressed %ld",(long)sender.tag);
    
    for (int i = 1; i <= muiTotalRiskZonesItems; i++)
    {
        UILabel *lblSender  = (UILabel *)[self.scrollTop viewWithTag:i];
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:lblSender.text];
        [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                          value:[NSNumber numberWithInt:kCTFontOptionsDefault]
                          range:(NSRange){0,[attString length]}];
        lblSender.attributedText = attString;
    }
    UILabel *lblSender  = (UILabel *)[self.scrollTop viewWithTag:(long)sender.tag];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:lblSender.text];
    [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                      value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                      range:(NSRange){0,[attString length]}];
    lblSender.attributedText = attString;
}
- (IBAction)btnMenuRiskZonesPressed:(id)sender
{
    NSLog(@"btnMenuRiskZonesPressed");
    Welcome *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"Welcome"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}
@end
