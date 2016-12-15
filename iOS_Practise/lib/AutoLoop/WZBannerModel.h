//
//  WZBannerModel.h
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  轮播数据模型
 */
@interface WZBannerModel : NSObject

@property (nonatomic, copy) NSString *bannerImage;
@property (nonatomic, copy) NSString *bannerLink;
@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *newsTitle;

- (instancetype)initWithBannerImage:(NSString *)bannerImage bannerLink:(NSString *)bannerLink newsId:(NSString *)newsId newsTitle:(NSString *)newsTitle;

@end
