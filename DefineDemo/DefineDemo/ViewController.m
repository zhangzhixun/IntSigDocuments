//
//  ViewController.m
//  DefineDemo
//
//  Created by 张志勋 on 14-3-10.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "ViewController.h"
#import "MyPrefixHeader.pch"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"aaaaa,%@",NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
