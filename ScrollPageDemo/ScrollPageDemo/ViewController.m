//
//  ViewController.m
//  ScrollPageDemo
//
//  Created by 张志勋 on 13-12-23.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "ViewController.h"
#import "PageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageViewControllers = [NSMutableArray array];
    
        UIViewController *viewVC = [[UIViewController alloc]init];
        [viewVC.view setBackgroundColor:[UIColor whiteColor]];
        UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 40, 30)];
        [colorView  setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1.0]];
        [viewVC.view addSubview:colorView];
        [pageViewControllers addObject:viewVC];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)go:(id)sender{
    pv = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [pv.view setBackgroundColor:[UIColor redColor]];
    pv.delegate = self;
    pv.dataSource = self;
    
    [pv setViewControllers:pageViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
    [self addChildViewController:pv];
    [self.view addSubview:pv.view];
}


- (IBAction)gotoPage:(id)sender{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    PageViewController *page = [story instantiateViewControllerWithIdentifier:@"page"];
    [self presentViewController:page animated:YES completion:^{
        
    }];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    UIViewController *vc = [[UIViewController alloc]init];
    [vc.view setBackgroundColor:[UIColor blueColor]];
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIViewController *vc = [[UIViewController alloc]init];
    [vc.view setBackgroundColor:[UIColor greenColor]];
    return vc;
}
#pragma mark - UIPageViewControllerDelegate

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    pv.doubleSided = NO;
    
    return UIPageViewControllerSpineLocationMin;
}


@end
