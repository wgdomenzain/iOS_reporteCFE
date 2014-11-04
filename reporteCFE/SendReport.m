//
//  AlertDetails.m
//  AlertaMX
//
//  Created by Walter on 19/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "SendReport.h"
#import "SBJson.h"
#import "AppDelegate.h"

#define nRPU        1
#define nGauge      2
ScanditSDKBarcodePicker *picker;

GMSMapView  *mapView;
GMSMarker   *markerLocation;
BOOL        boMyLocation = FALSE;

UIActivityIndicatorView *spinnerStatus;

unsigned uiBarCode = nRPU;
@interface SendReport ()

@end

@implementation UIImage (Crop)

- (UIImage *)crop:(CGRect)rect
{
    rect = CGRectMake(rect.origin.x*self.scale,
                      rect.origin.y*self.scale,
                      rect.size.width*self.scale,
                      rect.size.height*self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:self.scale
                                    orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}
@end

@implementation SendReport

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
}

- (void)didReceiveMemoryWarning {
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor redColor];
    
    self.navigationController.navigationItem.backBarButtonItem.tintColor    = [UIColor nRedGoogle100];
    self.navigationController.navigationBar.tintColor                       = [UIColor blueColor];
    
    /*
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
     */
    
    //self.lblSelectMyLocation.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
    //self.lblSelectMyLocation.layer.borderWidth = 2.0;
    self.lblSelectMyLocation.clipsToBounds = YES;
    self.lblSelectMyLocation.layer.cornerRadius = 5;
    
    self.scrollReport.contentSize   = CGSizeMake(self.scrollReport.frame.size.width, 776);
    
    //Fonts
    self.lblTitleMain.font          = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblTitleRPU.font           = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.txtRPU.font                = [UIFont fontWithName: @"OpenSans-Light" size: 19.0];
    self.lblTitleMap.font           = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.lblUseLocation.font        = [UIFont fontWithName: @"OpenSans" size: 14.0];
    self.lblTitleComments.font      = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.txtComments.font           = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblAddImage.font           = [UIFont fontWithName: @"OpenSans" size: 14.0];
    self.lblSendReport.font         = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    //self.btnRemoveImage.font        = [UIFont fontWithName: @"OpenSans" size: 16.0];
    
    self.lblContactTitle.font       = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.lblContactCancel.font      = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblContactOK.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.txtEmail.font              = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.txtTwitter.font            = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.lblAckTitle.font       = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.lblAckOK.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblAckDesc.font        = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    self.lblCFE.font                = [UIFont fontWithName: @"OpenSans-Light" size: 22.0];
    self.txtCFE.font                = [UIFont fontWithName: @"OpenSans-Light" size: 19.0];
    
    self.lblContactTitle.font       = [UIFont fontWithName: @"OpenSans-Light" size: 21.0];
    self.lblContactCancel.font      = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    self.lblContactOK.font          = [UIFont fontWithName: @"OpenSans-Light" size: 18.0];
    
    //Text content
    self.lblTitleMain.text                          = mstrRequestedReport;
    self.lblTitleMain.adjustsFontSizeToFitWidth     = YES;
    //self.txtTwitter.text                            = mstrUserTwitter;
    

    self.txtComments.text = @"Danos más detalle de cuál es el problema";
    self.txtComments.textColor = [UIColor lightGrayColor]; //optional
    
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

    
    [self paintMap];

}
//---------------------------------------------------------------------------------------------
- (void)showStatus
{
    mApp.networkActivityIndicatorVisible    = YES;
    [spinnerStatus startAnimating];
    self.viewStatus.hidden = NO;
}
//---------------------------------------------------------------------------------------------
- (void)hideStatus
{
    mApp.networkActivityIndicatorVisible    = NO;
    [spinnerStatus stopAnimating];
    self.viewStatus.hidden = YES;
}


- (void) paintMap
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                            longitude:mlongitude
                                                                 zoom:15.0];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.delegate = self;
    mapView.frame = CGRectMake(0, 0, self.viewMapInteractive.frame.size.width, self.viewMapInteractive.frame.size.height);
    mapView.myLocationEnabled = YES;
    
    
    [self.viewMapInteractive addSubview:mapView];
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Danos más detalle de cuál es el problema"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
    
    [self.scrollReport setContentOffset:CGPointMake(self.scrollReport.contentOffset.x, self.scrollReport.frame.origin.y + 250) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Danos más detalle de cuál es el problema";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
/**********************************************************************************************
 Keyboard appears and disappears Events
 **********************************************************************************************/
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"keyboardDidShow");
    [UIView animateWithDuration:0.6f animations:^
     {
         self.viewContact.frame     = CGRectMake(self.viewContact.frame.origin.x, 20, self.viewContact.frame.size.width, self.viewContact.frame.size.height);
         //self.viewAck.frame     = CGRectMake(self.viewAck.frame.origin.x, 20, self.viewAck.frame.size.width, self.viewAck.frame.size.height);
     } completion:^(BOOL completed){}];
}
//-------------------------------------------------------------------------------
//Dissapear keyboard

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    [self.txtRPU resignFirstResponder];
    [self.txtComments resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtTwitter resignFirstResponder];
    [[self view] endEditing:YES];
    [UIView animateWithDuration:0.6f animations:^
     {
         self.viewContact.frame     = CGRectMake(self.viewContact.frame.origin.x, 124, self.viewContact.frame.size.width, self.viewContact.frame.size.height);
     } completion:^(BOOL completed){}];
}
//-------------------------------------------------------------------------------
- (IBAction)btnBackPressed:(id)sender
{
    [self performSegueWithIdentifier:@"BackToFailure" sender:self];
}
//-------------------------------------------------------------------------------
- (IBAction)btnUseMyLocationPressed:(id)sender
{
    [self.txtCFE resignFirstResponder];
    [self.txtComments resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self. txtRPU resignFirstResponder];
    [self.txtTwitter resignFirstResponder];
    if (boMyLocation)
    {
        self.lblSelectMyLocation.backgroundColor = [UIColor groupTableViewBackgroundColor];
        boMyLocation = FALSE;
        markerLocation.map = nil;
    }
    else
    {
        self.lblSelectMyLocation.backgroundColor = [UIColor nGreenGoogle100];
        boMyLocation = TRUE;
        
        markerLocation.map = nil;
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
        markerLocation = [GMSMarker markerWithPosition:position];
        markerLocation.title = @"Reporte";
        markerLocation.map = mapView;
        
        mstrReqLat = [NSString stringWithFormat:@"%f", mlatitude];
        mstrReqLng = [NSString stringWithFormat:@"%f", mlongitude];
    }
}
//-------------------------------------------------------------------------------
- (IBAction)btnAddImage:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:[NSString stringWithFormat:@"Cancelar"]
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:[NSString stringWithFormat:@"Tomar foto"], [NSString stringWithFormat:@"Seleccionar de carrete"], nil];
    [actionSheet showInView:self.view];
}
//-------------------------------------------------------------------------------
- (IBAction)btnSendReportPressed:(id)sender
{
    [UIView animateWithDuration:0.6f animations:^
     {
         self.viewAlpha.hidden = NO;
         self.viewContact.frame     = CGRectMake(20, self.viewContact.frame.origin.y, self.viewContact.frame.size.width, self.viewContact.frame.size.height);
     } completion:^(BOOL completed){}];
}
//-------------------------------------------------------------------------------
- (IBAction)btnRemoveImagePressed:(id)sender
{
    [UIView animateWithDuration:0.6f animations:^
     {
         self.viewImage.hidden = YES;
         self.lblSendReport.frame     = CGRectMake(self.lblSendReport.frame.origin.x, 616, self.lblSendReport.frame.size.width, self.lblSendReport.frame.size.height);
         self.btnSendReport.frame    = CGRectMake(self.btnSendReport.frame.origin.x, 616, self.btnSendReport.frame.size.width, self.btnSendReport.frame.size.height);
         self.scrollReport.contentSize   = CGSizeMake(self.scrollReport.frame.size.width, 716);
     } completion:^(BOOL completed){}];
}
//-------------------------------------------------------------------------------
- (IBAction)btnContactOKPressed:(id)sender
{
    [self.txtRPU resignFirstResponder];
    [self.txtComments resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtTwitter resignFirstResponder];
    [[self view] endEditing:YES];

    mstrReqDesc     = self.txtComments.text;
    mstrReqEmail    = self.txtEmail.text;
    mstrReqTwitter  = self.txtTwitter.text;
    mstrReqRPU      = self.txtRPU.text;
    self.viewContact.frame     = CGRectMake(340, self.viewContact.frame.origin.y, self.viewContact.frame.size.width, self.viewContact.frame.size.height);
    
    
    mApp.networkActivityIndicatorVisible    = YES;
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opT1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [queue addOperation:opT1];
    
    NSInvocationOperation *opT2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    [opT2 addDependency:opT1];
    [queue addOperation:opT2];
    
    NSInvocationOperation *opT3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task3) object:nil];
    [opT3 addDependency:opT1];
    [opT3 addDependency:opT2];
    [queue addOperation:opT3];
}
//-------------------------------------------------------------------------------
- (IBAction)btnContactCancelPressed:(id)sender
{
    [UIView animateWithDuration:0.6f animations:^
     {
         self.viewAlpha.hidden = YES;
         self.viewContact.frame     = CGRectMake(340, self.viewContact.frame.origin.y, self.viewContact.frame.size.width, self.viewContact.frame.size.height);
     } completion:^(BOOL completed){}];
}
//-------------------------------------------------------------------------------
- (IBAction)btnAckOKPressed:(id)sender
{
    self.viewAlpha.hidden = YES;
    self.viewAck.frame     = CGRectMake(340, self.viewAck.frame.origin.y, self.viewAck.frame.size.width, self.viewAck.frame.size.height);
    [self performSegueWithIdentifier:@"BackToFailure" sender:self];
}
//-------------------------------------------------------------------------------
- (IBAction)btnBarcodePressed:(id)sender
{
    uiBarCode = nRPU;
    picker = [[ScanditSDKBarcodePicker alloc] initWithAppKey:@"wb+y/ozv6yoG0+FvdUlM6nX54XAWxpXrrimznJ6dQWk"];
    // set delegate
    picker.overlayController.delegate = self;
    
    //start the scanning process:
    [picker startScanning];
    //Show the scanner. The easiest way to do so is by presenting it modally:
    [self presentViewController:picker animated:YES completion:nil];
}
//-------------------------------------------------------------------------------
- (IBAction)btnAddGauge:(id)sender
{
    uiBarCode = nGauge;
    picker = [[ScanditSDKBarcodePicker alloc] initWithAppKey:@"wb+y/ozv6yoG0+FvdUlM6nX54XAWxpXrrimznJ6dQWk"];
    // set delegate
    picker.overlayController.delegate = self;
    
    //start the scanning process:
    [picker startScanning];
    //Show the scanner. The easiest way to do so is by presenting it modally:
    [self presentViewController:picker animated:YES completion:nil];
}
//-------------------------------------------------------------------------------
- (void) task1
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showStatus];
    });
}
//-------------------------------------------------------------------------------
- (void) task2
{
    [self.Declarations loadSetReport];
}
//-------------------------------------------------------------------------------
- (void) task3
{
    NSString *strTemp = @"Hemos recibido su reporte exitosamente. Su número de folio es ";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideStatus];
        
        self.lblAckDesc.text = [strTemp stringByAppendingString:mstrReportID];
        
        [self.Declarations postUploadPhoto];
        
        [UIView animateWithDuration:0.6f animations:^
         {
             self.viewAck.frame     = CGRectMake(20, self.viewAck.frame.origin.y, self.viewAck.frame.size.width, self.viewAck.frame.size.height);
         } completion:^(BOOL completed){}];
    });
}
- (void)scanditSDKOverlayController: (ScanditSDKOverlayController *)scanditSDKOverlayController
                     didScanBarcode:(NSDictionary *)barcodeResult {
    // add your own code to handle the barcode result e.g.
    NSString *symbology = [barcodeResult objectForKey:@"symbology"];
    NSString *barcode = [barcodeResult objectForKey:@"barcode"];
    NSLog(@"scanned %@ barcode: %@", symbology, barcode);
    
    //NSMutableString *str = barcode ;
    NSString *strTest = [barcode substringWithRange:NSMakeRange(2,13)];
    if (uiBarCode == nRPU)
    {
        self.txtRPU.text        = strTest;
    }
    else if (uiBarCode == nGauge)
    {
        self.txtCFE.text = barcode;//[@"El número de medidor es: " stringByAppendingString:barcode];
        self.txtCFE.adjustsFontSizeToFitWidth = YES;
    }
    
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)scanditSDKOverlayController: (ScanditSDKOverlayController *)scanditSDKOverlayController
                didCancelWithStatus:(NSDictionary *)status {
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    // add your own code to handle the user canceling the barcode scan process
}
- (void)scanditSDKOverlayController: (ScanditSDKOverlayController *)scanditSDKOverlayController
                    didManualSearch:(NSString *)input {
    // add your own code to handle user input in the search bar
    // (only required if you use the search bar provided by the Scandit SDK
}

/**********************************************************************************************
 Camera Functions
 **********************************************************************************************/
#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
                
        self.imgReport.image = image;
        self.imgReport.backgroundColor  = [UIColor clearColor];
        self.lblAddImage.hidden      = YES;
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [UIView animateWithDuration:1.0f animations:^
        {
            
            self.scrollReport.contentSize   = CGSizeMake(self.scrollReport.frame.size.width, 846);
            self.lblSendReport.frame     = CGRectMake(self.lblSendReport.frame.origin.x, 776, self.lblSendReport.frame.size.width, self.lblSendReport.frame.size.height);
            self.btnSendReport.frame    = CGRectMake(self.btnSendReport.frame.origin.x, 776, self.btnSendReport.frame.size.width, self.btnSendReport.frame.size.height);
            self.viewImage.hidden = NO;
        } completion:^(BOOL completed){}];
        
        if (self.newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
//-------------------------------------------------------------------------------
//Calculate Factor
        float factor;
        if (self.imgReport.image.size.width > self.imgReport.image.size.height)
        {
            factor = 200/self.imgReport.image.size.height;
        }
        else
        {
            factor = 200/self.imgReport.image.size.width;
        }
        
//-------------------------------------------------------------------------------
        //Resize and upload to Amazon
        CGSize newSize = CGSizeMake(self.imgReport.image.size.width*factor, self.imgReport.image.size.height*factor);
        UIGraphicsBeginImageContext(newSize);
        [self.imgReport.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        mimgReport = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //[self.Declarations postUploadPhoto];
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}
//-------------------------------------------------------------------------------
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: [NSString stringWithFormat:@"Error"]
                              message: [NSString stringWithFormat:@"Error Foto"]
                              delegate: nil
                              cancelButtonTitle:[NSString stringWithFormat:@"OK"]
                              otherButtonTitles:nil];
        [alert show];
    }
}
//-------------------------------------------------------------------------------
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{
    
    float width     = newSize.width;
    float height    = newSize.height;
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    [image drawInRect: rect];
    
    UIImage *smallImage;
    
    smallImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}
/**********************************************************************************************
 Alert View Functions
 **********************************************************************************************/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Tomar foto"]])
    {
        NSLog(@"gTakePicture");
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker
                               animated:YES completion:nil];
            self.newMedia = YES;
        }
    }
//-------------------------------------------------------------------------------
    else if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Seleccionar de carrete"]])
    {
        NSLog(@"gSelectPicture");
        
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker
                               animated:YES completion:nil];
            self.newMedia = NO;
        }
    }
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

-(void) mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"You tapped long at %f,%f", coordinate.latitude, coordinate.longitude);
    
    self.lblSelectMyLocation.backgroundColor = [UIColor groupTableViewBackgroundColor];
    boMyLocation = FALSE;
    markerLocation.map = nil;
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    markerLocation = [GMSMarker markerWithPosition:position];
    markerLocation.title = @"Reporte";
    markerLocation.map = mapView;
    
    mstrReqLat = [NSString stringWithFormat:@"%f", coordinate.latitude];
    mstrReqLng = [NSString stringWithFormat:@"%f", coordinate.longitude];
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    [self.txtCFE resignFirstResponder];
    [self.txtComments resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self. txtRPU resignFirstResponder];
    [self.txtTwitter resignFirstResponder];
}

@end
