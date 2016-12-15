//
//  ViewController.m
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib
{
    self.parallaxEnabled = NO;
    self.scaleContentView = YES;
    self.contentViewScaleValue = 0.95;
    self.scaleMenuView = NO;
    self.contentViewShadowEnabled = YES;
    self.contentViewShadowRadius = 4.5;
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentNavigationController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
