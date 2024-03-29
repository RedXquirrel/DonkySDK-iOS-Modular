//
//  DKConstants.h
//  Logging
//
//  Created by Chris Watson on 13/02/2015.
//  Copyright (c) 2015 Donky Networks Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/*!
 A full list of the Donky SDK constants. They are broken down into sections with the use
 of pragma marks. All Donky SDK Constants follow the same naming convention: k - 'DN' - Name of the Relevant Module - Variable Name
 e.g. kDNLoggingFileName (where logging = DNLoggingController) nad FileName is the variable that this constant is used for.
 */

#pragma mark -
#pragma mark - Network API

/*!
 The root host URL.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkHostURL;

/*!
 Registration route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkRegistration;

/*!
 Account Registration route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkRegistrationDeviceUser;

/*!
 Update APNS token route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkRegistrationPush;

/*!
 Update device details route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkRegistrationDevice;

/*!
 Update client details route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkRegistrationClient;

/*!
 Authentication route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkAuthentication;

/*!
 Notification Synchronise route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkNotificationSynchronise;

/*!
 Get a specific notification route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkGetNotification;

/*!
 Send debug log to network route.
 
 @since 2.0.0.0
 */
extern NSString * const kDNNetworkSendDebugLog;

/*!

 Send and get a users selected tags.

 @since 2.0.0.0
 */
extern NSString * const kDNNetworkUserTags;


#pragma mark -
#pragma mark - Donky Notification Types

/*!
 Donky Server notification, use this a Notification Subscriber type if you wish to receive inbound requests for debug logs.
 
 @since 2.0.0.0
 */
extern NSString * const kDNDonkyNotificationTransmitDebugLog;

/*!
 Donky Server notification, use this a Notification Subscriber type if you wish to receive inbound Simple Push Messages.
 
 @since 2.0.0.0
 */

extern NSString * const kDNDonkyNotificationSimplePush;

/*!
 Donky Server notification, use this a Notification Subscriber type if you wish to receive inbound Rich Messages.

 @since 2.0.0.0
 */

extern NSString * const kDNDonkyNotificationRichMessage;

/*!
 Donky Server notification, use this a Notification Subscriber type if you wish to receive inbound Rich Messages.

 @since 2.0.1.0
 */
extern NSString * const kDNDonkyNotificationNewDeviceMessage;

#pragma mark -
#pragma mark - Donky Event Types

/*!
 Subscribe to this event to receive notifications when the users registration details have changed.

 This notification should contain the DNUserDetails in the 'Data' property of the DNLocalEvent.
 
 @since 2.0.0.0
 */
extern NSString * const kDNDonkyEventRegistrationChangedUser;

/*!
 Subscribe to this event to receive notifications when the devices registration details have changed.

 This notification should contain the DNDeviceDetails in the 'Data' property of the DNLocalEvent.

 @since 2.0.0.0
 */
extern NSString * const kDNDonkyEventRegistrationChangedDevice;

/*!
 Subscribe to this event to receive notifications when the devices connection state changes.

 This notification should contain a Dictionary containing the following values: IsConnected (NSNumber) && ConnectionType (AFNetworkReachabilityStatus enum value) in the data property.
 
 @since 2.0.0.0
 */
extern NSString * const kDNDonkyEventNetworkStateChanged;

/*!
 Subscribe to this event to receive notifications when a new registration has occurred.

 This notification should contain contain a nil data property.
 
 @since 2.0.0.0
 */
extern NSString * const kDNEventRegistration;

/*!
 Subscribe to this event to receive notifications when a new registration has occurred.

 This notification should contain a Dictionary containing the following values: LogLevel (DonkyLogType enum value), Message (NSString *) in the data property.
 
 @since 2.0.0.0
 */
extern NSString * const kDNDonkyLogEvent;

/*!
 Subscribe to this event to receive notifications when the application is opened.

  This notification should contain contain a nil data property.
 
 @since 2.0.0.0
 */
extern NSString * const kDNDonkyEventAppOpen;

/*!
 Subscribe to this event ro receive notifications when the application first goes into a background state.

 This notification should contain contain a nil data property.
 
 @since 2.0.0.0
 */
extern NSString * const kDNDonkyEventAppClose;

/*!
 Subscribe to this event to receive notifications when the application is entering the foreground.
 
 @since 2.2.2.7
 */
extern NSString * const kDNDonkyEventAppWillEnterForegroundNotification;

/*!
 Subscribe to this event to receive notifications when a remote notification has been tapped to load the application. 
 NOTE: This is only applicable to notifications with the 'content' flag set i.e. Rich Messages.
 
 @since 2.2.2.7
 */
extern NSString * const kDNDonkyEventNotificationLoaded;

/*!
 Subscribe to this event to receive notifications when a remote notification was received and the application was in the 
 background.
 
 @since 2.2.2.7
 */
extern NSString * const kDNDonkyEventBackgroundNotificationReceived;

/*!
 Publish this event when you want to cahnge the badge count of your appplication AND set the 
 new badge count on the network.
 
 @since 2.2.2.7
 */
extern NSString * const kDNDonkySetBadgeCount;

#pragma mark -
#pragma mark - Donky Config Items

//
extern NSString * const kDNConfigPlistFileName;

//
extern NSString * const kDNConfigSDKVersion;

//
extern NSString * const kDNConfigLoggingOptions;

//
extern NSString * const kDNConfigLoggingEnabled;

//
extern NSString * const kDNConfigOutputWarningLogs;

//
extern NSString * const kDNConfigOutputErrorLogs;

//
extern NSString * const kDNConfigOutputInfoLogs;

//
extern NSString * const kDNConfigOutputDebugLogs;

//
extern NSString * const kDNConfigOutputSensitiveLogs;

//
extern NSString * const kDNConfigDisplayNoInternetAlert;

//
extern NSString * const kDNDebugLogSubmissionInterval;

#pragma mark -
#pragma mark - Debug Logging Constants

//
extern NSString * const kDNLoggingFileName;

//
extern NSString * const kDNLoggingDirectoryName;

//
extern NSString * const kDNLoggingDateFormat;

//
extern NSString * const kDNLoggingArchiveFileName;

//
extern NSString * const kDNLoggingArchiveDirectoryName;

#pragma mark -
#pragma mark - Keychain & Security

//
extern NSString * const kDNKeychainDeviceSecret;

//
extern NSString * const kDNKeychainDevicePassword;

//
extern NSString * const kDNKeychainAccessToken;

#pragma mark -
#pragma mark - Misc

//
extern NSString * const kDNMiscOperatingSystem;

//
extern NSString * const kDonkyErrorDomain;

/*!
 The file size limit for each of the debug logs (maximum of 2)
 
 @since 2.0.0.0
 */
extern CGFloat const kDonkyLogFileSizeLimit;

//
extern NSString * const kDNTempDirectory;

#pragma mark -
#pragma mark - Donky Notification Keys

//
extern NSString * const kDNDonkyNotificationCustomDataKey;

#pragma mark -
#pragma mark - Donky Module Versions

//
extern NSString * const kDNDonkyCoreVersion;

//
extern NSString * const kDNDonkyNetworkVersion;

//
extern NSString * const kDNDonkyNotificationVersion;


