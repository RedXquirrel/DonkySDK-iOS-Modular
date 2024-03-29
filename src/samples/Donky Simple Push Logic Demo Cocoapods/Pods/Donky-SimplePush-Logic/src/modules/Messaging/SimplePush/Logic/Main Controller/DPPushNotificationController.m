//
//  DPPushNotificationController.m
//  DonkyPushModule
//
//  Created by Chris Watson on 13/03/2015.
//  Copyright (c) 2015 Dynmark International Ltd. All rights reserved.
//

#import "DPPushNotificationController.h"
#import "DNDonkyCore.h"
#import "NSMutableDictionary+DNDictionary.h"
#import "DNConstants.h"
#import "DNClientNotification.h"
#import "DNNetworkController.h"
#import "DCMMainController.h"
#import "DCAConstants.h"

static NSString *const DNPendingPushNotifications = @"PendingPushNotifications";
static NSString *const DNInteractionResult = @"InteractionResult";

@interface DPPushNotificationController ()
@property(nonatomic, strong) DNModuleDefinition *moduleDefinition;
@property(nonatomic, copy) DNSubscriptionBachHandler pushLogicHandler;
@end

@implementation DPPushNotificationController

#pragma mark -
#pragma mark - Setup Singleton

+(DPPushNotificationController *)sharedInstance
{
    static DPPushNotificationController *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[DPPushNotificationController alloc] initPrivate];
    });
    return sharedInstance;
}

-(instancetype)init
{
    return [self initPrivate];
}

-(instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        
        [self setPendingPushNotifications:[[NSMutableArray alloc] init]];

        self.moduleDefinition = [[DNModuleDefinition alloc] initWithName:NSStringFromClass([self class]) version:@"1.0.0.0"];
    }
    
    return  self;
}

- (void) dealloc {
    [self stop];
}

- (void)start {

    __weak DPPushNotificationController *weakSelf = self;

    self.pushLogicHandler = ^(NSArray *batch) {
        NSArray *batchNotifications = batch;
        [batchNotifications enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[DNServerNotification class]]) {
                [weakSelf pushNotificationReceived:obj];
            }
        }];
    };

    //Simple Push:
    self.simplePushMessage = [[DNSubscription alloc] initWithNotificationType:kDNDonkyNotificationSimplePush batchHandler:self.pushLogicHandler];
    [self.simplePushMessage setAutoAcknowledge:NO];

    [[DNDonkyCore sharedInstance] subscribeToDonkyNotifications:self.moduleDefinition subscriptions:@[self.simplePushMessage]];

    [[DNDonkyCore sharedInstance] subscribeToLocalEvent:DNInteractionResult handler:^(DNLocalEvent *event) {
        DNClientNotification *interactionResult = [[DNClientNotification alloc] initWithType:DNInteractionResult data:[event data] acknowledgementData:nil];
        [[DNNetworkController sharedInstance] queueClientNotifications:@[interactionResult]];
    }];

    [[DNDonkyCore sharedInstance] subscribeToLocalEvent:kDNDonkyEventAppWillEnterForegroundNotification handler:^(DNLocalEvent *event) {
        if ([self.pendingPushNotifications count]) {
            DNLocalEvent *pushOpenEvent = [[DNLocalEvent alloc] initWithEventType:kDAEventInfluencedAppOpen
                                                                        publisher:NSStringFromClass([self class])
                                                                        timeStamp:[NSDate date]
                                                                             data:[self pendingPushNotifications]];
            [[DNDonkyCore sharedInstance] publishEvent:pushOpenEvent];
        }
    }];
}

- (void)stop {
    [[DNDonkyCore sharedInstance] unSubscribeToDonkyNotifications:self.moduleDefinition subscriptions:@[self.simplePushMessage]];
}

#pragma mark -
#pragma mark - Core Logic

- (void)pushNotificationReceived:(DNServerNotification *)notification {

    //Clean out nulls:
    NSString *notificationID = [notification serverNotificationID];

    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[self pendingPushNotifications] addObject:notificationID];
    }

    //Publish event:
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data dnSetObject:[self pendingPushNotifications] forKey:DNPendingPushNotifications];
    [data dnSetObject:notification forKey:kDNDonkyNotificationSimplePush];

    DNLocalEvent *pushEvent = [[DNLocalEvent alloc] initWithEventType:kDNDonkyNotificationSimplePush
                                                            publisher:NSStringFromClass([self class])
                                                            timeStamp:[NSDate date]
                                                                 data:data];
    [[DNDonkyCore sharedInstance] publishEvent:pushEvent];

    //Mark as received:
    [DCMMainController markMessageAsReceived:notification];
}

@end
