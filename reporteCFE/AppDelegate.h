//
//  AppDelegate.h
//  AlertaMX
//
//  Created by Walter on 04/09/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pushwoosh/PushNotificationManager.h>


extern NSString *const SCSessionStateChangedNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate, PushNotificationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)transitionToViewController:(UIViewController *)viewController
                    withTransition:(UIViewAnimationOptions)transition;

@end
