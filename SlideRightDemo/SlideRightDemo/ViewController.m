//
//  ViewController.m
//  SlideRightDemo
//
//  Created by 张志勋 on 14-3-11.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"

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
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(leftBtnClicked)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)leftBtnClicked{
    if ([self.navigationController.parentViewController isKindOfClass:[ContainerViewController class]]) {
        [(ContainerViewController *)self.navigationController.parentViewController handleMenuAnimated:YES];
    }
    
}

- (void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
