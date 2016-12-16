//
//  HorizonalTableViewController.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-23.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "WZHorizonalTableViewController.h"

@interface WZHorizonalTableViewController ()

@end

static NSString *kHorizonalCellID = @"HorizonalCell";

@implementation WZHorizonalTableViewController

- (instancetype)initWithViewControllers:(NSArray *)controllers
{
    self = [super init];
    if (self) {
        _controllers = [NSMutableArray arrayWithArray:controllers];
        for (UIViewController *controller in controllers) {
            [self addChildViewController:controller];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /***** 为解决iPhone 6 下的popviewcontroller后的问题而做的无奈之举，这样会引入新的问题，very ugly，亟待解决 *****/
    self.tableView = [UITableView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollsToTop = NO;
    //变换，垂直滚动的tableView变成水平滚动的tableView
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHorizonalCellID];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _controllers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kHorizonalCellID forIndexPath:indexPath];
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);//cell再变换
    cell.contentView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //在cell的contentView上添加controller的view
    UIViewController *controller = _controllers[indexPath.row];
    controller.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:controller.view];
    
    return cell;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollStop:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollStop:NO];
}



#pragma mark -

- (void)scrollToViewAtIndex:(NSUInteger)index
{
    //并不会导致调用scrollViewDidScroll:
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:NO];
    
    _currentIndex = index;
    if (_viewDidAppear) {_viewDidAppear(index);}
}

- (void)scrollStop:(BOOL)didScrollStop
{
    CGFloat horizonalOffset = self.tableView.contentOffset.y;
    CGFloat screenWidth = self.tableView.frame.size.width;
    //偏移量
    CGFloat offsetRatio = (NSUInteger)horizonalOffset % (NSUInteger)screenWidth / screenWidth;
    //表示如果超过screenWidth的一半 就表示达到下一个
    NSUInteger focusIndex = (horizonalOffset + screenWidth / 2) / screenWidth;
    
    if (horizonalOffset != focusIndex * screenWidth) {
        //左滑 右滑
        NSUInteger animationIndex = horizonalOffset > focusIndex * screenWidth ? focusIndex + 1: focusIndex - 1;
        //向右滑动 offsetRatio = 1 - offsetRatio
        if (focusIndex > animationIndex) {offsetRatio = 1 - offsetRatio;}
        if (_scrollView) {
            _scrollView(offsetRatio, focusIndex, animationIndex);
        }
    }

    if (didScrollStop) {
        /*
        [_controllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
            if ([vc isKindOfClass:[UITableViewController class]]) {
                ((UITableViewController *)vc).tableView.scrollsToTop = (idx == focusIndex);
            }
        }];
         */
        _currentIndex = focusIndex;
        
        if (_changeIndex) {_changeIndex(focusIndex);}
    }
}




@end
