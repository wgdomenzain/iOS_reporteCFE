//
//  MyReportsDetails.m
//  reporteCFE
//
//  Created by Walter Gonzalez Domenzain on 01/11/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "MyReportDetails.h"
#import "Welcome.h"
#import "SBJson.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import "cellMyReportDetails.h"

@interface MyReportDetails ()

@end

@implementation MyReportDetails

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
    [self.tblComments reloadData];
    [self.Declarations postGetUserReport];
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.scrollView.contentSize             = CGSizeMake(self.scrollView.frame.size.width, 620);
    
    self.lblTitleMyReportDetails.font       = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleReport.font                = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleDesc.font                  = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitlePubComments.font           = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    
    
    self.lblReportID.font                   = [UIFont fontWithName: @"OpenSans-Light" size: 17.0];
    self.lblStatus.font                     = [UIFont fontWithName: @"OpenSans-Light" size: 17.0];
    self.lblDateCreated.font                = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
    self.lblLastUpdated.font                = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
    
    self.lblDesc.font                       = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    self.lblComments.font                   = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    
    
    if ([mmaMyReportsType[uiReqIndex] isEqual:nFalla])
    {
        if ([mmaMyReportsSubType[uiReqIndex] isEqual:nNoHayLuzCasa])
        {
            self.lblTitleReport.text = @"No hay luz en la casa";
        }
        else if ([mmaMyReportsSubType[uiReqIndex] isEqual:nNoHayLuzCuadra])
        {
            self.lblTitleReport.text = @"No hay luz en la cuadra";
        }
        else if ([mmaMyReportsSubType[uiReqIndex] isEqual:nVariacionVoltajeCasa])
        {
            self.lblTitleReport.text = @"Variación de voltaje en la casa";
        }
        else if ([mmaMyReportsSubType[uiReqIndex] isEqual:nVariacionVoltajeCuadra])
        {
            self.lblTitleReport.text = @"Variación de voltaje en la cuadra o colonia";
        }
        else if ([mmaMyReportsSubType[uiReqIndex] isEqual:nCFEMaticoNoFunciona])
        {
            self.lblTitleReport.text = @"CFEMático no funciona";
        }
    }
    else if ([mmaMyReportsType[uiReqIndex] isEqual:nQueja])
    {
        if ([mmaMyReportsSubType[uiReqIndex] isEqual:nAltoConsumoRecibo])
        {
            self.lblTitleReport.text = @"Alto consumo de recibo de luz";
        }
        else if ([mmaMyReportsSubType[uiReqIndex] isEqual:nMalaAtencionCAC])
        {
            self.lblTitleReport.text = @"Mala Atención en el Centro de Atención a Clientes";
        }
        else if ([mmaMyReportsSubType[uiReqIndex] isEqual:nExtorsionCorrupcion])
        {
            self.lblTitleReport.text = @"Extorsión o corrupción";
        }
    }
    
    self.lblTitleReport.adjustsFontSizeToFitWidth = YES;
    
    if ([mmaMyReportsStatus[uiReqIndex] isEqual: nStatusPending])
    {
        self.lblStatus.text = @"Estado: Recibido";
        self.imgStatus.image    = [UIImage imageNamed:@"1Pending.png"];
    }
    else if ([mmaMyReportsStatus[uiReqIndex] isEqual: nStatusInProgress])
    {
        self.lblStatus.text = @"Estado: En progreso";
        self.imgStatus.image    = [UIImage imageNamed:@"2InProgress.png"];
    }
    else if ([mmaMyReportsStatus[uiReqIndex] isEqual: nStatusSolved])
    {
        self.lblStatus.text = @"Estado: Resuelto";
        self.imgStatus.image    = [UIImage imageNamed:@"3Solved.png"];
    }
    else if ([mmaMyReportsStatus[uiReqIndex] isEqual: nStatusClosed])
    {
        self.lblStatus.text = @"Estado: Cerrado";
        self.imgStatus.image    = [UIImage imageNamed:@"4Closed.png"];
    }
    
//-------------------------------------------------------------------------------
//Creation date
    NSString *strTemp;
    NSString *strDate;
    strDate = mmaMyReportsDate[uiReqIndex];
    NSLog(@"strDate %@", strDate);
    NSDateFormatter* dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:     [NSTimeZone localTimeZone]];
    NSDate *date = [dateFormatter dateFromString:strDate];
    //NSLog(@"date %@", date);
    dateFormatter.dateFormat        = @"dd MMM yyyy - HH:mm";
    strTemp = [dateFormatter stringFromDate:date];
    NSLog(@"strTemp %@", strTemp);
    strTemp   = [strTemp stringByAppendingString:@" hrs"];
    self.lblDateCreated.text = [@"Fecha de creación: " stringByAppendingString:strTemp];
//-------------------------------------------------------------------------------
//Last Updated
    strDate = mmaMyReportsLastUpdate[uiReqIndex];
    NSLog(@"strDate %@", strDate);
    dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:     [NSTimeZone localTimeZone]];
    date = [dateFormatter dateFromString:strDate];
    dateFormatter.dateFormat        = @"dd MMM yyyy - HH:mm";
    strTemp = [dateFormatter stringFromDate:date];
    NSLog(@"strTemp %@", strTemp);
    strTemp   = [strTemp stringByAppendingString:@" hrs"];
    self.lblDateCreated.text    = [@"Última actualización: " stringByAppendingString:strTemp];
//-------------------------------------------------------------------------------
//report ID
    self.lblReportID.text       = [@"Folio: " stringByAppendingString:mmaMyReportsId[uiReqIndex]];
//-------------------------------------------------------------------------------
//Description
    self.lblDesc.text                       = mmaMyReportsDesc[uiReqIndex];
    self.lblDesc.adjustsFontSizeToFitWidth  = YES;
//-------------------------------------------------------------------------------
//Public comments
    //self.lblComments.text       = mmaMyReportsDesc[uiReqIndex];
    

}
/**********************************************************************************************
 Buttons
 **********************************************************************************************/
- (IBAction)btnRefreshPressed:(id)sender
{
    [self.Declarations postGetUserReport];
}

- (IBAction)btnBackPressed:(id)sender
{
    [self performSegueWithIdentifier:@"BackReports" sender:self];
    
}

#pragma mark -
#pragma mark Table View Data Source Methods
/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@" [mmaMyPubComments[uiReqIndex] count %lu]",  (unsigned long)[mmaMyPubComments[uiReqIndex] count]);
    return [mmaMyPubComments[uiReqIndex] count];
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}
//-------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == 1)
    {
        //1. Setup the CATransform3D structure
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
        rotation.m34 = 1.0/ -600;
        
        //2. Define the initial state (Before the animation)
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        cell.layer.transform = rotation;
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        
        //3. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:0.4];
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1;
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        
        //Reassure that cell its in its place (WaGo)
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
        [UIView commitAnimations];
    }
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellMyReportDetails");
    static NSString *CellIdentifier = @"cellMyReportDetails";
    
    cellMyReportDetails *cell = (cellMyReportDetails *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellMyReportDetails alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//-------------------------------------------------------------------------------
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//-------------------------------------------------------------------------------
    //Creation date
    NSString *strTemp;
    NSString *strDate;
    strDate = mmaMyPubDateComments[uiReqIndex][indexPath.row];
    //strDate = mmaMyPubDateComments[indexPath.row][uiReqIndex];
    NSLog(@"strDate %@", strDate);
    
    NSDateFormatter* dateFormatter  = [[NSDateFormatter alloc] init];
    NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    dateFormatter.dateFormat        = @"yyyy-MM-dd HH:mm:ss";
    dateFormatter2.dateFormat       = @"HH:mm:ss";
    [dateFormatter setTimeZone:     [NSTimeZone localTimeZone]];
    [dateFormatter2 setTimeZone:    [NSTimeZone localTimeZone]];
    
    NSDate *date = [dateFormatter dateFromString:strDate];
    //NSDate *time = [dateFormatter2 dateFromString:strDate];
    
    NSLog(@"date %@", date);
    
    dateFormatter.dateFormat        = @"dd MMM yyyy - HH:mm";
    dateFormatter2.dateFormat       = @"HH:mm";
    
    strTemp = [dateFormatter stringFromDate:date];
    NSLog(@"strTemp %@", strTemp);
    
    strTemp   = [strTemp stringByAppendingString:@" hrs"];
    cell.lblDateComment.text    = strTemp;
   
    cell.lblComment.text        = mmaMyPubComments[uiReqIndex][indexPath.row];
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"TableTouch");
}


@end
