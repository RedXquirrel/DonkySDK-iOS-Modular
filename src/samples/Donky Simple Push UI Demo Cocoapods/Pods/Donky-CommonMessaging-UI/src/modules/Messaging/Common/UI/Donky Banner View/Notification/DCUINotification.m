//
//  DCUINotification.m
//  RichInbox
//
//  Created by Chris Watson on 16/06/2015.
//  Copyright © 2015 Chris Wunsch. All rights reserved.
//

#import "DCUINotification.h"
#import "NSDate+DNDateHelper.h"

static NSString *const DCUISentTimeStamp = @"sentTimestamp";
static NSString *const DCUIExpiryTimeStamp = @"expiryTimeStamp";
static NSString *const DCUIBody = @"body";
static NSString *const DCUIMessageType = @"messageType";
static NSString *const DCUISenderMessageID = @"senderMessageId";
static NSString *const DCUIMessageID = @"messageId";
static NSString *const DCUIContextItems = @"contextItems";
static NSString *const DCUISenderInternalUserID = @"senderInternalUserId";
static NSString *const DCUIAvatarAssetID = @"avatarAssetId";
static NSString *const DCUISenderDisplayName = @"senderDisplayName";
static NSString *const DCUIButtonSets = @"buttonSets";

@interface DCUINotification ()
@property(nonatomic, readwrite) NSDate *sentTimeStamp;
@property(nonatomic, readwrite) NSDate *expiryTimeStamp;
@property(nonatomic, readwrite) NSString *body;
@property(nonatomic, readwrite) NSString *messageType;
@property(nonatomic, readwrite) NSString *senderMessageID;
@property(nonatomic, readwrite) NSString *messageID;
@property(nonatomic, readwrite) NSDictionary *contextItems;
@property(nonatomic, readwrite) NSString *senderInternalUserID;
@property(nonatomic, readwrite) NSString *avatarAssetID;
@property(nonatomic, readwrite) NSString *senderDisplayName;
@property(nonatomic, readwrite) NSArray * buttonSets;
@property(nonatomic, readwrite) NSString *serverId;
@end

@implementation DCUINotification

- (instancetype)initWithNotification:(DNServerNotification *)notification {

    self = [self init];

    if (self) {
        self.sentTimeStamp = [NSDate donkyDateFromServer:[self objectForKey:DCUISentTimeStamp inNotification:notification]];
        self.expiryTimeStamp = [NSDate donkyDateFromServer:[self objectForKey:DCUIExpiryTimeStamp inNotification:notification]];
        self.body = [self objectForKey:DCUIBody inNotification:notification];
        self.messageType = [self objectForKey:DCUIMessageType inNotification:notification];
        self.senderMessageID = [self objectForKey:DCUISenderMessageID inNotification:notification];
        self.messageID = [self objectForKey:DCUIMessageID inNotification:notification];
        self.contextItems = [self objectForKey:DCUIContextItems inNotification:notification];
        self.senderInternalUserID = [self objectForKey:DCUISenderInternalUserID inNotification:notification];
        self.avatarAssetID = [self objectForKey:DCUIAvatarAssetID inNotification:notification];
        self.senderDisplayName = [self objectForKey:DCUISenderDisplayName inNotification:notification];
        self.buttonSets = [self objectForKey:DCUIButtonSets inNotification:notification];

        self.serverId = [notification serverNotificationID];

    }

    return self;
}

- (id)objectForKey:(NSString *)key inNotification:(DNServerNotification *) notification {
    return [notification data][key];
}

@end
