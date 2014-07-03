//
//  WQSegmentPageView.h
//
//
//  Created by dev on 14-7-2.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WQSegmentPageView : UIScrollView


- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)itmes;

-(void)selectIndex:(NSInteger)index;

-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio;

@end
