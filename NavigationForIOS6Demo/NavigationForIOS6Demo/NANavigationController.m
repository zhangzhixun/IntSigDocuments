//
//  NANavigationController.m
//  NavigationForIOS6Demo
//
//  Created by 张志勋 on 13-12-4.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NANavigationController.h"

@interface NANavigationController (){
    CALayer *animationLayer;
}

@end

@implementation NANavigationController

- (void)dealloc{
    [super dealloc];
    animationLayer = nil;
}

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

    animationLayer = [[CALayer layer] retain] ;
    CGRect layerFrame = self.view.frame;
    layerFrame.size.height = self.view.frame.size.height-self.navigationBar.frame.size.height;
    layerFrame.origin.y = self.navigationBar.frame.size.height;
    animationLayer.frame = layerFrame;
    animationLayer.masksToBounds = YES;
    [animationLayer setContentsGravity:kCAGravityBottomLeft];
    [self.view.layer insertSublayer:animationLayer atIndex:0];
    animationLayer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIViewController Method

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect layerFrame = self.view.bounds;
    layerFrame.size.height = self.view.bounds.size.height-self.navigationBar.frame.size.height;
    layerFrame.origin.y = self.navigationBar.frame.size.height+20;
    animationLayer.frame = layerFrame;
}

#pragma mark - Custom Method

-(void)loadLayerWithImage
{
    UIGraphicsBeginImageContext(self.visibleViewController.view.bounds.size);
    [self.visibleViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [animationLayer setContents: (id)viewImage.CGImage];
    [animationLayer setHidden:NO];

}

#pragma mark - UINavigationController Method

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:animationLayer atIndex:0];
    if(animated)
    {
        [self loadLayerWithImage];

        UIView * toView = [viewController view];

        CABasicAnimation *Animation  = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform = CATransform3DMakeTranslation(self.view.frame.size.width, 0, 0);
        [Animation setFromValue:[NSValue valueWithCATransform3D:rotationAndPerspectiveTransform]];
        [Animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
        [Animation setDuration:0.3];
        Animation.delegate = self;
        Animation.removedOnCompletion = NO;
        Animation.fillMode = kCAFillModeBoth;
        
        [toView.layer addAnimation:Animation forKey:@"fromRight"];

        
        CABasicAnimation *Animation1  = [CABasicAnimation animationWithKeyPath:@"transform"];
        CATransform3D rotationAndPerspectiveTransform1 = CATransform3DIdentity;
        rotationAndPerspectiveTransform1.m34 = 1.0 / -1000;
        rotationAndPerspectiveTransform1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
        [Animation1 setFromValue:[NSValue valueWithCATransform3D:rotationAndPerspectiveTransform1]];
        [Animation1 setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [Animation1 setDuration:0.3];
        Animation1.delegate = self;
        Animation1.removedOnCompletion = NO;
        Animation1.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:Animation1 forKey:@"scale"];
        
    }
    [super pushViewController:viewController animated:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [animationLayer removeFromSuperlayer];
    [self.view.layer insertSublayer:animationLayer above:self.view.layer];
    if(animated)
    {
        [self loadLayerWithImage];
        
        
        
        UIView * toView = [[self.viewControllers objectAtIndex:[self.viewControllers indexOfObject:self.visibleViewController]-1] view];
        
   
        CABasicAnimation *Animation  = [CABasicAnimation animationWithKeyPath:@"transform"];
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
//        rotationAndPerspectiveTransform = CATransform3DMakeTranslation(self.view.frame.size.width, 0, 0);
        [Animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [Animation setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(self.view.bounds.size.width, 0, 0)]];
        [Animation setDuration:0.3];
        Animation.delegate = self;
        Animation.removedOnCompletion = NO;
        Animation.fillMode = kCAFillModeBoth;
        [animationLayer addAnimation:Animation forKey:@"scale"];
        
        
        CABasicAnimation *Animation1  = [CABasicAnimation animationWithKeyPath:@"transform"];
//        CATransform3D rotationAndPerspectiveTransform1 = CATransform3DIdentity;
//        rotationAndPerspectiveTransform1.m34 = 1.0 / -1000;
//        rotationAndPerspectiveTransform1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
        [Animation1 setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [Animation1 setToValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
        [Animation1 setDuration:0.3];
        Animation1.delegate = self;
        Animation1.removedOnCompletion = NO;
        Animation1.fillMode = kCAFillModeBoth;
        [toView.layer addAnimation:Animation1 forKey:@"scale"];
        
    }

    return [super popViewControllerAnimated:NO];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - NSObject (CAAnimationDelegate) Method

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [animationLayer setContents:nil];
    [animationLayer removeAllAnimations];
    [self.visibleViewController.view.layer removeAllAnimations];
}

#pragma mark - NSObject (CALayerDelegate) Method

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id<CAAction> action = (id)[NSNull null];
    return action;
}

@end
