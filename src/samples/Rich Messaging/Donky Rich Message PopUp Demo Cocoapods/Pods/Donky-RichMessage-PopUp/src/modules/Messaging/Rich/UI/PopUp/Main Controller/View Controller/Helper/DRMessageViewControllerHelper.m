//
//  DRMessageViewControllerHelper.m
//  RichInbox
//
//  Created by Chris Watson on 14/07/2015.
//  Copyright (c) 2015 Chris Wunsch. All rights reserved.
//

#import "DRMessageViewControllerHelper.h"
#import "UIView+AutoLayout.h"
#import "DRichMessage+Localization.h"
#import "DRMessageViewController.h"

@implementation DRMessageViewControllerHelper

+ (UILabel *)noRichMessageView {

    UILabel *noRichMessages = [UILabel autoLayoutView];
    [noRichMessages setUserInteractionEnabled:NO];
    [noRichMessages setTextColor:[UIColor blackColor]];
    [noRichMessages setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [noRichMessages setTextAlignment:NSTextAlignmentCenter];
    [noRichMessages setNumberOfLines:0];
    [noRichMessages setText:DRichMessageLocalizedString(@"rich_inbox_no_messages_selected")];

    return noRichMessages;
}

+ (void)addBarButtonItem:(UIBarButtonItem *)buttonItem buttonSide:(DonkyMessageViewBarButtonSide)side navigationController:(UINavigationItem *)navigationItem {
    if (side == DMVLeftSide) {
        NSMutableArray *leftBarButtonItems = [[navigationItem leftBarButtonItems] mutableCopy] ? : [[NSMutableArray alloc] init];
        [leftBarButtonItems addObject:buttonItem];
        navigationItem.leftBarButtonItems = leftBarButtonItems;
    }
    else {
        NSMutableArray *rightBarButtonItems = [[navigationItem rightBarButtonItems] mutableCopy] ? : [[NSMutableArray alloc] init];
        [rightBarButtonItems addObject:buttonItem];
        navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
}

+ (void)removeBarButtonItem:(UIBarButtonItem *)buttonItem buttonSide:(DonkyMessageViewBarButtonSide)side navigationItem:(UINavigationItem *)navigationItem {
    if (side == DMVLeftSide) {
        NSMutableArray *leftBarButtonItems = [[navigationItem leftBarButtonItems] mutableCopy] ? : [[NSMutableArray alloc] init];
        [leftBarButtonItems removeObject:buttonItem];
        navigationItem.leftBarButtonItems = leftBarButtonItems;
    }
    else {
        NSMutableArray *rightBarButtonItems = [[navigationItem rightBarButtonItems] mutableCopy] ? : [[NSMutableArray alloc] init];
        [rightBarButtonItems removeObject:buttonItem];
        navigationItem.rightBarButtonItems = rightBarButtonItems;
    }
}
@end
