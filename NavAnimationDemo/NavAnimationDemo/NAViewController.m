//
//  NAViewController.m
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NAViewController.h"
#import "NADetailViewController.h"
#import "NAPopTransitionAnimation.h"

@interface NAViewController ()

@end

@implementation NAViewController

@synthesize pushBtn = _pushBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];

//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)push{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    NADetailViewController *nextView = [storyBoard instantiateViewControllerWithIdentifier:@"Detail"];
    
//    [UIView animateWithDuration:0.75
//                     animations:^{
//                         [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//                         [self.navigationController pushViewController:nextView animated:NO];
//                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//                     }];
    [self.navigationController pushViewController:nextView animated:YES];
}


@end
