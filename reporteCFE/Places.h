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
#import "KLHorizontalSelect.h"
#import <GoogleMaps/GoogleMaps.h>

@interface Places : UIViewController<KLHorizontalSelectDelegate, CLLocationManagerDelegate, GMSMapViewDelegate>

//Variables
@property (nonatomic, strong) IBOutlet KLHorizontalSelect   *horizontalSelect;
@property (nonatomic,strong) Declarations                   *Declarations;

//Images

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblTitlePlaces;
@property (strong, nonatomic) IBOutlet UILabel *lblSubViewTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblSubViewDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblSubViewCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblSubViewOK;


//Scrollview
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewAlerts;


//Tables
@property (strong, nonatomic) IBOutlet UITableView *tblAlerts;

//Views
@property (strong, nonatomic) IBOutlet UIView *viewSubView;
@property (strong, nonatomic) IBOutlet UIView *viewFailureLocation;
@property (strong, nonatomic) IBOutlet UIView *viewAlpha;





//Actions
@end
