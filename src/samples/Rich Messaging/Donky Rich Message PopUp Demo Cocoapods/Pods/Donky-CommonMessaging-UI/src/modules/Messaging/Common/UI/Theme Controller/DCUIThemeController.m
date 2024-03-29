//
//  DCUIThemeController.m
//  RichInbox
//
//  Created by Chris Watson on 03/06/2015.
//  Copyright (c) 2015 Chris Wunsch. All rights reserved.
//

#import "DCUIThemeController.h"
#import "DCUITheme.h"
#import "NSMutableDictionary+DNDictionary.h"

@interface DCUIThemeController ()
@property(nonatomic, strong) NSMutableDictionary *themes;
@end

@implementation DCUIThemeController

+(DCUIThemeController *)sharedInstance
{
    static dispatch_once_t pred;
    static DCUIThemeController *sharedInstance = nil;

    dispatch_once(&pred, ^{
        sharedInstance = [[DCUIThemeController alloc] initPrivate];
    });

    return sharedInstance;
}

-(instancetype)init {
    return [DCUIThemeController sharedInstance];
}

-(instancetype)initPrivate
{

    self  = [super init];

    if (self) {

        self.themes = [[NSMutableDictionary alloc] init];
        
    }

    return self;
}

- (void) dealloc {
    self.themes = nil;
}

- (void)addTheme:(DCUITheme *)theme {
    [self.themes dnSetObject:theme forKey:[theme themeName]];
}

- (DCUITheme *)themeForName:(NSString *)themeName {
    return self.themes[themeName];
}

@end
