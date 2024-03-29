//
//  DNNotificationController.h
//  NAAS Core SDK Container
//
//  Created by Chris Watson on 16/02/2015.
//  Copyright (c) 2015 Donky Networks Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 Helper class to register/unRegister a devices push notification token with the network.
 
 @since 2.0.0.0
 */
@interface DNNotificationController : NSObject

/*!
 Method to request push notification permission from the user.
 
 @since 2.0.0.0
 */
+ (void)registerForPushNotifications;

/*!
 Method to register the token against the current device on the network. NOTE: THis is the method that must be called in the application delegate's application:didRegisterForRemoteNotificationsWithDeviceToken:
 
 @param token the token data object returned to the application delegate.
 
 @since 2.0.0.0
 */
+ (void)registerDeviceToken:(NSData *)token;

/*!
 Method to handle all incoming remote notifications. Use this method for the following application delegate callbacks:
 application:didReceiveRemoteNotification:, application:didReceiveRemoteNotification:, application:handleActionWithIdentifier:forRemoteNotification:.
 
 @param userInfo   the user info dictionary containing the remote notification payload.
 @param identifier identifier of the button pressed to launch the application. NOTE: only used for interactive remote notifications. iOS 8.0 + only.
 @param handler    a completion handler, this is used internally by the SDK to return any deep links/data embedded in a button action of notification.
 
 @since 2.0.0.0
 */
+ (void)didReceiveNotification:(NSDictionary *)userInfo handleActionIdentifier:(NSString *)identifier completionHandler:(void (^)(NSString *))handler;

/*!
  Method to disable remote notifications. Remote notifications are set to enable by default upon registration. Thereafter, calling this method with false will trigger the SDK to remove the token from the network and this device will no longer be sent remote notifications. Calling it again with true will trigger the device token to be sent to the network again.
 
 @param disable whether push should be disable or enabled.
 
 @since 2.0.0.0
 */
+ (void)enablePush:(BOOL)disable;

@end
