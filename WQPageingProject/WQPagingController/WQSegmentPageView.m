//
//  WQSegmentPageView.m
//  WQPageingProject
//
//  Created by Today on 14-7-2.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "WQSegmentPageView.h"
#define kButtonTagStart 100
#define kPATH_OFFSET_X @"contentOffset.x"

@interface WQSegmentPageView (){
    NSInteger selectedIndex;
    UIView  *lineView;
    BOOL    _isObservingScrollView;
    NSInteger pageSum;
}

@property (weak, nonatomic) UIScrollView *observedScrollView;
@end

@implementation WQSegmentPageView

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)itmes
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor lightGrayColor];
        _isObservingScrollView = NO;
        selectedIndex = 0;
        __block int offset_x = 10;
        [itmes enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
            button.tag = kButtonTagStart + idx;
            [button setTitle:title forState:UIControlStateNormal];
            CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
            button.frame = CGRectMake(offset_x, 0, size.width, 25);
            [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            offset_x += size.width + 20;
            
        }];
        
        pageSum = itmes.count;
        
        self.contentSize = CGSizeMake(offset_x, 25);
        self.showsHorizontalScrollIndicator = NO;
        
        CGRect rc  = [self viewWithTag:selectedIndex+kButtonTagStart].frame;
        lineView = [[UIView alloc]initWithFrame:CGRectMake(rc.origin.x, self.frame.size.height - 2, rc.size.width, 2)];
        lineView.backgroundColor = [UIColor colorWithRed:190.0/255.1 green:2.0/255.0 blue:1.0/255.0 alpha:1];
        [self addSubview:lineView];
    }
    return self;
}

-(void)onButtonClick:(UIButton *)button
{
    [self selectIndex:button.tag - kButtonTagStart];
}

-(void)selectIndex:(NSInteger)index
{
    //first of all ,we need to eliminate negative conditions
    if (selectedIndex == index) return;
    selectedIndex = index;
    if ([self.segmentDelegate respondsToSelector:@selector(wqSegmentSelectIndex:)]) {
        [self.segmentDelegate wqSegmentSelectIndex:index];
    }
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect lineRC  = [self viewWithTag:selectedIndex+kButtonTagStart].frame;
    lineView.frame = CGRectMake(lineRC.origin.x, self.frame.size.height - 2, lineRC.size.width, 2);
    [UIView commitAnimations];
}

-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio
{
    CGRect lineRC  = [self viewWithTag:page+kButtonTagStart].frame;
    CGRect lineRC2  = [self viewWithTag:page+1+kButtonTagStart].frame;
    float width = lineRC2.size.width;
    if (lineRC2.size.width < lineRC.size.width)
    {
        width =  lineRC.size.width - (lineRC.size.width-lineRC2.size.width)*ratio;
    }
    else if(lineRC2.size.width > lineRC.size.width)
    {
        width =  lineRC.size.width + (lineRC2.size.width-lineRC.size.width)*ratio;
    }
    float x = lineRC.origin.x + (lineRC2.origin.x - lineRC.origin.x)*ratio;
    lineView.frame = CGRectMake(x,  self.frame.size.height - 2,width,2);
    selectedIndex = page;
    
    if ((x - self.contentOffset.x) > 320 * 0.65) {
        CGFloat off_x = self.contentOffset.x + 80;
        if ((off_x + 320) > self.contentSize.width){
            off_x = self.contentSize.width - 320;
        }
        [self setContentOffset:CGPointMake(off_x, 0) animated:YES];
        return;
    }else if((x-self.contentOffset.x) < 320 * 0.35){
        CGFloat off_x = self.contentOffset.x  - 80;
        if (off_x <= 0)off_x = 0;
        [self setContentOffset:CGPointMake(off_x, 0) animated:YES];
        return;
    }
}


@end
