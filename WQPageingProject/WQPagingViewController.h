//
//  WQPagingViewController.h
//  WQPageingProject
//
//  Created by dev on 14-7-1.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQPagingViewController : UIViewController<UIScrollViewDelegate>


-(instancetype)initWithChildViewControllers:(NSArray *)viewControllers andTitles:(NSArray *)titleArray;
-(instancetype)initWithChildViewControllers:(NSArray *)viewControllers;

@end
