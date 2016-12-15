//
//  WZBannerView.h
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZBannerModel;

/**
 *  轮播条幅view
 */
@interface WZBannerView : UIImageView

@property (nonatomic, strong) WZBannerModel *banner;

@property (nonatomic,   copy) void (^clickBannerCallBackBlock)(WZBannerModel *banner);

@property (nonatomic, assign)  CGFloat offsetY;

@property (nonatomic, assign)  CGFloat titleAlpha;

@property (nonatomic, assign) CGFloat titleYPositon;


@end
