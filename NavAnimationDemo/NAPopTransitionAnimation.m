//
//  NATransitionAnimation.m
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NAPopTransitionAnimation.h"

@implementation NAPopTransitionAnimation

- (id)init{
    if (self = [super init]) {
        self.presentedViewStartAlpha = 0.0;
        self.duration = 0.5;
        self.presentingViewStartScale = 0.8;
        return self;
    }
    return nil;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    toVC.view.alpha = self.presentedViewStartAlpha;
    toVC.view.transform = CGAffineTransformMakeScale(self.presentingViewStartScale,self.presentingViewStartScale);
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         fromVC.view.transform = CGAffineTransformTranslate(fromVC.view.transform, fromVC.view.bounds.size.width, 0);
                         toVC.view.transform = CGAffineTransformScale(toVC.view.transform, 1/self.presentingViewStartScale, 1/self.presentingViewStartScale);
                         toVC.view.alpha = 1.f;

                     }
                     completion:^(BOOL finished) {
                         
                         [fromVC.view removeFromSuperview];
                         
//                         fromVC.view.transform = CGAffineTransformIdentity;

                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
