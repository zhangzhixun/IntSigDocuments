//
//  NATransitionAnimation.h
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

//protocol available in iOS_7_0 and later
@interface NAPopTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)float duration;
@property(nonatomic,assign)float presentedViewStartAlpha;
@property(nonatomic,assign)float presentingViewStartScale;

@end
