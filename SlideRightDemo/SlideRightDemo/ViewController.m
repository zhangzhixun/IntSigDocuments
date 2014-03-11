//
//  ViewController.m
//  SlideRightDemo
//
//  Created by 张志勋 on 14-3-11.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
//    [self.navigationController.view addSubview:menuVC.view ];
    [self.navigationController addChildViewController:menuVC];
    
    [self didMoveToParentViewController:self.navigationController];
}

- (void)viewDidAppear:(BOOL)animated{
//    [self.navigationController.view bringSubviewToFront:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
