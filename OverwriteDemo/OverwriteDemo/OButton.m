//
//  OButton.m
//  OverwriteDemo
//
//  Created by 张志勋 on 13-12-5.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "OButton.h"

@implementation OButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self.text drawInRect:rect withAttributes:nil];
}


- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    _delegate = target;
    controlEvent = controlEvents;
    methodAction = action;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (controlEvent == UIControlEventTouchDown) {
        [_delegate performSelector:methodAction withObject:self];
    }
    [self setBackgroundColor:[UIColor blueColor]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (controlEvent == UIControlEventTouchUpInside) {
        [_delegate performSelector:methodAction withObject:self];
    }
    [self setBackgroundColor:[UIColor grayColor]];
}

@end
