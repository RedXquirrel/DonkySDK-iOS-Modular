//
//  DRMessageViewControllerHelper.h
//  RichInbox
//
//  Created by Donky Networks on 14/07/2015.
//  Copyright (c) 2015 Donky Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DCUITheme.h"
#import "DRMessageViewController.h"

@interface DRMessageViewControllerHelper : NSObject

+ (UILabel *)noRichMessageViewWithTheme:(DCUITheme *)theme;

+ (void)addBarButtonItem:(UIBarButtonItem *)buttonItem buttonSide:(DonkyMessageViewBarButtonSide)side navigationController:(UINavigationItem *)navigationItem;

+ (void)removeBarButtonItem:(UIBarButtonItem *)buttonItem buttonSide:(DonkyMessageViewBarButtonSide)side navigationItem:(UINavigationItem *)navigationItem;

@end
