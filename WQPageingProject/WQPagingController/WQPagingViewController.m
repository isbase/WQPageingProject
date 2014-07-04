//
//  WQPagingViewController.m
//  WQPageingProject
//
//  Created by Today on 14-7-1.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "WQPagingViewController.h"
#import "WQTitlePagerView.h"


@interface WQPagingViewController ()
{
    UIScrollView *contentView;
    NSArray *_viewControllers;
    NSArray *_titleArray;
    WQSegmentPageView *segmentView;
}

@end

@implementation WQPagingViewController

-(instancetype)initWithChildViewControllers:(NSArray *)viewControllers andTitles:(NSArray *)titleArray
{
    self = [super init];
    if (self) {
        // Custom initialization
        _titleArray = titleArray;
        _viewControllers = viewControllers;
    }
    return self;
}

-(instancetype)initWithChildViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        // Custom initialization
        _viewControllers = viewControllers;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44 + 25, 320, screenHeight - 44 - 25)];
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.directionalLockEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.alwaysBounceHorizontal = YES;
    [contentView setContentSize:CGSizeMake([_viewControllers count] * 320, contentView.frame.size.height)];

    int x = 0;
    for (UIViewController *curController in _viewControllers) {
        [self addChildViewController:curController];
        [curController.view setFrame:(CGRect){{x,0},contentView.frame.size}];
        [contentView addSubview:curController.view];
        x += 320;
    }
    [self.view addSubview:contentView];
    
    if ([_titleArray count] > 0) {
        
        //顶部
        WQTitlePagerView *titleView = [[WQTitlePagerView alloc] initWithFrame:CGRectMake(0, 20, 150, 44)];
        [titleView addObjects:_titleArray];
        [titleView addobserverScrollView:contentView];
        [self.view addSubview:titleView];
        titleView.center = CGPointMake(160, titleView.center.y);
        
        //中间
        segmentView = [[WQSegmentPageView alloc] initWithFrame:CGRectMake(0, 64, 320, 25) withItems:_titleArray];
        segmentView.segmentDelegate = self;
        [self.view addSubview:segmentView];
        
    }
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [contentView setContentSize:CGSizeMake([_viewControllers count] * 320, contentView.frame.size.height - 20)];
}

#pragma mark -  以下方法只在SegmentPageView中使用
-(void)wqSegmentSelectIndex:(NSInteger)index{
    
    [contentView setContentOffset:CGPointMake(320 * index, 0) animated:NO];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > scrollView.contentSize.width - 320) return;
    int page = (int)scrollView.contentOffset.x / 320 ;
    float radio = (float)((int)scrollView.contentOffset.x % 320)/320;
    [segmentView setLineOffsetWithPage:page andRatio:radio];
}

@end
