//
//  WZBannerView.m
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import "WZBannerView.h"
#import "WZBannerModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation WZBannerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        _bannerTitleLbl = [[UILabel alloc] init];
        _bannerTitleLbl.backgroundColor = [UIColor redColor];
        _bannerTitleLbl.numberOfLines = 0;
        [self addSubview:_bannerTitleLbl];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}

/**
 *  重写layoutSubviews
 */
- (void)layoutSubviews
{

    [super layoutSubviews];
    
    
}


#pragma mark - 用户点击事件
- (void)tapAction{
    _clickBannerCallBackBlock(_banner);
}

#pragma mark - Setter
- (void)setBanner:(WZBannerModel *)banner {
    
    _banner = banner;
    
    NSURL *url = [NSURL URLWithString:banner.bannerImage];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default"]];
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:banner.newsTitle attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    CGSize size =  [attStr boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    _bannerTitleLbl.frame = CGRectMake(15, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 30, size.height);
    CGRect frame = _bannerTitleLbl.frame;
    frame.origin.y = 175 - _offsetY - size.height;
    _bannerTitleLbl.frame = frame;
    _bannerTitleLbl.attributedText = attStr;
    _bannerTitleLbl.alpha = _titleAlpha;
    
}

@end

