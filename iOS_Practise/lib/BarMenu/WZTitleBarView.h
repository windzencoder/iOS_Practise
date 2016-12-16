//
//  TitleBarView.h
//  iosapp
//
//  Created by chenhaoxiang on 14-10-20.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNormalTitleColor [UIColor colorWithRed:144.0/255 green:144.0/255 blue:144.0/255 alpha:1.0f]
#define kSelectedTitleColor [UIColor colorWithRed:0/255 green:144.0/255 blue:0/255 alpha:1.0f]

/**
 *  菜单View
 */
@interface WZTitleBarView : UIScrollView

/**
 *  按钮标题集合
 */
@property (nonatomic, strong) NSMutableArray *titleButtons;
/**
 *  当前的索引值
 */
@property (nonatomic, assign) NSUInteger currentIndex;
/**
 *  点击按钮后的回调
 */
@property (nonatomic, copy) void (^titleButtonClicked)(NSUInteger index);

/**
 *  初始化方法
 *
 *  @param frame  大小
 *  @param titles 按钮的标题
 *
 *  @return TitleBarView的实例
 */
- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray*)titles;


@end
