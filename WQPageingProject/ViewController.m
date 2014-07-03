//
//  ViewController.m
//  WQPageingProject
//
//  Created by dev on 14-7-1.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "WQPagingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    NSArray *titleArray = [NSArray arrayWithObjects:@"轻松一刻",@"头条",@"北京",@"房产",@"移动互联",@"财经",@"军事",@"大满贯",@"中国",@"把戏",@"东京",@"及陪你过",@"极品",@"天涯",@"群租", nil];
    
    NSMutableArray *controllerArray = [[NSMutableArray alloc]init];
    
    for (NSString* title in titleArray)
    {
        TestViewController *vc = [[TestViewController alloc]init];
        vc.labelTitle = [title stringByAppendingString:@" View Controller"];
        [controllerArray addObject:vc];
    }
    
    WQPagingViewController *pagingCV = [[WQPagingViewController alloc] initWithChildViewControllers:controllerArray andTitles:titleArray];
    
    [self.navigationController pushViewController:pagingCV animated:YES];
    
}
@end
