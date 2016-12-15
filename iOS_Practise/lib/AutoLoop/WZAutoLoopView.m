//
//  WZAutoLoopView.m
//  iOS_Practise
//
//  Created by wangzhen on 16/12/14.
//  Copyright © 2016年 WZ. All rights reserved.
//

#import "WZAutoLoopView.h"
#import "WZBannerView.h"
#import "WZBannerModel.h"

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
#define kBannerViewTag 186681
#define kAlpha 180


@interface WZAutoLoopView () <UIScrollViewDelegate>
{
    /**是否已经存在滚动条了*/
    BOOL _isHasBanners;
    CGFloat _offsetY;
    CGFloat _titleAlpha;
}
@property (nonatomic, assign) int currentIdx;
@property (nonatomic, assign) int pagesCount;
@property (nonatomic, strong) NSMutableArray *cells;
/**是否在用手指拖动scrollView*/
@property (nonatomic, assign, getter=isDragging) BOOL dragging;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, copy) int (^numberOfPagesInAutoLoopView)(WZAutoLoopView *autoLoopView);
@property (nonatomic, copy) UIView *(^autoLoopViewCellForIndex)(int index);
@property (nonatomic, copy) void (^scrollToPageForIndex)(int index);

@end

@implementation WZAutoLoopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addScrollView];
        [self addPageControl];
        // 初始化数据
        _isHasBanners = NO;
        _offsetY = 0;
        _titleAlpha = 1.f;
        _currentIdx = 0;
        _autoLoopScroll = YES;
        _stretchAnimation = NO;
        _autoLoopScrollInterval = 5;
    }
    return self;
}


- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (_autoLoopScroll) {
        if (_pagesCount > 1) {
            [self autoLoopScrollCell];
        }
    }
}

#pragma mark - Private Methods

#pragma mark - 添加UIScrollView
- (void)addScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.bounds), 0);
    [self addSubview:_scrollView];
}

#pragma mark 添加UIPageControl
- (void)addPageControl {
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    _pageControl.enabled = NO;
    [self insertSubview:_pageControl aboveSubview:self.scrollView];
}

#pragma mark 更新cells
//更新cells集合中放置的视图
- (void)updateCells {
    //前一张
    int previousIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx - 1];
    //后一张
    int nextIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx + 1];
    if (_cells == nil) {
        _cells = [NSMutableArray array];
    }
    [_cells removeAllObjects];
    
    if (_autoLoopViewCellForIndex) {
        [_cells addObject:self.autoLoopViewCellForIndex(previousIdx)];
        [_cells addObject:self.autoLoopViewCellForIndex(_currentIdx)];
        [_cells addObject:self.autoLoopViewCellForIndex(nextIdx)];
    }
    
}

#pragma mark 传入一个idx来获取下一个正确的idx
- (int)getVaildNextPageIdxWithIdx:(int)idx {
    
    if (idx == -1) {
        return (int)_pagesCount - 1;
    } else if (idx == _pagesCount) {
        return 0;
    } else {
        return idx;
    }
}

#pragma mark 重载cells
- (void)reloadCells {
    //先移除
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _pagesCount = self.numberOfPagesInAutoLoopView(self);
    //更新cells
    [self updateCells];
    //重新调整frame
    for (NSInteger i = 0; i < _cells.count; i ++) {
        WZBannerView *cell = [[WZBannerView alloc] init];
        CGRect cellFrame = CGRectMake(CGRectGetWidth(self.bounds) * i, 0, CGRectGetWidth(self.bounds), _scrollView.frame.size.height);
        cell.frame = cellFrame;
        cell.tag = i + kBannerViewTag;
        cell.offsetY = _offsetY;
        cell.titleAlpha = _titleAlpha;
        cell.banner = [_cells[i] banner];
        cell.clickBannerCallBackBlock = [_cells[i] clickBannerCallBackBlock];
        cell.userInteractionEnabled = YES;
        
        [_scrollView addSubview:cell];
    }
    //_scrollView偏移到中间
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.bounds), 0);
    _pageControl.currentPage = _currentIdx;
    if (_scrollToPageForIndex) {
        _scrollToPageForIndex(_currentIdx);
    }
    //只有一个，隐藏，不滚动
    if (_banners.count == 1) {
        _scrollView.scrollEnabled = NO;
        _pageControl.hidden = YES;
        _autoLoopScroll = NO;
    }
}

- (void)reloadData {
    [self reloadCells];
}



#pragma mark 循环滚动的方法
/**
 *  1. Scrollview上只有3个cell view, 默认显示的是中间的一个，最开始偏移量是_scrollView的宽度
 *  2. 自动滚动时，表示要偏移到下一个cell view，其位置是CGRectGetWidth(_scrollView.bounds) * 2
 *  3. 所以在setBanners时，_currentIdx = (int)banners.count  - 1，在添加到window上时，会马上
 滚动，显示第一张图片
 */
- (void)autoLoopScrollCell {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoLoopScrollCell) object:nil];
    CGPoint newOffset = CGPointMake(CGRectGetWidth(_scrollView.bounds) * 2, _scrollView.contentOffset.y);
    [_scrollView setContentOffset:newOffset animated:YES];
    [self performSelector:@selector(autoLoopScrollCell) withObject:nil afterDelay:_autoLoopScrollInterval];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    if(offsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx + 1];
        [self reloadData];
    }
    if(offsetX <= 0) {
        self.currentIdx = [self getVaildNextPageIdxWithIdx:self.currentIdx - 1];
        [self reloadData];
    }
}

//停止滑动后，还是滑动到中间，相当于是3张在循环
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.bounds), 0) animated:YES];
}

#pragma mark - Setter //tips：切勿反复调用该setter方法
/**
 *  设置滚动条数据
 *
 *  @param banners 滚动条数据集合
 */
- (void)setBanners:(NSArray *)banners {
    if (_isHasBanners) {
        return;
    }
    _banners = banners;
    _currentIdx = (int)banners.count  - 1;
    NSMutableArray *cells = [NSMutableArray array];
    [banners enumerateObjectsUsingBlock:^(WZBannerModel *banner, NSUInteger idx, BOOL *stop) {
        //图片View
        WZBannerView *cell = [[WZBannerView alloc] initWithFrame:self.frame];
        cell.banner = banner;
        cell.clickBannerCallBackBlock = ^(WZBannerModel *banner){
            if (_clickAutoLoopCallBackBlock) {
                _clickAutoLoopCallBackBlock(banner);
            }
            
        };
        [cells addObject:cell];
    }];
    
    self.numberOfPagesInAutoLoopView = ^int(WZAutoLoopView *autoLoopView) {
        return (int)cells.count;
    };
    
    self.autoLoopViewCellForIndex = ^UIView *(int index) {
        return cells[index];
    };
    
    [self reloadData];
    _isHasBanners = YES;
}


- (void)setAutoLoopScroll:(BOOL)autoLoopScroll {
    
    _autoLoopScroll = autoLoopScroll;
    if (self.window) {
        if (autoLoopScroll) {
            [self autoLoopScroll];
        } else {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoLoopScrollCell) object:nil];
        }
    }
}

- (void)setNumberOfPagesInAutoLoopView:(int (^)(WZAutoLoopView *))numberOfPagesInAutoLoopView {
    
    _numberOfPagesInAutoLoopView = numberOfPagesInAutoLoopView;
    int count = numberOfPagesInAutoLoopView(self);
    _pageControl.numberOfPages = count;
    //获取大小
    CGSize pcSize = [_pageControl sizeForNumberOfPages:count];
    //设置_pageControl的frame
    _pageControl.frame = CGRectMake((self.bounds.size.width - pcSize.width) * 0.5, self.bounds.size.height - pcSize.height, pcSize.width, pcSize.height);
}

#pragma mark - Public Methods
- (void)wf_parallaxHeaderViewWithOffset:(CGPoint)offset{
    if (_stretchAnimation == NO) {
        return;
    }
    
    CGRect frame = _scrollView.frame;
    
    if (offset.y > 0) {
        
        frame.origin.y = MAX(offset.y/2, 0);
        _scrollView.frame = frame;
        NSLog(@"_scrollView.frame : %@", NSStringFromCGRect(frame) );
        self.clipsToBounds = YES;
        _offsetY = MAX(offset.y/2, 0);
        
        for (int i = 0 ; i < 3 ; i ++) {
            
            float h = offset.y / kAlpha;
            
            _titleAlpha = 1 - ((h > 1)?1:h);
            
            WZBannerView *bannerView = (WZBannerView *)[_scrollView viewWithTag:i + kBannerViewTag];
            CGRect frame = bannerView.bannerTitleLbl.frame;
            frame.origin.y = CGRectGetHeight(_scrollView.frame) - MAX(offset.y/2, 0) - 25 - CGRectGetHeight(frame);
            bannerView.bannerTitleLbl.frame = frame;
            
            bannerView.bannerTitleLbl.alpha = _titleAlpha;
            
        }
        
        
    }else{
        
        CGFloat delta = 0.f;
        CGRect rect = kDefaultHeaderFrame;
        delta = fabs(MIN(0.f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        _scrollView.frame = rect;
        self.clipsToBounds = NO;
        
        _offsetY = 0;
        
        _titleAlpha = 1;
        
        for (int i = 0 ; i < 3 ; i ++) {
            
            WZBannerView *bannerView = (WZBannerView *)[_scrollView viewWithTag:i + kBannerViewTag];
            CGRect frame = bannerView.bannerTitleLbl.frame;
            frame.origin.y = CGRectGetHeight(_scrollView.frame) - 25 - CGRectGetHeight(frame);
            bannerView.bannerTitleLbl.frame = frame;
            
            NSLog(@"%@", self.scrollView);
            
        }
    }
}
@end

