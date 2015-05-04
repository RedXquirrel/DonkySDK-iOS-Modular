//
//  DNRetryObject.h
//  Core Container
//
//  Created by Chris Watson on 21/03/2015.
//  Copyright (c) 2015 Chris Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DNRequest;

@interface DNRetryObject : NSObject

@property(nonatomic) NSUInteger numberOfRetries;

@property(nonatomic) NSUInteger sectionRetries;

@property(nonatomic, readonly) DNRequest *request;

- (instancetype)initWithRequest:(DNRequest *)request;

- (void)incrementRetryCount;

- (void)incrementSection;

@end