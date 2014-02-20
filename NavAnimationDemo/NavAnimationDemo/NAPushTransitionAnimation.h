//
//  NAPushTransitionAnimation.h
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-4.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAPushTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)float duration;
@property(nonatomic,assign)float presentedViewStartAlpha;
@property(nonatomic,assign)float presentingViewEndScale;
@property(nonatomic,assign)float presentingViewEndAlpha;

@end
