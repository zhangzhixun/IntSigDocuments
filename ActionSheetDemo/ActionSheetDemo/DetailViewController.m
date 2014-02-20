//
//  DetailViewController.m
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-17.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"

@interface DetailViewController (){
    UIButton *btn;
}

@end

@implementation DetailViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"goto Root" forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click{
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *root = [storyboard instantiateViewControllerWithIdentifier:@"Root"];
    [mainWindow setRootViewController:root];

}

@end
