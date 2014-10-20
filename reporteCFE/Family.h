//
//  Family.h
//  AlertaMX
//
//  Created by Walter on 09/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Declarations.h"
#import "InfiniteScrollPicker.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Pushwoosh/PushNotificationManager.h>

@interface Family : UIViewController

//Variables
@property (nonatomic,strong) Declarations               *Declarations;
@property (nonatomic,strong) PushNotificationManager    *PushNotificationManager;

//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgEmptyName;
@property (strong, nonatomic) IBOutlet UIImageView *imgEmptyPhone;
@property (strong, nonatomic) IBOutlet UIImageView *imgEmptyPhoneFamilyInitial;


//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleFamily;
@property (strong, nonatomic) IBOutlet UILabel *lblWelcome;
@property (strong, nonatomic) IBOutlet UILabel *lblExplanation;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnRegister;
@property (strong, nonatomic) IBOutlet UILabel *lblPerson;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleWelcomeFamily;
@property (strong, nonatomic) IBOutlet UILabel *lblExplanationWelcomeFamily;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnAddFamily;
@property (strong, nonatomic) IBOutlet UILabel *lblBtnAddFamilyMenu;
@property (strong, nonatomic) IBOutlet UILabel *lblCancelAddFamilyMenu;

//Table
@property (strong, nonatomic) IBOutlet UITableView *tblFamily;

//Texts
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneFamilyInitial;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneAddFamily;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewInfo;
@property (strong, nonatomic) IBOutlet UIView *viewFamily;
@property (strong, nonatomic) IBOutlet UIView *viewStatus;
@property (strong, nonatomic) IBOutlet UIView *viewWelcomeFamily;
@property (strong, nonatomic) IBOutlet UIView *viewRegister;
@property (strong, nonatomic) IBOutlet UIView *viewFamilyTable;
@property (strong, nonatomic) IBOutlet UIView *viewAddFamily;



//Actions
- (IBAction)btnMenuFamilyPressed:(id)sender;
- (IBAction)btnRegisterPressed:(id)sender;
- (IBAction)btnAddFamilyPressed:(id)sender;
- (IBAction)btnRefreshPressed:(id)sender;
- (IBAction)btnAddFamilyMenuPressed:(id)sender;
- (IBAction)btnAddFamilyMenuOKPressed:(id)sender;
- (IBAction)btnCancelAddFamilyMenuPressed:(id)sender;



@end
