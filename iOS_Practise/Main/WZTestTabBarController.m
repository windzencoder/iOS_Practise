//
//  OSCTabBarController.m
//  iosapp
//
//  Created by chenhaoxiang on 12/15/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "WZTestTabBarController.h"
#import "WZSwipableViewController.h"



@interface WZTestTabBarController () <UITabBarControllerDelegate, UINavigationControllerDelegate>
{
    
}

@end

@implementation WZTestTabBarController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //咨询
    UIViewController *newsViewCtl = [[UIViewController alloc]  init];
    //热点
   UIViewController *hotNewsViewCtl = [[UIViewController alloc]  init];
    //博客
   UIViewController *blogViewCtl = [[UIViewController alloc]  init];
    //推荐
   UIViewController *recommendBlogViewCtl = [[UIViewController alloc]  init];


    
    //综合
    WZSwipableViewController *newsSVC = [[WZSwipableViewController alloc] initWithTitle:@"综合"
                                                                       andSubTitles:@[@"资讯", @"热点", @"博客", @"推荐"]
                                                                     andControllers:@[newsViewCtl, hotNewsViewCtl, blogViewCtl,recommendBlogViewCtl]
                                                                        underTabbar:YES];
    

    
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[
                             newsSVC
                             ];
    
    NSArray *titles = @[@"综合"];
    NSArray *images = @[@"tabbar-news"];
    //tabbar item
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]]];
    }];


}



@end
