//
//  Family.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Family.h"
#import "SBJson.h"
#import "Declarations.h"
#import "Welcome.h"
#import "AppDelegate.h"
#import "cellFamily.h"

BOOL boTxtName      = FALSE;
BOOL boTxtPhone     = FALSE;
BOOL boTxtFamily    = FALSE;
BOOL boTxtFamilyInitial    = FALSE;

//BOOL
BOOL    boScrollFamilyTable           = nScrollingUp;

//Float
float   flFamilyLastContentOffset     = 0;

//UILabel *viewStatus;
UIActivityIndicatorView *spinnerStatus;

@interface Family ()
{
    InfiniteScrollPicker *isp;
}
@end

@implementation Family

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
    if (mboAlreadyRegistered)
    {
        self.viewFamilyTable.hidden = NO;
        mApp.networkActivityIndicatorVisible    = YES;
        NSOperationQueue *queue = [NSOperationQueue new];
        
        NSInvocationOperation *opT1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
        [queue addOperation:opT1];
        
        NSInvocationOperation *opT2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
        [opT2 addDependency:opT1];
        [queue addOperation:opT2];
    }
}
//-------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewFamily.userInteractionEnabled  = YES;
    self.viewStatus.hidden                  = YES;
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
    
    //Add a notification to let app know when the keyboard appears, so the texts move accordingly
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    self.lblTitleFamily.font        = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblWelcome.font            = [UIFont fontWithName: @"OpenSans-Light" size: 24.0];
    self.lblExplanation.font        = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    self.lblBtnRegister.font        = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblPerson.font             = [UIFont fontWithName: @"OpenSans-Light" size: 12.0];

    self.lblTitleWelcomeFamily.font         = [UIFont fontWithName: @"OpenSans-Light" size: 24.0];
    self.lblExplanationWelcomeFamily.font   = [UIFont fontWithName: @"OpenSans-Light" size: 14.0];
    self.lblBtnAddFamily.font               = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.txtName.font                       = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.txtPhone.font                      = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.txtPhoneFamilyInitial.font         = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.lblStatus.layer.borderColor   = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8].CGColor;
    self.lblStatus.layer.borderWidth   = 4.0;
    self.lblStatus.layer.cornerRadius  = 8;
    
    spinnerStatus = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    [spinnerStatus stopAnimating];
    
    CGRect frame = spinnerStatus.frame;
    frame.origin.x = self.viewStatus.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = self.viewStatus.frame.size.height / 2 - frame.size.height / 2;
    spinnerStatus.frame = frame;
    [self.viewStatus addSubview:spinnerStatus];
    
    mstrUserType = nMan;
    
    NSMutableArray *set1 = [[NSMutableArray alloc] init];
    
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"2_Woman.png"]]];
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"3_Kid.png"]]];
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"4_Pregnant.png"]]];
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"5_Handicap.png"]]];
    [set1 addObject:[UIImage imageNamed:[NSString stringWithFormat:@"1_Man.png"]]];
    
    isp = [[InfiniteScrollPicker alloc] initWithFrame:CGRectMake(14, 0, 292, 100)];
    [isp setItemSize:CGSizeMake(65, 65)];
    [isp setImageAry:set1];
    [isp setSelectedItem:4];
    
    [self.viewInfo addSubview:isp];
}

/**********************************************************************************************
 Keyboard appears and disappears Events
 **********************************************************************************************/
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"iPhone 5");
    [UIView animateWithDuration:0.2f animations:^ {
        self.viewInfo.frame = CGRectMake(self.viewInfo.frame.origin.x, 0,self.viewInfo.frame.size.width,self.viewInfo.frame.size.height);
    }];
    
}
//-------------------------------------------------------------------------------
//Dissapear keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.txtName       resignFirstResponder];
    [self.txtPhone      resignFirstResponder];

    //Move info view
    [UIView animateWithDuration:0.2f animations:^ {
            self.viewInfo.frame = CGRectMake(self.viewInfo.frame.origin.x, 150,self.viewInfo.frame.size.width,self.viewInfo.frame.size.height);
        }];
}

/**********************************************************************************************
 Text Fields
 **********************************************************************************************/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"Some text changed");
    if (textField == self.txtName)
    {
        NSLog(@"txtName");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtName                   = nTextNoEmpty;
            self.imgEmptyName.hidden    = YES;
            
            if ([newString length] > 50)
            {
                return NO;
            }
        }
        else
        {
            boTxtName                   = nTextEmpty;
        }
        return YES;
    }
//---------------------------------------------------------------------------------------------
    else if (textField == self.txtPhone)
    {
        NSLog(@"txtPhone");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtPhone                  = nTextNoEmpty;
            self.imgEmptyPhone.hidden   = YES;
            
            if ([newString length] > 50)
            {
                return NO;
            }
        }
        else
        {
            boTxtPhone                  = nTextEmpty;
        }
        return YES;
    }
    
    else if (textField == self.txtPhoneFamilyInitial)
    {
        NSLog(@"txtPhone");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtFamilyInitial                  = nTextNoEmpty;
            self.imgEmptyPhone.hidden   = YES;
            
            if ([newString length] > 50)
            {
                return NO;
            }
        }
        else
        {
            boTxtPhone                  = nTextEmpty;
        }
        return YES;
    }
    return NO;
}
//---------------------------------------------------------------------------------------------
- (void)checkTextsEmpty
{
    NSLog(@"checkTextsEmpty");
    boTxtFamily = nTextNoEmpty;
    if (boTxtName == nTextEmpty)
    {
        self.imgEmptyName.hidden    = NO;
        boTxtFamily = nTextEmpty;
    }
    else if (boTxtPhone == nTextEmpty)
    {
        self.imgEmptyPhone.hidden    = NO;
        boTxtFamily = nTextEmpty;
    }
}
/**********************************************************************************************
 Image Picker
 **********************************************************************************************/
- (void)infiniteScrollPicker:(InfiniteScrollPicker *)infiniteScrollPicker didSelectAtImage:(UIImage *)image
{
    if (image == [UIImage imageNamed:@"1_Man.png"])
    {
        NSLog(@"selected s1_0");
        self.lblPerson.text = @"Hombre";
        mstrUserType = nMan;
    }
    else if (image == [UIImage imageNamed:@"2_Woman.png"])
    {
        NSLog(@"selected s1_1");
        self.lblPerson.text = @"Mujer";
        mstrUserType = nWoman;
    }
    else if (image == [UIImage imageNamed:@"3_Kid.png"])
    {
        NSLog(@"selected s1_2");
        self.lblPerson.text = @"Niño/Niña";
        mstrUserType = nChild;
    }
    else if (image == [UIImage imageNamed:@"5_Handicap.png"])
    {
        NSLog(@"selected s1_3");
        self.lblPerson.text = @"Discapacitado";
        mstrUserType = nHandicap;
    }
    else  if (image == [UIImage imageNamed:@"4_Pregnant.png"])
    {
        NSLog(@"selected s1_4");
        self.lblPerson.text = @"Embarazada";
        mstrUserType = nPregnant;
    }
    else
    {
        NSLog(@"selected %@", image);
    }
}
/**********************************************************************************************
 Button Actions
 **********************************************************************************************/
- (IBAction)btnMenuFamilyPressed:(id)sender
{
    NSLog(@"btnMenuFamilyPressed");
    Welcome *vc = [mStoryboard instantiateViewControllerWithIdentifier:@"Welcome"];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate transitionToViewController:vc
                             withTransition:UIViewAnimationOptionTransitionFlipFromRight];
}

- (IBAction)btnRegisterPressed:(id)sender
{
    [self checkTextsEmpty];
    if ( boTxtFamily == nTextNoEmpty)
    {
        NSLog(@"btnRegisterPressed nTextNoEmpty");
        self.viewRegister.hidden = YES;
        [self showStatus];
        
        mstrUserName        = self.txtName.text;
        mstrUserMobile      = self.txtPhone.text;
        NSLog(@"mstrUserPushToken %@", mstrUserPushToken);
        
        [self.Declarations postRegister];
        
        [UIView animateWithDuration:1.0f animations:^
         {
             self.viewWelcomeFamily.frame     = CGRectMake(0, self.viewWelcomeFamily.frame.origin.y, self.viewWelcomeFamily.frame.size.width, self.viewWelcomeFamily.frame.size.height);
         }
            completion:^(BOOL completed)
         {
             [self hideStatus];
             }];
    }
}

- (IBAction)btnAddFamilyPressed:(id)sender
{
    [self showStatus];
    mstrFamilyMobile = self.txtPhoneFamilyInitial.text;
    [self.Declarations loadAddFamily];
    [self hideStatus];
    self.viewFamilyTable.hidden = NO;
    [self.tblFamily reloadData];
}

- (IBAction)btnRefreshPressed:(id)sender
{
    mApp.networkActivityIndicatorVisible    = YES;
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opT1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [queue addOperation:opT1];
    
    NSInvocationOperation *opT2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    [opT2 addDependency:opT1];
    [queue addOperation:opT2];
}

- (IBAction)btnAddFamilyMenuPressed:(id)sender
{
    [UIView animateWithDuration:1.0f animations:^
    {
        self.viewAddFamily.frame     = CGRectMake(0, self.viewAddFamily.frame.origin.y, self.viewAddFamily.frame.size.width, self.viewAddFamily.frame.size.height);
    }
    completion:^(BOOL completed)
     {}];

    /*
    mApp.networkActivityIndicatorVisible    = YES;
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opT1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [queue addOperation:opT1];
    
    NSInvocationOperation *opT2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    [opT2 addDependency:opT1];
    [queue addOperation:opT2];
     */
}

- (IBAction)btnAddFamilyMenuOKPressed:(id)sender {
}

- (IBAction)btnCancelAddFamilyMenuPressed:(id)sender {
}

//---------------------------------------------------------------------------------------------
- (void)task1
{
    [self.Declarations loadGetFamily];
}
//---------------------------------------------------------------------------------------------
- (void)task2
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.tblFamily reloadData];
    mApp.networkActivityIndicatorVisible    = NO;
    });
}
//---------------------------------------------------------------------------------------------
- (void)task3
{
    [self.Declarations loadAddFamily];
}
//---------------------------------------------------------------------------------------------
- (void)showStatus
{
    [spinnerStatus startAnimating];
    self.viewStatus.hidden = NO;
}
//---------------------------------------------------------------------------------------------
- (void)hideStatus
{
    [spinnerStatus stopAnimating];
    self.viewStatus.hidden = YES;
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
    return mmaFamilyMembersName.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}
//-------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (boScrollFamilyTable == nScrollingUp)
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
    NSLog(@"cellFamily");
    static NSString *CellIdentifier = @"cellFamily";
    
    cellFamily *cell = (cellFamily *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellFamily alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//-------------------------------------------------------------------------------
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblName.text   = mmaFamilyMembersName[indexPath.row];
    
    if ([mmaFamilyMembersStatus[indexPath.row] isEqual:@"2"])
    {
        cell.lblStatus.text = @"Estoy bien";
        cell.imgStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"1_Ok.png"]];
    }
    else if ([mmaFamilyMembersStatus[indexPath.row] isEqual:@"1"])
    {
        cell.lblStatus.text = @"¡Estoy atrapado!";
        cell.imgStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"2_Trapped.png"]];
    }
    else if ([mmaFamilyMembersStatus[indexPath.row] isEqual:@"3"])
    {
        cell.lblStatus.text = @"¡Estoy lastimado!";
        cell.imgStatus.image = [UIImage imageNamed:[NSString stringWithFormat:@"3_MedicalAid.png"]];
    }
//-------------------------------------------------------------------------------
    if ([mmaFamilyMembersType[indexPath.row] isEqual:nMan])
    {
        cell.imgFamily.image = [UIImage imageNamed:[NSString stringWithFormat:@"1_Man.png"]];
    }
    else if ([mmaFamilyMembersStatus[indexPath.row] isEqual:nWoman])
    {
        cell.imgFamily.image = [UIImage imageNamed:[NSString stringWithFormat:@"2_Woman.png"]];
    }
    else if ([mmaFamilyMembersStatus[indexPath.row] isEqual:nChild])
    {
        cell.imgFamily.image = [UIImage imageNamed:[NSString stringWithFormat:@"3_Kid.png"]];
    }
    else if ([mmaFamilyMembersStatus[indexPath.row] isEqual:nPregnant])
    {
        cell.imgFamily.image = [UIImage imageNamed:[NSString stringWithFormat:@"4_Pregnant.png"]];
    }
    else if ([mmaFamilyMembersStatus[indexPath.row] isEqual:nHandicap])
    {
        cell.imgFamily.image = [UIImage imageNamed:[NSString stringWithFormat:@"5_Handicap.png"]];
    }
//-------------------------------------------------------------------------------
//Publish date
/*
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
    cell.lblUpdated.text = strTemp;
    //[mUserDefaults setObject: self.lblUpdated.text forKey: pmmaAlertUpdatedTime];
    cell.lblUpdated.text = strTemp;
 */
//-------------------------------------------------------------------------------
  
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
