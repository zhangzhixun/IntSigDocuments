//
//  NAPushTransitionAnimation.m
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-4.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NAPushTransitionAnimation.h"

@implementation NAPushTransitionAnimation

- (id)init{
    if (self = [super init]) {
        self.presentedViewStartAlpha = 1.0;
        self.duration = 0.5;
        self.presentingViewEndAlpha = 1.0;
        self.presentingViewEndScale = 0.8;
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
    toVC.view.transform = CGAffineTransformTranslate(toVC.view.transform, toVC.view.bounds.size.width, 0);
    toVC.view.alpha = self.presentedViewStartAlpha;

    fromVC.view.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         fromVC.view.transform = CGAffineTransformScale(fromVC.view.transform, self.presentingViewEndScale, self.presentingViewEndScale);
                         fromVC.view.alpha = self.presentingViewEndAlpha;
                         toVC.view.alpha = 1.f;
                         toVC.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         fromVC.view.transform = CGAffineTransformIdentity;
                         [fromVC.view removeFromSuperview];
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
