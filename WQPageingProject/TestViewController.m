//
//  TestViewController.m
//  WQPageingProject
//
//  Created by dev on 14-7-1.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "TestViewController.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int r = rand() % 255;
    int b = rand() % 255;
    self.view.backgroundColor = RGBCOLOR(r,255, b);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 320, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.labelTitle;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
