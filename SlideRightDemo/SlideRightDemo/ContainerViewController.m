//
//  ContainerViewController.m
//  SlideRightDemo
//
//  Created by 张志勋 on 14-3-12.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "ContainerViewController.h"

const CGFloat ISSideMenuMinimumRelativePanDistanceToOpen = 0.33;
const CGFloat ISSideMenuDefaultMenuWidth = 260.0;
const CGFloat ISSideMenuDefaultDamping = 0.5;

const CGFloat ISSideMenuDefaultOpenAnimationTime = 1.2;
const CGFloat ISSideMenuDefaultCloseAnimationTime = 0.4;

@interface ContainerViewController (){
    UIView *_containerView;
    UIPanGestureRecognizer *_panGesture;
    UITapGestureRecognizer *_tapGesture;
}

@end

@implementation ContainerViewController

- (id)initWithContentViewController:(UIViewController *)contentVC menuViewController:(UIViewController *)menuVC{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _contentViewController = contentVC;
        _menuViewController = menuVC;
    }
    return self;
}

- (void)setContentViewController:(UIViewController *)contentVC animated:(BOOL)animated{
    if (!contentVC) {
        return;
    }
    UIViewController *previousController = self.contentViewController;
    self.contentViewController = contentVC;
    
    [self addChildViewController:self.contentViewController];
    
    self.contentViewController.view.frame = _containerView.bounds;
    self.contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGFloat offset = ISSideMenuDefaultMenuWidth + (self.view.frame.size.width-ISSideMenuDefaultMenuWidth)/2.0;
    [UIView animateWithDuration:ISSideMenuDefaultCloseAnimationTime/2.0 animations:^{
        _containerView.transform = CGAffineTransformMakeTranslation(offset, 0);
    } completion:^(BOOL finished) {
        [_containerView addSubview:self.contentViewController.view];
        [self.contentViewController didMoveToParentViewController:self];
        
        [previousController willMoveToParentViewController:nil];
        [previousController removeFromParentViewController];
        [previousController.view removeFromSuperview];
        
        [self hideMenuAnimated:YES];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.menuViewController];
    [self.menuViewController didMoveToParentViewController:self];
    [self addChildViewController:self.contentViewController];
    [self.contentViewController didMoveToParentViewController:self];
    
	_containerView = [[UIView alloc]initWithFrame:self.view.bounds];
    [_containerView addSubview:self.contentViewController.view];
    self.contentViewController.view.frame = _containerView.bounds;
    [self.view addSubview:_containerView];
    
    _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    [_containerView addGestureRecognizer:_panGesture];
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecognized:)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapRecognized:(UITapGestureRecognizer*)recognizer{
    [self handleMenuAnimated:YES];
}

- (void)handleMenuAnimated:(BOOL)animated{
    if (![self isMenuVisible]) {
        [self showMenuAnimated:YES];
    } else {
        [self hideMenuAnimated:YES];
    }
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)gesture{
    CGPoint translation = [gesture translationInView:gesture.view];
    CGPoint velocity = [gesture velocityInView:gesture.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self addMenuControllerView];
            [gesture setTranslation:CGPointMake(gesture.view.frame.origin.x, 0) inView:gesture.view];
            break;
        case UIGestureRecognizerStateChanged:
            [gesture.view setTransform:CGAffineTransformMakeTranslation(MAX(0,translation.x), 0)];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (velocity.x > 5.0 || (velocity.x >= -1.0 && translation.x > ISSideMenuMinimumRelativePanDistanceToOpen * ISSideMenuDefaultMenuWidth)) {
                CGFloat transformedVelocity = velocity.x/ABS(260 - translation.x);
                CGFloat duration = ISSideMenuDefaultOpenAnimationTime * 0.66;
                [self showMenuAnimated:YES duration:duration initialVelocity:transformedVelocity];
            } else {
                [self hideMenuAnimated:YES];
            }
        default:
            break;
    }
}

- (void)addMenuControllerView;
{
    if (self.menuViewController.view.superview == nil) {
        CGRect menuFrame, restFrame;
        CGRectDivide(self.view.bounds, &menuFrame, &restFrame, 260, CGRectMinXEdge);
        self.menuViewController.view.frame = menuFrame;
        self.menuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        self.view.backgroundColor = self.menuViewController.view.backgroundColor;
        
        [self.view insertSubview:self.menuViewController.view atIndex:0];
    }
}

- (void)showMenuAnimated:(BOOL)animated duration:(CGFloat)duration
         initialVelocity:(CGFloat)velocity;
{
    // add menu view
    [self addMenuControllerView];
    
    // animate
    [UIView animateWithDuration:animated ? duration : 0.0 delay:0
         usingSpringWithDamping:ISSideMenuDefaultDamping initialSpringVelocity:velocity options:UIViewAnimationOptionAllowUserInteraction animations:^{
             _containerView.transform = CGAffineTransformMakeTranslation(ISSideMenuDefaultMenuWidth, 0);
             
         } completion:^(BOOL finished) {
             [_containerView addGestureRecognizer:_tapGesture];
         }];
}

- (void)showMenuAnimated:(BOOL)animated{
    [self showMenuAnimated:animated duration:ISSideMenuDefaultOpenAnimationTime initialVelocity:0.4];
}

- (void)hideMenuAnimated:(BOOL)animated{
    [UIView animateWithDuration:ISSideMenuDefaultCloseAnimationTime animations:^{
        _containerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.menuViewController.view removeFromSuperview];
        [_containerView removeGestureRecognizer:_tapGesture];
    }];
}

- (BOOL)isMenuVisible
{
    return !CGAffineTransformEqualToTransform(_containerView.transform, CGAffineTransformIdentity);
}

@end
