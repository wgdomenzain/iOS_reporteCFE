//
//  Instructions.m
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "MyBills.h"
#import "Declarations.h"
#import "Welcome.h"

unsigned int uiWebCompleted = 0;
NSString *strCardNumber = @"";

UIActivityIndicatorView *spinnerStatus;
@interface MyBills ()

@end

@implementation MyBills

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CardIOView preload];
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
    
    //Add a notification to let app know when the keyboard appears, so the texts move accordingly
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    self.lblTitleMyBills.font       = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblLoginTitle.font         = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.txtUser.font               = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.txtPassword.font           = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblOKLogin.font            = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblCancelLogin.font        = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblPay.font                = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.lblConfirmTitle.font       = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.lblConfirmDesc.font        = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblCarNumber.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblOKConfirm.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblCancelConfirm.font      = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.txtPassword.secureTextEntry = YES;
    
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
 Keyboard appears and disappears Events
 **********************************************************************************************/
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"keyboardDidShow");
    [UIView animateWithDuration:0.6f animations:^
     {
         
         self.viewLogin.frame     = CGRectMake(self.viewLogin.frame.origin.x, 20, self.viewLogin.frame.size.width, self.viewLogin.frame.size.height);
     } completion:^(BOOL completed){}];
}
//-------------------------------------------------------------------------------
//Dissapear keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [self.txtUser resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [UIView animateWithDuration:0.6f animations:^
     {
         
         self.viewLogin.frame     = CGRectMake(self.viewLogin.frame.origin.x, 124, self.viewLogin.frame.size.width, self.viewLogin.frame.size.height);
     } completion:^(BOOL completed){}];
}
/**********************************************************************************************
 Buttons
**********************************************************************************************/
- (IBAction)btnMenuInstructionsPressed:(id)sender
{
    NSLog(@"btnMenuInstructionsPressed");
    /*
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('gsc-i-id1').value = '%@'", @"Hola"]];
    
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('ctl00_PHContenidoPag_UCLogin2_LoginUsuario_UserName').value = '%@'", self.txtUser.text]];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('ctl00_PHContenidoPag_UCLogin2_LoginUsuario_Password').value = '%@'", self.txtPassword.text]];
    
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('ctl00_PHContenidoPag_UCLogin2_LoginUsuario_LoginButton').click();"]];
     */
    
    
    NSString *js = @"function f(){ var r = document.getElementById('%@').getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();";
    NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:js, @"divServicio"]];
    CGRect rect = CGRectFromString(result);
    NSLog(@"rect x %f", rect.origin.x);
    NSLog(@"rect y %f", rect.origin.y);
    
    self.webView.scrollView.contentOffset = CGPointMake(rect.origin.x, rect.origin.y);
}

- (IBAction)btnLoginOKPressed:(id)sender
{
    [self.txtUser resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    self.viewLogin.hidden = YES;
    self.viewAlpha.hidden = YES;
    self.view.userInteractionEnabled = NO;

    [self showStatus];
    
    NSString *urlAddress = @"http://app.cfe.gob.mx/Aplicaciones/CCFE/Recibos/Consulta/login.aspx?ReturnUrl=%2fAplicaciones%2fCCFE%2fRecibos%2fConsulta%2f#";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
    self.webView.delegate = self;
}

- (IBAction)btnCancelLoginPressed:(id)sender
{
    
}

- (IBAction)btnPayPressed:(id)sender
{
    CardIOView *cardIOView = [[CardIOView alloc] initWithFrame:self.view.frame];
    cardIOView.delegate = self;
    
    [self.view addSubview:cardIOView];
}

- (IBAction)btnOKConfirmPressed:(id)sender
{
    self.viewConfirmPayment.hidden = YES;
    self.viewAlpha2.hidden = YES;
}

- (IBAction)btnCancelConfirmPressed:(id)sender
{
    self.viewConfirmPayment.hidden = YES;
    self.viewAlpha2.hidden = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *strCurrentURL = self.webView.request.URL.absoluteString;
    NSLog(@"strCurrentURL %@", strCurrentURL);
    
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
        // UIWebView object has fully loaded.
        NSLog(@"WEB Completed");
        //self.webView.scrollView.contentOffset = CGPointMake(700, 163);
        uiWebCompleted++;
        if (uiWebCompleted == 1)
        {
            NSLog(@"WEB Completed 1");
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('gsc-i-id1').value = '%@'", @"Hola"]];
            
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('ctl00_PHContenidoPag_UCLogin2_LoginUsuario_UserName').value = '%@'", self.txtUser.text]];
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('ctl00_PHContenidoPag_UCLogin2_LoginUsuario_Password').value = '%@'", self.txtPassword.text]];
            
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('ctl00_PHContenidoPag_UCLogin2_LoginUsuario_LoginButton').click();"]];
        }
        /*
        else if (uiWebCompleted == 2)
        {
            NSLog(@"WEB Completed 2");
            self.view.userInteractionEnabled = YES;
            [self hideStatus];
            self.webView.hidden = NO;
            self.lblPay.hidden  = NO;
            self.btnPay.hidden  = NO;
            //self.webView.scrollView.contentOffset = CGPointMake(800, 200);
            
            NSString *js = @"function f(){ var r = document.getElementById('%@').getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();";
            NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:js, @"divServicio"]];
            CGRect rect = CGRectFromString(result);
            NSLog(@"rect x %f", rect.origin.x);
            NSLog(@"rect y %f", rect.origin.y);
            
            self.webView.scrollView.contentOffset = CGPointMake(rect.origin.x, rect.origin.y);
            
        }
         */
        
        if ([strCurrentURL isEqual:@"http://app.cfe.gob.mx/Aplicaciones/CCFE/Recibos/Consulta/"])
        {
            NSLog(@"WEB Completed All");
            
            //self.webView.scrollView.contentOffset = CGPointMake(800, 200);
            
            NSString *js = @"function f(){ var r = document.getElementById('%@').getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();";
            NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:js, @"divServicio"]];
            CGRect rect = CGRectFromString(result);
            NSLog(@"rect x %f", rect.origin.x);
            NSLog(@"rect y %f", rect.origin.y);
            
            self.webView.scrollView.contentOffset = CGPointMake(rect.origin.x, rect.origin.y);
            
            
            /*
            js = @"function f(){ var r = document.getElementById('%@').getBoundingClientRect(); return '{{'+r.left+','+r.top+'},{'+r.width+','+r.height+'}}'; } f();";
            result = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:js, @"divServicio"]];
            rect = CGRectFromString(result);
            NSLog(@"rect x %f", rect.origin.x);
            NSLog(@"rect y %f", rect.origin.y);
            
            self.webView.scrollView.contentOffset = CGPointMake(rect.origin.x + 100, rect.origin.y);
             */

            

            
            self.view.userInteractionEnabled = YES;
            [self hideStatus];
            self.webView.hidden = NO;
            self.lblPay.hidden  = NO;
            self.btnPay.hidden  = NO;
        }
        
        
    }
}

- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)info {
    if (info) {
        // The full card number is available as info.cardNumber, but don't log that!
        NSLog(@"Received card info. Number: %@", info.redactedCardNumber);
        //NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
        // Use the card info...
        strCardNumber = info.redactedCardNumber;
        self.lblCarNumber.text = strCardNumber;
    }
    else {
        NSLog(@"User cancelled payment info");
        // Handle user cancellation here...
    }
    self.viewAlpha2.hidden = NO;
    self.viewConfirmPayment.hidden = NO;
    [cardIOView removeFromSuperview];
}

/*
- (IBAction)cancelScanCard:(id)sender
{
    [cardIOView removeFromSuperview];
}
 */

@end
