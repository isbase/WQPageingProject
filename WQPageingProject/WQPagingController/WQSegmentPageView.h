//
//  WQSegmentPageView.h
//
//
//  Created by Today on 14-7-2.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WQsegmentIndexDelegate <NSObject>
@optional

-(void)wqSegmentSelectIndex:(NSInteger)index;
@end

@interface WQSegmentPageView : UIScrollView

@property (nonatomic) id<WQsegmentIndexDelegate> segmentDelegate;

/**
 * 初始化内容
 */
- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)itmes;

/**
 * 处理选中项目
 */
-(void)selectIndex:(NSInteger)index;


/**
 * 滑块滑动
 */
-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio;

@end
