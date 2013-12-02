//
//  NATransitionAnimation.m
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NATransitionAnimation.h"

@implementation NATransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // Get the two view controllers
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get the container view - where the animation has to happen
    UIView *containerView = [transitionContext containerView];
    
    // Add the two VC views to the container
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    toVC.view.alpha = 0.0;
    toVC.view.transform = CGAffineTransformMakeScale(0.5,0.5);
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
//                         fromVC.view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width*3/2, [[UIScreen mainScreen] bounds].size.height/2);
                         fromVC.view.transform = CGAffineTransformTranslate(fromVC.view.transform, fromVC.view.bounds.size.width, 0);
                         toVC.view.transform = CGAffineTransformScale(toVC.view.transform, 2, 2);
                         toVC.view.alpha = 1.f;
//                         toVC.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         // Let's get rid of the old VC view
//                         [fromVC.view removeFromSuperview];
                         
                         fromVC.view.transform = CGAffineTransformIdentity;
                         // And then we need to tell the context that we're done

                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
