//
//  DNNetworkHelper.h
//  Core Container
//
//  Created by Chris Watson on 17/03/2015.
//  Copyright (c) 2015 Donky Networks Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNBlockDefinitions.h"
#import "DNRequest.h"
#import "DNSessionManager.h"

@interface DNNetworkHelper : NSObject

+ (BOOL)isPerformingBlockingTask:(NSMutableArray *)exchangeRequests;

+ (void)handleError:(NSError *)error task:(NSURLSessionDataTask *)task request:(DNRequest *)request;

+ (void)deviceUserDeleted:(NSError *)error;

+ (void)queueClientNotifications:(NSArray *)notifications pendingNotifications:(NSMutableArray *)pendingNotifications;

+ (NSError *)queueContentNotifications:(NSArray *)notifications pendingNotifications:(NSMutableArray *)pendingNotifications;

+ (void)processNotificationResponse:(id)responseData task:(NSURLSessionDataTask *)task pendingClientNotifications:(NSMutableArray *)pendingClientNotifications pendingContentNotifications:(NSMutableArray *)pendingContentNotifications success:(DNNetworkSuccessBlock)successBlock failure:(DNNetworkFailureBlock)failureBlock;

+ (void)showNoConnectionAlert;

+ (void)reAuthenticateWithRequest:(DNRequest *)request failure:(DNNetworkFailureBlock)failureBlock;

+ (NSURLSessionTask *)performNetworkTaskForRequest:(DNRequest *)request sessionManager:(DNSessionManager *)sessionManager success:(DNNetworkSuccessBlock)successBlock failure:(DNNetworkFailureBlock)failureBlock;

+ (BOOL)isCallNecessary:(DNRequest *)request;

+ (BOOL)isRequest:(DNRequest *)request duplicated:(NSMutableArray *)queuedRequests;
@end
