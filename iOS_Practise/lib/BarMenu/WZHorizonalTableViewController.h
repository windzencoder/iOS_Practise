//
//  HorizonalTableViewController.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-23.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  水平滚动的TableView控制器
 */
@interface WZHorizonalTableViewController : UITableViewController

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, copy) void (^changeIndex)(NSUInteger index);
@property (nonatomic, copy) void (^scrollView)(CGFloat offsetRatio, NSUInteger focusIndex, NSUInteger animationIndex);
@property (nonatomic, copy) void (^viewDidAppear)(NSInteger index);

- (instancetype)initWithViewControllers:(NSArray *)controllers;

- (void)scrollToViewAtIndex:(NSUInteger)index;

@end
