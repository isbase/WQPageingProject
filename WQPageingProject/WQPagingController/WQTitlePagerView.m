//
//  WQTitlePagerView.m
//  WQPageingProject
//
//  Created by Today on 14-7-2.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "WQTitlePagerView.h"

#define  WQTITLEVIEW_KEYPATH @"contentOffset"

@interface WQTitlePagerView ()

@property (strong, nonatomic) UIScrollView *scrollView;         //title scrollview
@property (strong, nonatomic) UIPageControl *pageControl;       //title pageControl
@property (weak, nonatomic) UIScrollView *observedScrollView;   //observed Father ScrolleView
@property (strong, nonatomic) NSMutableArray *views;            //Title Subviews .like lable or image
@end


@implementation WQTitlePagerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeVar];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeVar];
    }
    return self;
}

#pragma mark - 初始化变量
-(void)initializeVar
{
    self.scrollView = [UIScrollView new];
    self.scrollView.scrollEnabled = NO;
    self.views = [NSMutableArray array];
    self.pageControl = [UIPageControl new];
    self.font = [UIFont systemFontOfSize:17];
    _isObservingScrollView = NO;
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

#pragma mark - 添加标题数据
-(void)addObjects:(NSArray *)objects
{
    [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.views removeAllObjects];
    
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            //here is lable
            UILabel *titleLable = [UILabel new];
            titleLable.text =obj;
            titleLable.textColor = [UIColor redColor];
            titleLable.textAlignment = NSTextAlignmentCenter;
            titleLable.font = self.font;
            [self.scrollView addSubview:titleLable];
            [self.views addObject:titleLable];
            
        }else if ([obj isKindOfClass:[UIImage class]]){
            //here is image
            UIImageView *imageView = [[UIImageView alloc] initWithImage:obj];
            imageView.contentMode = UIViewContentModeCenter;
            [self.scrollView addSubview:imageView];
            [self.views addObject:imageView];
        }
    }];
    
    self.pageControl.numberOfPages = objects.count;
}

#pragma mark - 内容布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 12, CGRectGetWidth(self.frame), 10);
    [self.views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view sizeToFit];
        CGSize size = view.frame.size;
        size.width = self.scrollView.frame.size.width - 60;
        view.frame = (CGRect){{CGRectGetWidth(self.scrollView.frame) * idx + 30,(CGRectGetHeight(self.scrollView.frame) - size.height)/2 - 7},size};
    }];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * [self.views count], CGRectGetHeight(self.scrollView.frame));
}

#pragma mark - 添加监视
-(void)addobserverScrollView:(UIScrollView *)scrollView
{
    self.observedScrollView = scrollView;
    if (_isObservingScrollView) {
        [self.observedScrollView removeObserver:self forKeyPath:WQTITLEVIEW_KEYPATH];
    }
    _isObservingScrollView = YES;
    [self.observedScrollView addObserver:self forKeyPath:WQTITLEVIEW_KEYPATH options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 监听回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGFloat ratio = CGRectGetWidth(self.observedScrollView.frame) / CGRectGetWidth(self.scrollView.frame);
    if (ratio > 0) self.scrollView.contentOffset = CGPointMake(self.observedScrollView.contentOffset.x / ratio, 0);
    CGFloat pageWidth = CGRectGetWidth(self.observedScrollView.frame);
	NSUInteger page = floor((self.observedScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    CGFloat scrollViewWidth = CGRectGetWidth(self.scrollView.frame);
    
    [self.views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        CGFloat diff = (self.scrollView.contentOffset.x - scrollViewWidth*idx) + scrollViewWidth/2;
        if (diff > scrollViewWidth/2) {
            diff = scrollViewWidth - diff;
        }
        if (diff < 0)diff = 0;
        CGFloat alpha = scrollViewWidth / 100 * diff / 100 + 0.15f;
        view.alpha = alpha;
    }];
}

#pragma mark - Getters & setters
-(void)setPageColor:(UIColor *)pageColor{
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
}

@end
