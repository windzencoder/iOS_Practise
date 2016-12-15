//
//  WZBannerModel.m
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import "WZBannerModel.h"

@implementation WZBannerModel

- (instancetype)initWithBannerImage:(NSString *)bannerImage bannerLink:(NSString *)bannerLink newsId:(NSString *)newsId newsTitle:(NSString *)newsTitle
{
    self = [super init];
    if (self) {
        _bannerImage = bannerImage;
        _bannerLink = bannerLink;
        _newsId = newsId;
        _newsTitle = newsTitle;
    }
    return  self;
}

@end
