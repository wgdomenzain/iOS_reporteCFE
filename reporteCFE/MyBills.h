//
//  Instructions.h
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardIO.h"

@interface MyBills : UIViewController<UIWebViewDelegate, CardIOViewDelegate>

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleMyBills;

@property (strong, nonatomic) IBOutlet UILabel *lblLoginTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblOKLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblCancelLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblPay;
@property (strong, nonatomic) IBOutlet UILabel *lblConfirmTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblConfirmDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblCarNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblOKConfirm;
@property (strong, nonatomic) IBOutlet UILabel *lblCancelConfirm;

@property (strong, nonatomic) IBOutlet UIButton *btnPay;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewAlpha;
@property (strong, nonatomic) IBOutlet UIView *viewLogin;
@property (strong, nonatomic) IBOutlet UIView *viewStatus;
@property (strong, nonatomic) IBOutlet UIView *viewConfirmPayment;
@property (strong, nonatomic) IBOutlet UIView *viewAlpha2;


//WebView
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

//Actions
- (IBAction)btnMenuInstructionsPressed:(id)sender;
- (IBAction)btnLoginOKPressed:(id)sender;
- (IBAction)btnCancelLoginPressed:(id)sender;
- (IBAction)btnPayPressed:(id)sender;
- (IBAction)btnOKConfirmPressed:(id)sender;
- (IBAction)btnCancelConfirmPressed:(id)sender;


@end
