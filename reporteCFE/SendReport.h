//
//  AlertDetails.h
//  AlertaMX
//
//  Created by Walter on 19/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Declarations.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Accounts/Accounts.h>
#import "ScanditSDKOverlayController.h"


@interface SendReport : UIViewController<UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,GMSMapViewDelegate, ABPeoplePickerNavigationControllerDelegate, ScanditSDKOverlayControllerDelegate>

@property (nonatomic,strong) Declarations                   *Declarations;

//Buttons
@property (strong, nonatomic) IBOutlet UIButton *btnSendReport;
@property (strong, nonatomic) IBOutlet UIButton *btnRemoveImage;

//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgReport;
@property BOOL newMedia;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitleRPU;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleMain;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleMap;
@property (strong, nonatomic) IBOutlet UILabel *lblUseLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectMyLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleComments;
@property (strong, nonatomic) IBOutlet UILabel *lblAddImage;
@property (strong, nonatomic) IBOutlet UILabel *lblSelectImage;
@property (strong, nonatomic) IBOutlet UILabel *lblSendReport;
@property (strong, nonatomic) IBOutlet UILabel *lblContactTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblContactOK;
@property (strong, nonatomic) IBOutlet UILabel *lblContactCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblAckTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblAckDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblAckOK;
@property (strong, nonatomic) IBOutlet UILabel *lblCFE;


//ScrollViews
@property (strong, nonatomic) IBOutlet UIScrollView *scrollReport;

//Texts
@property (strong, nonatomic) IBOutlet UITextField *txtRPU;
@property (strong, nonatomic) IBOutlet UITextView *txtComments;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtTwitter;
@property (strong, nonatomic) IBOutlet UITextField *txtCFE;


//Views
@property (strong, nonatomic) IBOutlet UIView *viewRPU;
@property (strong, nonatomic) IBOutlet UIView *viewMap;
@property (strong, nonatomic) IBOutlet UIView *viewComments;
@property (strong, nonatomic) IBOutlet UIView *viewMapInteractive;
@property (strong, nonatomic) IBOutlet UIView *viewImage;
@property (strong, nonatomic) IBOutlet UIView *viewContact;
@property (strong, nonatomic) IBOutlet UIView *viewAlpha;
@property (strong, nonatomic) IBOutlet UIView *viewStatus;
@property (strong, nonatomic) IBOutlet UIView *viewAck;


//Actions
- (IBAction)btnBackPressed:(id)sender;
- (IBAction)btnUseMyLocationPressed:(id)sender;
- (IBAction)btnAddImage:(id)sender;
- (IBAction)btnSendReportPressed:(id)sender;
- (IBAction)btnRemoveImagePressed:(id)sender;
- (IBAction)btnContactOKPressed:(id)sender;
- (IBAction)btnContactCancelPressed:(id)sender;
- (IBAction)btnAckOKPressed:(id)sender;
- (IBAction)btnBarcodePressed:(id)sender;
- (IBAction)btnAddGauge:(id)sender;



@end
