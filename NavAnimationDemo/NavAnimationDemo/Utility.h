//
//  Utility.h
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-3.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (UIImage*)captureView:(UIView *)theView;

@end
