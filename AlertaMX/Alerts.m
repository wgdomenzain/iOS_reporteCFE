

//
//  Alerts.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Alerts.h"
#import "Declarations.h"
#import "Welcome.h"
#import "cellAlerts.h"
#import "AlertDetails.h"

NSMutableArray *records;

UILabel *lblItemAlert;
UILabel *lblItemLineAlert;
UIButton *btnItemAlert;

//BOOL
BOOL    boScrollTable           = nScrollingUp;

//Float
float   flLastContentOffset     = 0;

//int
unsigned int uiIndex = 0;

//URL
NSURL       *urlMap;

NSString    *strMap;

@interface Alerts ()
{
     InfiniteScrollPicker *isp;
}

@end


@implementation Alerts

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
    [self loadXML];
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.lblTitleAlerts.font        = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblUpdated.font            = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    
    self.lblUpdated.text            = [mUserDefaults objectForKey:pmmaAlertUpdatedTime];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"OpenSans-Light" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBar appearance] setTintColor:[UIColor nRedGoogle100]];
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    
    [self.tblAlerts reloadData];
    self.lblBtnHelp.clipsToBounds = YES;
    self.lblBtnHelp.layer.cornerRadius = 30;
    
    muiTotalAlertCAPS       = 1;
    mmaAlertsCAPSNames[0]   = [NSString stringWithFormat:@"Ciclón Tropical"];
    
    if (muiTotalAlertCAPS == 1)
    {
        self.scrollViewAlerts.contentSize   = CGSizeMake(320, self.scrollViewAlerts.frame.size.height);
        lblItemAlert                        = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,44)];
        lblItemAlert.backgroundColor        = [UIColor clearColor];
        lblItemAlert.textColor              = [UIColor darkGrayColor];
        lblItemAlert.text                   = mmaAlertsCAPSNames[0];
        lblItemAlert.numberOfLines          = 2;
        lblItemAlert.font                   = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
        lblItemAlert.textAlignment          = NSTextAlignmentCenter;
        lblItemAlert.tag = 1;
        
        btnItemAlert                         = [[UIButton alloc] initWithFrame:CGRectMake(0,0,320,44)];
        [btnItemAlert addTarget:self action:@selector(btnItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        btnItemAlert.showsTouchWhenHighlighted = YES;
        btnItemAlert.backgroundColor = [UIColor clearColor];
        [self.scrollViewAlerts addSubview:lblItemAlert];
        [self.scrollViewAlerts addSubview:btnItemAlert];
        btnItemAlert.tag = 1;
        if (lblItemAlert.tag == 1)
        {
            lblItemAlert.textColor            = [UIColor darkGrayColor];
            lblItemAlert.font                 = [UIFont fontWithName: @"OpenSans" size: 16.0];
        }
        NSLog(@"lblBtnItem.text  %@",lblItemAlert.text );
    }
    else if (muiTotalAlertCAPS == 2)
    {
        
    }
    else
    {
        for (int i = 0; i < muiTotalAlertCAPS; i++)
        {
            self.scrollViewAlerts.contentSize   = CGSizeMake((i+1)*320/3, self.scrollViewAlerts.frame.size.height);
            lblItemAlert                        = [[UILabel alloc] initWithFrame:CGRectMake(i*320/3 + 5,0,320/3 - 10,44)];
            lblItemAlert.backgroundColor        = [UIColor clearColor];
            lblItemAlert.textColor              = [UIColor darkGrayColor];
            lblItemAlert.text                   = mmaRiskZoneItems[i];
            lblItemAlert.numberOfLines          = 2;
            lblItemAlert.font                   = [UIFont fontWithName: @"OpenSans-Light" size: 13.0];
            lblItemAlert.textAlignment          = NSTextAlignmentCenter;
            lblItemAlert.tag = i+1;
            
            btnItemAlert                         = [[UIButton alloc] initWithFrame:CGRectMake(i*320/3 + 5,0,320/3 - 10,44)];
            [btnItemAlert addTarget:self action:@selector(btnItemPressed:) forControlEvents:UIControlEventTouchUpInside];
            btnItemAlert.showsTouchWhenHighlighted = YES;
            btnItemAlert.backgroundColor = [UIColor clearColor];
            [self.scrollViewAlerts addSubview:lblItemAlert];
            [self.scrollViewAlerts addSubview:btnItemAlert];
            btnItemAlert.tag = i+1;
            if (lblItemAlert.tag == 1)
            {
                lblItemAlert.textColor            = [UIColor darkGrayColor];
                lblItemAlert.font                 = [UIFont fontWithName: @"OpenSans" size: 13.0];
            }
            NSLog(@"lblBtnItem.text  %@",lblItemAlert.text );
        }
    }
//-------------------------------------------------------------------------------
    self.lblHelpTitle.font  = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.lblHelpDesc.font   = [UIFont fontWithName: @"OpenSans" size: 21.0];
    self.lblHelpCancel.font = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblAskHelp.font    = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    
    NSMutableArray *set1 = [[NSMutableArray alloc] init];
    
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"2_Trapped.png"]]];
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"3_MedicalAid.png"]]];
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"1_Ok.png"]]];
    
    isp = [[InfiniteScrollPicker alloc] initWithFrame:CGRectMake(20, 4, 240, 140)];
    [isp setItemSize:CGSizeMake(140, 140)];
    [isp setImageAry:set1];
    [isp setSelectedItem:2];
    
    [self.viewHelp addSubview:isp];
}

/**********************************************************************************************
 Image Picker
 **********************************************************************************************/
- (void)infiniteScrollPicker:(InfiniteScrollPicker *)infiniteScrollPicker didSelectAtImage:(UIImage *)image
{
    if (image == [UIImage imageNamed:@"1_Ok.png"])
    {
        NSLog(@"selected s1_0");
        self.lblHelpDesc.text = @"Estoy bien";
    }
    else if (image == [UIImage imageNamed:@"2_Trapped.png"])
    {
        NSLog(@"selected s1_1");
        self.lblHelpDesc.text = @"Estoy Atrapado";
    }
    else if (image == [UIImage imageNamed:@"3_MedicalAid.png"])
    {
        NSLog(@"selected s1_2");
        self.lblHelpDesc.text = @"Estoy Lastimado";
    }
    else
    {
        NSLog(@"selected %@", image);
    }
}
/**********************************************************************************************
 Buttons
 **********************************************************************************************/
- (IBAction)btnItemPressed:(UIButton*)sender
{
    NSString *strItem = [NSString stringWithFormat:@"%d", (int)sender.tag - 1];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Tag btnItemPressed %ld",(long)sender.tag);

    });
}
- (IBAction)btnMenuAlertsPressed:(id)sender
{
    NSLog(@"btnMenuAlertsPressed");
    Welcome *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"Welcome"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}
//-------------------------------------------------------------------------------
- (IBAction)btnRefreshPressed:(id)sender
{
    [self loadXML];
}
//-------------------------------------------------------------------------------
- (IBAction)btnHelpAlertsPressed:(id)sender
{
    self.viewAlpha.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^
    {
        //self.viewDark.hidden                    = NO;
        self.viewAlerts.userInteractionEnabled  = FALSE;
        self.viewHelp.frame                     = CGRectMake(self.viewHelp.frame.origin.x - 320, self.viewHelp.frame.origin.y, self.viewHelp.frame.size.width, self.viewHelp.frame.size.height);
    }];
}
//-------------------------------------------------------------------------------
- (IBAction)btnHelpAlertCancelPressed:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^ {
        self.viewAlerts.userInteractionEnabled   = TRUE;
        self.viewHelp.frame                 = CGRectMake(self.viewHelp.frame.origin.x + 320, self.viewHelp.frame.origin.y, self.viewHelp.frame.size.width, self.viewHelp.frame.size.height);
    }];
    self.viewAlpha.hidden = YES;
}

- (IBAction)btnHelpAskPressed:(id)sender {
}
/**********************************************************************************************
 XML
 **********************************************************************************************/
- (void) loadXML
{
    self.lblUpdated.text = @"Actualizando...";
    // Create a success block to be called when the async request completes
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        // If TBXML found a root node, process element and iterate all children
        if (tbxmlDocument.rootXMLElement)
            [self traverseElement:tbxmlDocument.rootXMLElement];
//-------------------------------------------------------------------------------
//Save array in phone memory
            [mUserDefaults setObject: mmaMsgID forKey: pmmaMsgID];
            [mUserDefaults setObject: mmaSenderID forKey: pmmaSenderID];
            [mUserDefaults setObject: mmaSentTime forKey: pmmaSentTime];
            [mUserDefaults setObject: mmaMsgStatus forKey: pmmaMsgStatus];
            [mUserDefaults setObject: mmaMsgType forKey: pmmaMsgType];
            [mUserDefaults setObject: mmaSource forKey: pmmaSource];
            [mUserDefaults setObject: mmaScope forKey: pmmaScope];
            [mUserDefaults setObject: mmaRestriction forKey: pmmaRestriction];
            [mUserDefaults setObject: mmaAddresses forKey: pmmaAddresses];
            [mUserDefaults setObject: mmaHandlingCode forKey: pmmaHandlingCode];
            [mUserDefaults setObject: mmaNote forKey: pmmaNote];
            [mUserDefaults setObject: mmaReferenceIDs forKey: pmmaReferenceIDs];
            [mUserDefaults setObject: mmaIncidentIDs forKey: pmmaIncidentIDs];
            [mUserDefaults setObject: mmaLanguage forKey: pmmaLanguage];
            [mUserDefaults setObject: mmaCategory forKey: pmmaCategory];
            [mUserDefaults setObject: mmaEvent forKey: pmmaEvent];
            [mUserDefaults setObject: mmaResponseType forKey: pmmaResponseType];
            [mUserDefaults setObject: mmaUrgency forKey: pmmaUrgency];
            [mUserDefaults setObject: mmaSeverity forKey: pmmaSeverity];
            [mUserDefaults setObject: mmaCertainty forKey: pmmaCertainty];
            [mUserDefaults setObject: mmaAudience forKey: pmmaAudience];
            [mUserDefaults setObject: mmaEventCode forKey: pmmaEventCode];
            [mUserDefaults setObject: mmaEffective forKey: pmmaEffective];
            [mUserDefaults setObject: mmaOnset forKey: pmmaOnset];
            [mUserDefaults setObject: mmaExpires forKey: pmmaExpires];
            [mUserDefaults setObject: mmaSenderName forKey: pmmaSenderName];
            [mUserDefaults setObject: mmaHeadline forKey: pmmaHeadline];
            [mUserDefaults setObject: mmaDescription forKey: pmmaDescription];
            [mUserDefaults setObject: mmaInstruction forKey: pmmaInstruction];
            [mUserDefaults setObject: mmaWeb forKey: pmmaWeb];
            [mUserDefaults setObject: mmaContact forKey: pmmaContact];
            //[mUserDefaults setObject: mmaParameter forKey: pmmaParameter];
            [mUserDefaults setObject: mmaResourceDesc forKey: pmmaResourceDesc];
            [mUserDefaults setObject: mmaMIMEType forKey: pmmaMIMEType];
            [mUserDefaults setObject: mmaFileSize forKey: pmmaFileSize];
            [mUserDefaults setObject: mmaURI forKey: pmmaURI];
            [mUserDefaults setObject: mmaDeferencedURI forKey: pmmaDeferencedURI];
            [mUserDefaults setObject: mmaDigest forKey: pmmaDigest];
            [mUserDefaults setObject: mmaAreaDesc forKey: pmmaAreaDesc];
            [mUserDefaults setObject: mmaAreaPolygon forKey: pmmaAreaPolygon];
            [mUserDefaults setObject: mmaAreaCircle forKey: pmmaAreaCircle];
            [mUserDefaults setObject: mmaAreaGeocode forKey: pmmaAreaGeocode];
            [mUserDefaults setObject: mmaAltitude forKey: pmmaAltitude];
            [mUserDefaults setObject: mmaCeiling forKey: pmmaCeiling];
//-------------------------------------------------------------------------------
//Date and Time
        NSString *strTemp;
        NSDate *now = [NSDate date];
        NSDateFormatter* dateFormatter  = [[NSDateFormatter alloc] init];
        NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat        = @"HH:mm";
        dateFormatter2.dateFormat       = @"dd-MMM";
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter2 setTimeZone:[NSTimeZone localTimeZone]];
        strTemp = [@"Actualizado a las " stringByAppendingString:[dateFormatter stringFromDate:now]];
        strTemp = [strTemp stringByAppendingString: @" hrs del "];
        NSLog(@"strTemp %@", strTemp);
        strTemp = [strTemp stringByAppendingString:[dateFormatter2 stringFromDate:now]];
        NSLog(@"strTemp %@", strTemp);
//-------------------------------------------------------------------------------
//Logs
/*
        NSLog(@"ARRAY mmaMsgID =  %@", mmaMsgID);
        NSLog(@"ARRAY mmaSenderID =  %@", mmaSenderID);
        NSLog(@"ARRAY mmaSentTime =  %@", mmaSentTime);
        NSLog(@"ARRAY mmaMsgStatus =  %@", mmaMsgStatus);
        NSLog(@"ARRAY mmaMsgType =  %@", mmaMsgType);
        NSLog(@"ARRAY mmaSource =  %@", mmaSource);
        NSLog(@"ARRAY mmaScope =  %@", mmaScope);
        NSLog(@"ARRAY mmaRestriction =  %@", mmaRestriction);
        NSLog(@"ARRAY mmaAddresses =  %@", mmaAddresses);
        NSLog(@"ARRAY mmaSenderID =  %@", mmaHandlingCode);
        NSLog(@"ARRAY mmaSenderID =  %@", mmaNote);
        NSLog(@"ARRAY mmaSenderID =  %@", mmaReferenceIDs);
        NSLog(@"ARRAY mmaSenderID =  %@", mmaIncidentIDs);
//-------------------------------------------------------------------------------
        NSLog(@"ARRAY mmaLanguage =  %@", mmaLanguage);
        NSLog(@"ARRAY mmaCategory =  %@", mmaCategory);
        NSLog(@"ARRAY mmaEvent =  %@", mmaEvent);
        NSLog(@"ARRAY mmaResponseType =  %@", mmaResponseType);
        NSLog(@"ARRAY mmaUrgency =  %@", mmaUrgency);
        NSLog(@"ARRAY mmaSeverity =  %@", mmaSeverity);
        NSLog(@"ARRAY mmaCertainty =  %@", mmaCertainty);
        NSLog(@"ARRAY mmaAudience =  %@", mmaAudience);
        NSLog(@"ARRAY mmaEventCode =  %@", mmaEventCode);
        NSLog(@"ARRAY mmaEffective =  %@", mmaEffective);
        NSLog(@"ARRAY mmaOnset =  %@", mmaOnset);
        NSLog(@"ARRAY mmaExpires =  %@", mmaExpires);
        NSLog(@"ARRAY mmaSenderName =  %@", mmaSenderName);
        NSLog(@"ARRAY mmaHeadline =  %@", mmaHeadline);
        NSLog(@"ARRAY mmaDescription =  %@", mmaDescription);
        NSLog(@"ARRAY mmaInstruction =  %@", mmaInstruction);
        NSLog(@"ARRAY mmaWeb =  %@", mmaWeb);
        NSLog(@"ARRAY mmaContact =  %@", mmaContact);
        NSLog(@"ARRAY mmaParameter =  %@", mmaParameter);
        NSLog(@"ARRAY mmaParameter[0] =  %@", mmaParameter[0]);
        NSLog(@"ARRAY mmaParameterAll =  %@", mmaParameterAll);
        NSLog(@"ARRAY mmaParameterAll[0] =  %@", mmaParameterAll[0]);
        NSLog(@"ARRAY mmaParameterAll Count =  %lu", (unsigned long)mmaParameterAll.count);
        NSLog(@"ARRAY Headline Count =  %lu", (unsigned long)mmaHeadline.count);
//-------------------------------------------------------------------------------
        NSLog(@"ARRAY mmaResourceDesc =  %@", mmaResourceDesc);
        NSLog(@"ARRAY mmaMIMEType =  %@", mmaMIMEType);
        NSLog(@"ARRAY mmaFileSize =  %@", mmaFileSize);
        NSLog(@"ARRAY mmaURI =  %@", mmaURI);
        NSLog(@"ARRAY mmaDeferencedURI =  %@", mmaDeferencedURI);
        NSLog(@"ARRAY mmaDigest =  %@", mmaDigest);
//-------------------------------------------------------------------------------
        NSLog(@"ARRAY mmaAreaDesc =  %@", mmaAreaDesc);
        NSLog(@"ARRAY mmaAreaPolygon =  %@", mmaAreaPolygon);
        NSLog(@"ARRAY mmaAreaPolygonAll count =  %lu", (unsigned long)mmaAreaPolygonAll.count);
        NSLog(@"ARRAY mmaAreaPolygonAll =  %@", mmaAreaPolygonAll);
        NSLog(@"ARRAY mmaAreaPolygonAll[0] =  %@", mmaAreaPolygonAll[0]);
        NSLog(@"ARRAY mmaAreaPolygonAll[0][0] =  %@", mmaAreaPolygonAll[0][0]);
        //NSLog(@"ARRAY mmaAreaPolygonAll[0][0][0] =  %@", mmaAreaPolygonAll[0][0][0]);
        NSLog(@"ARRAY mmaAreaPolygon2 =  %@", mmaAreaPolygon2);
        NSLog(@"ARRAY mmaAreaCircle =  %@", mmaAreaCircle);
        NSLog(@"ARRAY mmaAreaGeocode =  %@", mmaAreaGeocode);
        NSLog(@"ARRAY mmaAltitude =  %@", mmaAltitude);
        NSLog(@"ARRAY mmaCeiling =  %@", mmaCeiling);
 */

        
        for (int k=0; k < mmaParameterAll.count; k++)
        {
            NSMutableArray *maValueName = [[NSMutableArray alloc] init];
            maValueName = [mmaParameterAll[k]      valueForKey:    @"valueName"];
            
            NSMutableArray *maValue     = [[NSMutableArray alloc] init];
            maValue     = [mmaParameterAll[k]      valueForKey:    @"value"];
            
            BOOL    boDirection     = FALSE;
            BOOL    boAuthor        = FALSE;
            BOOL    boReviewer      = FALSE;
            BOOL    boSemaphore     = FALSE;
            BOOL    boDistance      = FALSE;
            BOOL    boCategory      = FALSE;
            
            for (int i = 0; i < [maValueName count]; i++)
            {
                if ([maValueName[i] isEqual:@"trayectoria"])
                {
                    [mmaDirection addObject:maValue[i]];
                    boDirection = TRUE;
                }
                else if ([maValueName[i] isEqual:@"Elaboró"])
                {
                    [mmaAuthor addObject:maValue[i]];
                    boAuthor    = TRUE;
                }
                else if ([maValueName[i] isEqual:@"Revisó"])
                {
                    [mmaReviewer addObject:maValue[i]];
                    boReviewer  = TRUE;
                }
                else if ([maValueName[i] isEqual:@"semáforo"])
                {
                    [mmaSemaphore addObject:maValue[i]];
                    boSemaphore = TRUE;
                }
                else if ([maValueName[i] isEqual:@"distancia"])
                {
                    [mmaDistance addObject:maValue[i]];
                    boDistance  = TRUE;
                }
                else if ([maValueName[i] isEqual:@"categoría"])
                {
                    [mmaParameterCategory addObject:maValue[i]];
                    boCategory  = TRUE;
                }

                if (i == [maValueName count] - 1 )
                {
                    if (!boDirection)
                    {
                        [mmaDirection addObject:nNoInfoText];
                    }
                    if (!boAuthor)
                    {
                        [mmaAuthor addObject:nNoInfoText];
                    }
                    if (!boReviewer)
                    {
                        [mmaReviewer addObject:nNoInfoText];
                    }
                    if (!boSemaphore)
                    {
                        [mmaSemaphore addObject:nNoInfoText];
                    }
                    if (!boDistance)
                    {
                        [mmaDistance addObject:nNoInfoText];
                    }
                    if (!boCategory)
                    {
                        [mmaParameterCategory addObject:nNoInfoText];
                    }
                }
            }
        }
        //NSLog(@"ARRAY mmaDirection Count =  %lu", (unsigned long)mmaDirection.count);
        //NSLog(@"ARRAY mmaDirection =  %@", mmaDirection);
        [mUserDefaults setObject: mmaDirection forKey: pmmaDirection];
        
        //NSLog(@"ARRAY mmaAuthor Count =  %lu", (unsigned long)mmaAuthor.count);
        //NSLog(@"ARRAY mmaAuthor =  %@", mmaAuthor);
        [mUserDefaults setObject: mmaAuthor forKey: pmmaAuthor];
        
        //NSLog(@"ARRAY mmaReviewer Count =  %lu", (unsigned long)mmaReviewer.count);
        //NSLog(@"ARRAY mmaReviewer =  %@", mmaReviewer);
        [mUserDefaults setObject: mmaReviewer forKey: pmmaReviewer];
        
        //NSLog(@"ARRAY mmaSemaphore Count =  %lu", (unsigned long)mmaSemaphore.count);
        //NSLog(@"ARRAY mmaSemaphore =  %@", mmaSemaphore);
        [mUserDefaults setObject: mmaSemaphore forKey: pmmaSemaphore];
        
        //NSLog(@"ARRAY mmaParameterCategory Count =  %lu", (unsigned long)mmaParameterCategory.count);
        //NSLog(@"ARRAY mmaParameterCategory =  %@", mmaParameterCategory);
        [mUserDefaults setObject: mmaCategory forKey: pmmaParameterCategory];
        
        //NSLog(@"ARRAY mmaDistance Count =  %lu", (unsigned long)mmaDistance.count);
        //NSLog(@"ARRAY mmaDistance =  %@", mmaDistance);
        [mUserDefaults setObject: mmaDistance forKey: pmmaDistance];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        self.lblUpdated.text = strTemp;
        [mUserDefaults setObject: self.lblUpdated.text forKey: pmmaAlertUpdatedTime];
        [self.tblAlerts reloadData];
        [self.tblAlerts setNeedsDisplay];
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        });
    };
    
    // Create a failure block that gets called if something goes wrong
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        NSLog(@"Error! %@ %@", [error localizedDescription], [error userInfo]);
    };
    
    // Initialize TBXML with the URL of an XML doc. TBXML asynchronously loads and parses the file.
    TBXML *tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:nURLCAP1]
                                      success:successBlock
                                      failure:failureBlock];
    NSLog(@"tbxml %@", tbxml);
}


- (void) traverseElement:(TBXMLElement *)element {
    do {
        // Display the name of the element and description
        NSString * description          = [TBXML textForElement:element];
        //NSLog(@"ELEMENT %@ = %@", [TBXML elementName:element], description);
        
        if (element->firstChild)
            [self traverseElement:element->firstChild];
//-------------------------------------------------------------------------------
        if ([[TBXML elementName:element] isEqualToString:   @"alert"])
        {//Alert
            //NSLog(@"ENTRY ELEMENT %@ = %@", [TBXML elementName:element], description);
            TBXMLElement *msgID         = [TBXML childElementNamed: @"identifier" parentElement:element];
            TBXMLElement *senderID      = [TBXML childElementNamed: @"sender" parentElement:element];
            TBXMLElement *sentTime      = [TBXML childElementNamed: @"sent" parentElement:element];
            TBXMLElement *msgStatus     = [TBXML childElementNamed: @"status" parentElement:element];
            TBXMLElement *msgType       = [TBXML childElementNamed: @"msgType" parentElement:element];
            TBXMLElement *source        = [TBXML childElementNamed: @"source" parentElement:element];
            TBXMLElement *scope         = [TBXML childElementNamed: @"scope" parentElement:element];
            TBXMLElement *restriction   = [TBXML childElementNamed: @"restriction" parentElement:element];
            TBXMLElement *addresses     = [TBXML childElementNamed: @"addresses" parentElement:element];
            TBXMLElement *handlingCode  = [TBXML childElementNamed: @"code" parentElement:element];
            TBXMLElement *note          = [TBXML childElementNamed: @"note" parentElement:element];
            TBXMLElement *referenceIDs  = [TBXML childElementNamed: @"references" parentElement:element];
            TBXMLElement *incidentIDs   = [TBXML childElementNamed: @"incidents" parentElement:element];
            
            //[mmaMsgID addObject:[NSArray arrayWithObjects:      [TBXML textForElement:msgID], nil]];
            if (!(nil == msgID))
            {
                [mmaMsgID addObject:[NSArray arrayWithObjects:      [TBXML textForElement:msgID], nil]];
            }
            
            if (!(nil == senderID))
            {
                [mmaSenderID addObject:[NSArray arrayWithObjects:   [TBXML textForElement:senderID], nil]];
            }
            
            if (!(nil == sentTime))
            {
                [mmaSentTime addObject:[NSArray arrayWithObjects:   [TBXML textForElement:sentTime], nil]];
            }
            
            if (!(nil == msgStatus))
            {
                [mmaMsgStatus addObject:[NSArray arrayWithObjects:   [TBXML textForElement:msgStatus], nil]];
            }
            
            if (!(nil == msgType))
            {
                [mmaMsgType addObject:[NSArray arrayWithObjects:   [TBXML textForElement:msgType], nil]];
            }
            
            if (!(nil == source))
            {
                [mmaSource addObject:[NSArray arrayWithObjects:   [TBXML textForElement:source], nil]];
            }
            
            if (!(nil == scope))
            {
                [mmaScope addObject:[NSArray arrayWithObjects:   [TBXML textForElement:scope], nil]];
            }
            
            if (!(nil == restriction))
            {
                [mmaRestriction addObject:[NSArray arrayWithObjects:   [TBXML textForElement:restriction], nil]];
            }
            
            if (!(nil == addresses))
            {
                [mmaAddresses addObject:[NSArray arrayWithObjects:   [TBXML textForElement:addresses], nil]];
            }
            
            if (!(nil == handlingCode))
            {
                [mmaHandlingCode addObject:[NSArray arrayWithObjects:   [TBXML textForElement:handlingCode], nil]];
            }
            
            if (!(nil == note))
            {
                [mmaNote addObject:[NSArray arrayWithObjects:   [TBXML textForElement:note], nil]];
            }
            
            if (!(nil == referenceIDs))
            {
                [mmaReferenceIDs addObject:[NSArray arrayWithObjects:   [TBXML textForElement:referenceIDs], nil]];
            }
            
            if (!(nil == incidentIDs))
            {
                [mmaIncidentIDs addObject:[NSArray arrayWithObjects:   [TBXML textForElement:incidentIDs], nil]];
            }
        }
//-------------------------------------------------------------------------------
        else if ([[TBXML elementName:element] isEqualToString:  @"info"])
        {//Info
            //NSLog(@"INFO");
            uiIndex = 0;
            //NSLog(@"INFO ELEMENT %@ = %@", [TBXML elementName:element], description);
            TBXMLElement *language      = [TBXML childElementNamed: @"language" parentElement:element];
            TBXMLElement *category      = [TBXML childElementNamed: @"category" parentElement:element];
            TBXMLElement *event         = [TBXML childElementNamed: @"event" parentElement:element];
            TBXMLElement *responseType  = [TBXML childElementNamed: @"responseType" parentElement:element];
            TBXMLElement *urgency       = [TBXML childElementNamed: @"urgency" parentElement:element];
            TBXMLElement *severity      = [TBXML childElementNamed: @"severity" parentElement:element];
            TBXMLElement *certainty     = [TBXML childElementNamed: @"certainty" parentElement:element];
            TBXMLElement *audience      = [TBXML childElementNamed: @"audience" parentElement:element];
            TBXMLElement *eventCode     = [TBXML childElementNamed: @"eventCode" parentElement:element];
            TBXMLElement *effective     = [TBXML childElementNamed: @"effective" parentElement:element];
            TBXMLElement *onset         = [TBXML childElementNamed: @"onset" parentElement:element];
            TBXMLElement *expires       = [TBXML childElementNamed: @"expires" parentElement:element];
            TBXMLElement *senderName    = [TBXML childElementNamed: @"senderName" parentElement:element];
            TBXMLElement *headline      = [TBXML childElementNamed: @"headline" parentElement:element];
            TBXMLElement *description   = [TBXML childElementNamed: @"description" parentElement:element];
            TBXMLElement *instruction   = [TBXML childElementNamed: @"instruction" parentElement:element];
            TBXMLElement *web           = [TBXML childElementNamed: @"web" parentElement:element];
            TBXMLElement *contact       = [TBXML childElementNamed: @"contact" parentElement:element];
            TBXMLElement *parameter     = [TBXML childElementNamed: @"parameter" parentElement:element];
            
            mmaParameter                = [[NSMutableArray alloc] init];
            while (parameter)
            {
                TBXMLElement *valueName     = [TBXML childElementNamed: @"valueName" parentElement:parameter];
                TBXMLElement *value         = [TBXML childElementNamed: @"value" parentElement:parameter];
                
                NSDictionary *dictParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [TBXML textForElement:valueName], @"valueName",
                                          [TBXML textForElement:value], @"value",
                                          nil];
                //NSLog(@"dictParameters %@", dictParameters);
                /*
                if (!(nil == dictParameters))
                {
                    [mmaParameter addObject:dictParameters];
                }
                 */
                [mmaParameter addObject:dictParameters];
                //NSLog(@"mmaParameter %@", mmaParameter);
                
                parameter = [TBXML nextSiblingNamed:@"parameter" searchFromElement:parameter];
            }
            [mmaParameterAll addObject:mmaParameter];
            
            if (!(nil == language))
            {
                [mmaLanguage addObject:[NSArray arrayWithObjects:      [TBXML textForElement:language], nil]];
            }
            
            if (!(nil == category))
            {
                [mmaCategory addObject:[NSArray arrayWithObjects:   [TBXML textForElement:category], nil]];
            }
            
            if (!(nil == event))
            {
                [mmaEvent addObject:[NSArray arrayWithObjects:   [TBXML textForElement:event], nil]];
            }
            
            if (!(nil == responseType))
            {
                [mmaResponseType addObject:[NSArray arrayWithObjects:   [TBXML textForElement:responseType], nil]];
            }
            
            if (!(nil == urgency))
            {
                [mmaUrgency addObject:[NSArray arrayWithObjects:   [TBXML textForElement:urgency], nil]];
            }
            
            if (!(nil == severity))
            {
                [mmaSeverity addObject:[NSArray arrayWithObjects:   [TBXML textForElement:severity], nil]];
            }
            
            if (!(nil == certainty))
            {
                [mmaCertainty addObject:[NSArray arrayWithObjects:   [TBXML textForElement:certainty], nil]];
            }
            
            if (!(nil == audience))
            {
                [mmaAudience addObject:[NSArray arrayWithObjects:   [TBXML textForElement:audience], nil]];
            }
            
            if (!(nil == eventCode))
            {
                [mmaEventCode addObject:[NSArray arrayWithObjects:   [TBXML textForElement:eventCode], nil]];
            }
            
            if (!(nil == effective))
            {
                [mmaEffective addObject:[NSArray arrayWithObjects:   [TBXML textForElement:effective], nil]];
            }
            
            if (!(nil == onset))
            {
                [mmaOnset addObject:[NSArray arrayWithObjects:   [TBXML textForElement:onset], nil]];
            }
            
            if (!(nil == expires))
            {
                [mmaExpires addObject:[NSArray arrayWithObjects:   [TBXML textForElement:expires], nil]];
            }
            
            if (!(nil == senderName))
            {
                [mmaSenderName addObject:[NSArray arrayWithObjects:   [TBXML textForElement:senderName], nil]];
            }
            
            if (!(nil == headline))
            {
                [mmaHeadline addObject:[NSArray arrayWithObjects:   [TBXML textForElement:headline], nil]];
            }
            
            if (!(nil == description))
            {
                [mmaDescription addObject:[NSArray arrayWithObjects:   [TBXML textForElement:description], nil]];
            }
            
            if (!(nil == instruction))
            {
                [mmaInstruction addObject:[NSArray arrayWithObjects:   [TBXML textForElement:instruction], nil]];
            }
            
            if (!(nil == web))
            {
                [mmaWeb addObject:[NSArray arrayWithObjects:   [TBXML textForElement:web], nil]];
            }
            
            if (!(nil == contact))
            {
                [mmaContact addObject:[NSArray arrayWithObjects:   [TBXML textForElement:contact], nil]];
            }
        }
//-------------------------------------------------------------------------------
        
        else if ([[TBXML elementName:element] isEqualToString:  @"resource"])
        {//Resource
            //NSLog(@"resource");
            //NSLog(@"resource ELEMENT %@ = %@", [TBXML elementName:element], description);
            TBXMLElement *resourceDesc  = [TBXML childElementNamed: @"resourceDesc" parentElement:element];
            TBXMLElement *mimeType      = [TBXML childElementNamed: @"mimeType" parentElement:element];
            TBXMLElement *size          = [TBXML childElementNamed: @"size" parentElement:element];
            TBXMLElement *uri           = [TBXML childElementNamed: @"uri" parentElement:element];
            TBXMLElement *defefUri      = [TBXML childElementNamed: @"defefUri" parentElement:element];
            TBXMLElement *digest        = [TBXML childElementNamed: @"digest" parentElement:element];
            
            if (!(nil == resourceDesc))
            {
                [mmaResourceDesc addObject:[NSArray arrayWithObjects:      [TBXML textForElement:resourceDesc], nil]];
            }
            
            if (!(nil == mimeType))
            {
                [mmaMIMEType addObject:[NSArray arrayWithObjects:   [TBXML textForElement:mimeType], nil]];
            }
            
            if (!(nil == size))
            {
                [mmaFileSize addObject:[NSArray arrayWithObjects:   [TBXML textForElement:size], nil]];
            }
            
            if (!(nil == uri))
            {
                [mmaURI addObject:[NSArray arrayWithObjects:   [TBXML textForElement:uri], nil]];
            }
            
            if (!(nil == defefUri))
            {
                [mmaDeferencedURI addObject:[NSArray arrayWithObjects:   [TBXML textForElement:defefUri], nil]];
            }
            
            if (!(nil == digest))
            {
                [mmaDigest addObject:[NSArray arrayWithObjects:   [TBXML textForElement:digest], nil]];
            }
        }
//-------------------------------------------------------------------------------
        else if ([[TBXML elementName:element] isEqualToString:  @"area"])
        {//Resource
            //NSLog(@"area");
            //NSLog(@"area ELEMENT %@ = %@", [TBXML elementName:element], description);
            TBXMLElement *areaDesc      = [TBXML childElementNamed: @"areaDesc" parentElement:element];
            TBXMLElement *polygon       = [TBXML childElementNamed: @"polygon" parentElement:element];
            TBXMLElement *circle        = [TBXML childElementNamed: @"circle" parentElement:element];
            TBXMLElement *geocode       = [TBXML childElementNamed: @"geocode" parentElement:element];
            TBXMLElement *altitude      = [TBXML childElementNamed: @"altitude" parentElement:element];
            TBXMLElement *ceiling       = [TBXML childElementNamed: @"ceiling" parentElement:element];
            
            mmaAreaPolygon              = [[NSMutableArray alloc] init];
            if (!polygon)
            {
                [mmaAreaPolygon addObject:@"NoneMap"];
            }
            int i = 0;
            while (polygon)
            {
                //TBXMLElement *polygonPack = [TBXML childElementNamed: @"polygon" parentElement:element];
                
                //NSLog(@"polygonPack %d %@", i, [TBXML textForElement:polygon]);
                if (!(nil == polygon))
                {
                    //[mmaAreaPolygon addObject:[NSArray arrayWithObjects:   [TBXML textForElement:polygon], nil]];
                    [mmaAreaPolygon addObject:[TBXML textForElement:polygon]];
                }
                else
                {
                    [mmaAreaPolygon addObject:@"NoneMap"];
                    //[mmaAreaPolygon addObject:[NSArray arrayWithObjects:   [TBXML textForElement:polygon], nil]];
                }
                i++;
                polygon = [TBXML nextSiblingNamed:@"polygon" searchFromElement:polygon];
            }
            
            [mmaAreaPolygonAll addObject:mmaAreaPolygon];
            //NSLog(@"mmaAreaPolygonAll %d %@", i, mmaAreaPolygonAll);
            
            if (!(nil == areaDesc))
            {
                [mmaAreaDesc addObject:[NSArray arrayWithObjects:      [TBXML textForElement:areaDesc], nil]];
            }
            
            /*
            if (!(nil == polygon))
            {
                [mmaAreaPolygon addObject:[NSArray arrayWithObjects:   [TBXML textForElement:polygon], nil]];
            }
             */
            
            if (!(nil == circle))
            {
                [mmaAreaCircle addObject:[NSArray arrayWithObjects:   [TBXML textForElement:circle], nil]];
            }
            
            if (!(nil == geocode))
            {
                [mmaAreaGeocode addObject:[NSArray arrayWithObjects:   [TBXML textForElement:geocode], nil]];
            }
            
            if (!(nil == altitude))
            {
                [mmaAltitude addObject:[NSArray arrayWithObjects:   [TBXML textForElement:altitude], nil]];
            }
            
            if (!(nil == ceiling))
            {
                [mmaCeiling addObject:[NSArray arrayWithObjects:   [TBXML textForElement:ceiling], nil]];
            }
        }
    } while ((element = element->nextSibling));
    
}

#pragma mark -
#pragma mark Table View Data Source Methods
//User’s finger touches up after dragging content
//-------------------------------------------------------------------------------
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    boScrollTable = nScrollingDown;
    if (!decelerate)
    {
        [self scrollingFinish];
    }
}
//-------------------------------------------------------------------------------
//Scroll moves
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (flLastContentOffset < scrollView.contentOffset.y)
    {//Scroll up
        NSLog(@"> 0");
        boScrollTable = nScrollingUp;
    }
    else
    {
        NSLog(@"< 0");
        boScrollTable = nScrollingDown;
    }
    
    flLastContentOffset = scrollView.contentOffset.y;
}
//-------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollingFinish];
}
//-------------------------------------------------------------------------------
- (void)scrollingFinish
{
}
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
    return mmaHeadline.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
}
//-------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (boScrollTable == nScrollingUp)
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
    NSLog(@"cellAlerts");
    static NSString *CellIdentifier = @"cellAlerts";
    
    cellAlerts *cell = (cellAlerts *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellAlerts alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//-------------------------------------------------------------------------------
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblHeader.text = [NSString stringWithFormat:@"%@", mmaHeadline[indexPath.row][0]];
    
    //cell.lblHeader.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lblHeader.numberOfLines = 2;
    cell.lblHeader.adjustsFontSizeToFitWidth = YES;
//-------------------------------------------------------------------------------
//Direction
    if (!(nil == mmaDirection) && !([@"" isEqual:mmaDirection]) && (mmaDirection.count > 0))
    {
        cell.lblLocation.text = [NSString stringWithFormat:@"%@", mmaDirection[indexPath.row]];
    }
    cell.lblLocation.adjustsFontSizeToFitWidth = YES;
    
//-------------------------------------------------------------------------------
//Publish date
    NSString *strTemp;
    NSString *strTime;
    NSString *strDate;
    //2014-09-15T07:15:00-05:00
    strTime = mmaSentTime[indexPath.row][0];
    NSLog(@"Time from CAP %@", strTime);
    
    NSArray *aTime = [mmaSentTime[indexPath.row][0] componentsSeparatedByString: @"T"];
    strDate = [aTime objectAtIndex: 0];
    strTime = [aTime objectAtIndex: 1];
    
    NSArray *aTime2 = [strTime componentsSeparatedByString: @"-"];
    strTime = [aTime2 objectAtIndex: 0];

    NSLog(@"strDate %@", strDate);
    NSLog(@"strTime %@", strTime);
    
    NSDateFormatter* dateFormatter  = [[NSDateFormatter alloc] init];
    NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    dateFormatter.dateFormat        = @"yyyy-MM-dd";
    dateFormatter2.dateFormat       = @"HH:mm:ss";
    [dateFormatter setTimeZone:     [NSTimeZone localTimeZone]];
    [dateFormatter2 setTimeZone:    [NSTimeZone localTimeZone]];
    
    NSDate *date = [dateFormatter dateFromString:strDate];
    NSDate *time = [dateFormatter2 dateFromString:strTime];
    
    NSLog(@"date %@", date);
    
    dateFormatter.dateFormat        = @"dd-MMM";
    dateFormatter2.dateFormat       = @"HH:mm";
    
    strTemp = [dateFormatter stringFromDate:date];
    NSLog(@"strTemp Date %@", strTemp);
    
    strTemp = [@"Publicado a las " stringByAppendingString:[dateFormatter2 stringFromDate:time]];
    strTemp = [strTemp stringByAppendingString: @" hrs del "];
    NSLog(@"strTemp %@", strTemp);
    strTemp = [strTemp stringByAppendingString:[dateFormatter stringFromDate:date]];
    NSLog(@"strTemp %@", strTemp);
    cell.lblTime.text = strTemp;
    //[mUserDefaults setObject: self.lblUpdated.text forKey: pmmaAlertUpdatedTime];
    cell.lblTime.text = strTemp;
//-------------------------------------------------------------------------------
//Map image
    NSString *strPhotoPath;
    strPhotoPath            = [[@"Photo" stringByAppendingString:mmaMsgID[indexPath.row][0]]stringByAppendingString:@".png"];
    NSLog(@"strPhotoPath %@", strPhotoPath);
    NSArray *paths          = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath      = [documentsPath stringByAppendingPathComponent:strPhotoPath];
    NSData *pngData;
    pngData = [NSData dataWithContentsOfFile:filePath];
    CGImageRef cgref = [[UIImage imageWithData:pngData] CGImage];
    CIImage *cim = [[UIImage imageWithData:pngData]CIImage];
//-------------------------------------------------------------------------------
    if (cim == nil && cgref == NULL)
    {//Image is empty
        NSLog(@"No map image stored in phone for this event");
        cell.imgMap.image                   = nil;
//-------------------------------------------------------------------------------
        strMap = @"http://maps.googleapis.com/maps/api/staticmap?size=600x300&path=fillcolor:0xAA000033|color:0xFFFFFF00|weight:5|";
        NSLog(@"\nstrMap %@", strMap);
        
        NSLog(@"indexPath.row %ld", (long)indexPath.row);
        if (indexPath.row < mmaAreaPolygonAll.count)
        {
            //if (!(nil == mmaDirection) && !([@"" isEqual:mmaDirection]) && (mmaDirection.count > 0))
            //{
            for (int i = 0; i < [mmaAreaPolygonAll[indexPath.row] count]; i++)
            {
                strMap =  [strMap stringByAppendingString:mmaAreaPolygonAll[indexPath.row][i]];
                NSLog(@"\nstrMap2 %@", strMap);
                strMap =  [strMap stringByAppendingString:@" "];
                NSLog(@"\nstrMap2 %@", strMap);
            }

            if ([strMap length] > 0)
            {
                strMap = [strMap substringToIndex:[strMap length] - 1];
            }
        }

        strMap = [strMap stringByReplacingOccurrencesOfString:@" " withString:@"|"];
        NSLog(@"\nstrMap3 %@", strMap);
        
        NSURL   *url = [NSURL URLWithString:[strMap stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSLog(@"URl2 Photo %@", url);
        
        NSURLRequest* request = nil;
        request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       UIImage* image = [[UIImage alloc] initWithData:data];
                                       // do whatever you want with image
                                       CGImageRef cgref = [image CGImage];
                                       CIImage *cim = [image CIImage];
                                       
                                       if (cim == nil && cgref == NULL)
                                       {//Image is empty
                                           NSLog(@"Image from web is empty");
                                       }
                                       else
                                       {//URL image contains data
                                           cell.imgMap.image = image;
                                           cell.imgMap.alpha = 1.0;
                                           
                                           NSString *strPhotoPath;
                                           strPhotoPath = [[@"Map" stringByAppendingString:mmaMsgID[indexPath.row][0]]stringByAppendingString:@".png"];
                                           
                                           NSData *pngData = UIImagePNGRepresentation(image);
                                           NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                           NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
                                           NSString *filePath = [documentsPath stringByAppendingPathComponent:strPhotoPath]; //Add the file name
                                           //[pngData writeToFile:filePath atomically:YES];
                                           NSLog(@"strPhotoPath %@", strPhotoPath);
                                           //NSLog(@"pngData %@", pngData);
                                           image = nil;
                                       }
                                   }
                               }];
    }
    else
    {
        NSLog(@"Image already exists");
        cell.imgMap.image = [UIImage imageWithData:pngData];
    }
//-------------------------------------------------------------------------------
//Certainty
    if ([mmaCertainty[indexPath.row][0] isEqual: @"Observed"])
    {
        cell.lblCerBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar3.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar4.backgroundColor = [UIColor nRedGoogle85];
    }
    else if ([mmaCertainty[indexPath.row][0] isEqual: @"Likely"])
    {
        cell.lblCerBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar3.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar4.backgroundColor = [UIColor nLightGray85];
    }
    else if ([mmaCertainty[indexPath.row][0] isEqual: @"Possible"])
    {
        cell.lblCerBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblCerBar4.backgroundColor = [UIColor nLightGray85];
    }
    else if ([mmaCertainty[indexPath.row][0] isEqual: @"Unlikely"])
    {
        cell.lblCerBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblCerBar2.backgroundColor = [UIColor nLightGray85];
        cell.lblCerBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblCerBar4.backgroundColor = [UIColor nLightGray85];
    }
    else
    {
        cell.lblCerBar1.backgroundColor = [UIColor nLightGray85];
        cell.lblCerBar2.backgroundColor = [UIColor nLightGray85];
        cell.lblCerBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblCerBar4.backgroundColor = [UIColor nLightGray85];
    }
//-------------------------------------------------------------------------------
//Urgency
    if ([mmaUrgency[indexPath.row][0] isEqual: @"Immediate"])
    {
        cell.lblUrgBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar3.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar4.backgroundColor = [UIColor nRedGoogle85];
    }
    else if ([mmaUrgency[indexPath.row][0] isEqual: @"Expected"])
    {
        cell.lblUrgBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar3.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar4.backgroundColor = [UIColor nLightGray85];
    }
    else if ([mmaUrgency[indexPath.row][0] isEqual: @"Future"])
    {
        cell.lblUrgBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblUrgBar2.backgroundColor = [UIColor nLightGray85];
        cell.lblUrgBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblUrgBar4.backgroundColor = [UIColor nLightGray85];
    }
    else
    {
        cell.lblUrgBar1.backgroundColor = [UIColor nLightGray85];
        cell.lblUrgBar2.backgroundColor = [UIColor nLightGray85];
        cell.lblUrgBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblUrgBar4.backgroundColor = [UIColor nLightGray85];
    }
//-------------------------------------------------------------------------------
//Severity
    if ([mmaSeverity[indexPath.row][0] isEqual: @"Extreme"])
    {
        cell.lblSevBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar3.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar4.backgroundColor = [UIColor nRedGoogle85];
    }
    else if ([mmaSeverity[indexPath.row][0] isEqual: @"Severe"])
    {
        cell.lblSevBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar3.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar4.backgroundColor = [UIColor nLightGray85];
    }
    else if ([mmaSeverity[indexPath.row][0] isEqual: @"Moderate"])
    {
        cell.lblSevBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar2.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblSevBar4.backgroundColor = [UIColor nLightGray85];
    }
    else if ([mmaSeverity[indexPath.row][0] isEqual: @"Minor"])
    {
        cell.lblSevBar1.backgroundColor = [UIColor nRedGoogle85];
        cell.lblSevBar2.backgroundColor = [UIColor nLightGray85];
        cell.lblSevBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblSevBar4.backgroundColor = [UIColor nLightGray85];
    }
    else
    {
        cell.lblSevBar1.backgroundColor = [UIColor nLightGray85];
        cell.lblSevBar2.backgroundColor = [UIColor nLightGray85];
        cell.lblSevBar3.backgroundColor = [UIColor nLightGray85];
        cell.lblSevBar4.backgroundColor = [UIColor nLightGray85];
    }
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"AlertDetailSegue" sender:self];
    mintReqIndex = (int)indexPath.row;
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue from deals screen");
    //addToCartViewContollerForItem
    if([[segue identifier] isEqualToString:@"AlertDetailSegue"])
    {
        AlertDetails *vc = [segue destinationViewController];
    }
    
}
 */
/*
- (void) traverseElement:(TBXMLElement *)element {
    
    // Obtain first attribute from element
    TBXMLAttribute  *attribute       = element->firstAttribute;
    TBXMLElement    *entryXmlElement;
    
    do
    {
        // Display the name of the element and description
        NSString * description = [TBXML textForElement:element];
        NSLog(@"ELEMENT %@ = %@", [TBXML elementName:element], description);
        
        // if the element has child elements, process them
        if ((entryXmlElement = element->firstChild)) {
            
            do {
                [mmaEntry setValue:[TBXML textForElement:entryXmlElement] forKey:[TBXML elementName:entryXmlElement]];
                
                // Obtain next sibling element
            } while ((entryXmlElement = entryXmlElement->nextSibling));
            
            [mmaEntry addObject:mmaEntry];
        }
        
    // Obtain next sibling element
    } while ((element = element->nextSibling));
    //NSLog(@"ARRAY = %@", mmaEntry);
}
 */

/*
 - (void) traverseElement:(TBXMLElement *)element {
 
 
 TBXMLElement *entryXmlElement;
 
 do
 {
 // Display the name of the element and description
 NSString * description = [TBXML textForElement:element];
 NSLog(@"ELEMENT %@ = %@", [TBXML elementName:element], description);
 
 // Obtain first attribute from element
 TBXMLAttribute * attribute = element->firstAttribute;
 
 // if attribute is valid
 while (attribute)
 {
 // Obtain the next attribute
 attribute = attribute->next;
 }
 
 // if the element has child elements, process them
 if (element->firstChild)
 [self traverseElement:element->firstChild];
 
 // Obtain next sibling element
 } while ((element = element->nextSibling));
 }
 */
@end
