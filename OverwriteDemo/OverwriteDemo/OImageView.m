//
//  OImageView.m
//  OverwriteDemo
//
//  Created by 张志勋 on 13-12-5.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "OImageView.h"

@implementation OImageView

@synthesize image = _image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    if (_image != image) {
        [_image release];
        _image = [image retain];
        [self setNeedsDisplay];
    }
}
- (void)drawRect:(CGRect)rect{
    [_image drawInRect:rect];
}



@end
