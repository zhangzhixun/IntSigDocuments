//
//  ContainerViewController.h
//  SlideRightDemo
//
//  Created by 张志勋 on 14-3-12.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContainerViewController : UIViewController

@property (nonatomic,strong)UIViewController *contentViewController;
@property (nonatomic,strong)UIViewController *menuViewController;

- (id)initWithContentViewController:(UIViewController *)contentVC menuViewController:(UIViewController *)menuVC;

- (void)setContentViewController:(UIViewController *)contentVC animated:(BOOL)animated;

- (void)showMenuAnimated:(BOOL)animated;
- (void)hideMenuAnimated:(BOOL)animated;
- (void)handleMenuAnimated:(BOOL)animated;
- (BOOL)isMenuVisible;

@end
