//
//  OLabel.m
//  OverwriteDemo
//
//  Created by 张志勋 on 13-12-5.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "OLabel.h"

@implementation OLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont boldSystemFontOfSize:(int)frame.size.height];
        self.color = [UIColor blackColor];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self.color setFill];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.font,@"font", nil];
    [self.text drawInRect:rect withAttributes:dict];
}

- (void)setText:(NSString *)text{
    if (_text != text) {
        [_text release];
        _text = [text retain];
        [self setNeedsDisplay];
    }
}

- (void)setColor:(UIColor *)color{
    if (_color != color) {
        [_color release];
        _color = [color retain];
        [self setNeedsDisplay];
    }
}

@end
