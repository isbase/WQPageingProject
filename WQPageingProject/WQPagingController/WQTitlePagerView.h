//
//  WQTitlePagerView.h
//  WQPageingProject
//
//  Created by Today on 14-7-2.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQTitlePagerView : UIView{
    BOOL _isObservingScrollView;
}

/**
 * pageControl 颜色
 */
@property (strong, nonatomic) UIColor *pageColor;

/**
 * 标题字体
 */
@property (strong, nonatomic) UIFont *font;


/**
 *  添加标题数据
 *  objects type : NSString or UIImage
 */
-(void)addObjects:(NSArray *)objects;

/**
 *  添加监视 添加监视
 */
-(void)addobserverScrollView:(UIScrollView *)scrollView;


@end
