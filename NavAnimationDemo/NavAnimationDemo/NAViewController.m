//
//  NAViewController.m
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NAViewController.h"
#import "NADetailViewController.h"
#import "NATransitionAnimation.h"

@interface NAViewController ()

@end

@implementation NAViewController

@synthesize pushBtn = _pushBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
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

#pragma mark - UINavigationControllerDelegate

//available in iOS_2_0 and later
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

//available in iOS_7_0 and later
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return nil;
    }
    if (operation == UINavigationControllerOperationPop) {
        return [[NATransitionAnimation new] autorelease];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return nil;
    
}


@end
