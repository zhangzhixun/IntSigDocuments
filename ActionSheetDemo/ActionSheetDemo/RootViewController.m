//
//  RootViewController.m
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-17.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController (){
    UIButton *btn;
}

@end

@implementation RootViewController

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
    btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"goto sheet" forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click{
    NSLog(@"click");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *nav = [storyboard instantiateViewControllerWithIdentifier:@"Nav"];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

@end
