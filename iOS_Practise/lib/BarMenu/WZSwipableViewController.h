//
//  SwipableViewController.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-19.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZTitleBarView.h"
#import "WZHorizonalTableViewController.h"

/**
 *  滑动VC
 */
@interface WZSwipableViewController : UIViewController

@property (nonatomic, strong) WZHorizonalTableViewController *viewPager;
@property (nonatomic, strong) WZTitleBarView *titleBar;

- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers underTabbar:(BOOL)underTabbar;
- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers;
- (void)scrollToViewAtIndex:(NSUInteger)index;

@end
