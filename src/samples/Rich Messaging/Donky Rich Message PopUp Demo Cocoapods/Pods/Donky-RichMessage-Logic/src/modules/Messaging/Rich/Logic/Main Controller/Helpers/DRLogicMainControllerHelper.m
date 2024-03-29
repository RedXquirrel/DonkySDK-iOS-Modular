//
//  DRLogicMainControllerHelper.m
//  RichInbox
//
//  Created by Chris Watson on 23/06/2015.
//  Copyright (c) 2015 Chris Wunsch. All rights reserved.
//

#import "DRLogicMainControllerHelper.h"
#import "DNServerNotification.h"
#import "DRLogicHelper.h"
#import "DNLocalEvent.h"
#import "DNConstants.h"
#import "DNDonkyCore.h"
#import "DCMMainController.h"
#import "DNLoggingController.h"
#import "DNDataController.h"
#import "DRConstants.h"
#import "NSMutableDictionary+DNDictionary.h"
#import "DCAConstants.h"

static NSString *const DRLAnalyticsInfluencedAppOpens = @"DonkyAnalyticsInfluencedAppOpen";

@implementation DRLogicMainControllerHelper

+ (DNSubscriptionBachHandler)richMessageHandler:(DRLogicMainController *)mainController {

    DNSubscriptionBachHandler richMessageHandler = ^(NSArray *batch) {
        //Does this message already exist:
        NSArray *allRichMessages = batch;
        [allRichMessages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DNServerNotification *notification = obj;
            if (![mainController doesRichMessageExistForID:[notification serverNotificationID]]) {
                DNRichMessage *richMessage = [DRLogicHelper saveRichMessage:obj];
                if (richMessage) {
                    DNLocalEvent *richEvent = [[DNLocalEvent alloc] initWithEventType:kDNDonkyNotificationRichMessage
                                                                            publisher:NSStringFromClass([mainController class])
                                                                            timeStamp:[NSDate date]
                                                                                 data:richMessage];
                    [[DNDonkyCore sharedInstance] publishEvent:richEvent];

                    [DCMMainController markMessageAsReceived:obj];
                }
                else {
                    DNErrorLog(@"Could not create rich message from server notification: %@", obj);
                }
            }
            else {
                DNInfoLog(@"This is a duplicate message, do nothing...");
                return;
            }

            [mainController richMessageNotificationsReceived:allRichMessages];

        }];

        [[DNDataController sharedInstance] saveAllData];

        DNLocalEvent *localEvent = [[DNLocalEvent alloc] initWithEventType:kDNDonkyNotificationRichMessage publisher:NSStringFromClass([mainController class]) timeStamp:[NSDate date] data:batch];
        [[DNDonkyCore sharedInstance] publishEvent:localEvent];
    };

    return richMessageHandler;
}

+ (DNLocalEventHandler)notificationLoaded:(DRLogicMainController *)mainController {

    DNLocalEventHandler notificationLoaded = ^(DNLocalEvent *event) {
        if ([mainController doesRichMessageExistForID:[event data]]) {
            DNRichMessage *richMessage = [DRLogicHelper richMessageForID:[event data]];
            if (richMessage) {
                DNLocalEvent *richEvent = [[DNLocalEvent alloc] initWithEventType:kDRichMessageNotificationTapped
                                                                        publisher:NSStringFromClass([mainController class])
                                                                        timeStamp:[NSDate date]
                                                                             data:richMessage];
                [[DNDonkyCore sharedInstance] publishEvent:richEvent];
            }
        }
    };

    return notificationLoaded;
}

+ (DNLocalEventHandler)backgroundNotificationsReceived:(NSMutableArray *)notifications {
    DNLocalEventHandler backgroundNotifications = ^(DNLocalEvent *event) {
        [notifications addObject:[event data][@"NotificationID"]];
    };
    return backgroundNotifications;
}

+ (void)richMessageNotificationReceived:(NSArray *)notifications backgroundNotifications:(NSMutableArray *)backgroundNotifications {

    __block NSMutableArray *backgroundNotificationsToKeep = [[NSMutableArray alloc] init];
    __block NSMutableArray *notificationsToKeep = [notifications mutableCopy];

    [notifications enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DNServerNotification *serverNotification = obj;
        if ([backgroundNotifications containsObject:[serverNotification serverNotificationID]]) {
            [backgroundNotificationsToKeep addObject:serverNotification];
            [notificationsToKeep removeObject:serverNotification];
        }
    }];

    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        //We need to increment the badge count here as the badge count is not incremented automatically when
        //the app is open and a notification is received.
        NSInteger count = [[UIApplication sharedApplication] applicationIconBadgeNumber];
        count += [notificationsToKeep count];

        DNLocalEvent *changeBadgeEvent = [[DNLocalEvent alloc] initWithEventType:kDNDonkySetBadgeCount
                                                                       publisher:NSStringFromClass([self class])
                                                                       timeStamp:[NSDate date]
                                                                            data:@(count)];
        [[DNDonkyCore sharedInstance] publishEvent:changeBadgeEvent];
    }

    //Publish event:
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data dnSetObject:backgroundNotificationsToKeep forKey:kDRPendingRichNotifications];
    [data dnSetObject:notificationsToKeep forKey:kDNDonkyNotificationRichMessage];

    DNLocalEvent *pushEvent = [[DNLocalEvent alloc] initWithEventType:kDRichMessageNotificationEvent
                                                            publisher:NSStringFromClass([self class])
                                                            timeStamp:[NSDate date]
                                                                 data:data];
    [[DNDonkyCore sharedInstance] publishEvent:pushEvent];
}

@end
