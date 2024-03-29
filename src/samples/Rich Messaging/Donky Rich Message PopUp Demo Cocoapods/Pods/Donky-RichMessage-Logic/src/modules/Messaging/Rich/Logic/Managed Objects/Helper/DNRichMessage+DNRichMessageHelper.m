//
//  DNRichMessage+DNRichMessageHelper.m
//  RichInbox
//
//  Created by Chris Watson on 13/06/2015.
//  Copyright (c) 2015 Chris Wunsch. All rights reserved.
//

#import "DNRichMessage+DNRichMessageHelper.h"
#import "NSDate+DNDateHelper.h"

@implementation DNRichMessage (DNRichMessageHelper)

- (BOOL)richHasCompletelyExpired {
    return (([[self expiryTimestamp] donkyHasDateExpired] && ![self expiredBody].length) || [[self sentTimestamp] donkyHasMessageExpired]);
}

@end
