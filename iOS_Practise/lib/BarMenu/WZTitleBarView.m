//
//  TitleBarView.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-20.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "WZTitleBarView.h"

@interface WZTitleBarView ()

@end

@implementation WZTitleBarView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _currentIndex = 0;
        _titleButtons = [NSMutableArray new];
        
        CGFloat buttonWidth = CGRectGetWidth(frame) / titles.count;
        CGFloat buttonHeight = CGRectGetHeight(frame);

        [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor colorWithRed:225.0/255 green:225.0/255 blue:225.0/255 alpha:1.0f];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:kNormalTitleColor forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            
            button.frame = CGRectMake(buttonWidth * idx, 0, buttonWidth, buttonHeight);
            button.tag = idx;
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_titleButtons addObject:button];
            [self addSubview:button];
            [self sendSubviewToBack:button];
        }];

        self.contentSize = CGSizeMake(frame.size.width, 25);
        self.showsHorizontalScrollIndicator = NO;
        //设置第一个按钮的外观
        UIButton *firstTitle = _titleButtons[0];
        [firstTitle setTitleColor:kSelectedTitleColor forState:UIControlStateNormal];
        firstTitle.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }
    
    return self;
}


- (void)onClick:(UIButton *)button
{
    if (_currentIndex != button.tag) {
        UIButton *preTitle = _titleButtons[_currentIndex];
        
        [preTitle setTitleColor:kNormalTitleColor forState:UIControlStateNormal];
        preTitle.transform = CGAffineTransformIdentity;
        
        [button setTitleColor:kSelectedTitleColor forState:UIControlStateNormal];
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        _currentIndex = button.tag;
        _titleButtonClicked(button.tag);
    }
}



@end
