//
//  WZAutoLoopView.h
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZBannerModel;

/**
 *  轮播View
 */
@interface WZAutoLoopView : UIView

/**
 *  点击图片事件回调
 */
@property (nonatomic, copy)   void(^clickAutoLoopCallBackBlock)(WZBannerModel *banner);

/**
 *   是否自动滚动（默认为YES）
 */
@property (nonatomic, assign) BOOL autoLoopScroll;

/**
 *  自动滚动的时间间隔（单位为s）
 */
@property (nonatomic, assign) NSTimeInterval autoLoopScrollInterval;

/**
 *  是否有下拉动画 在对应的viewcontroller的 scrollViewDidScroll代理里实现wf_parallaxHeaderViewWithOffset方法  默认为no
 */
@property (nonatomic, assign) BOOL stretchAnimation;

/**
 *  bannner数组 数据源
 */
@property (nonatomic, strong) NSArray *banners;

/**
 *  重新加载数据
 */
- (void)reloadData;

/**
 *  带视差的偏移
 *
 *  @param offset 偏移量
 */
- (void)parallaxHeaderViewWithOffset:(CGPoint)offset;


@end
