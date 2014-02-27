//
//  CustomImageVIew.m
//  TableViewTouchImageDemo
//
//  Created by 张志勋 on 14-2-26.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "CustomImageVIew.h"

@implementation CustomImageVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self pointInside:point withEvent:event]) {
        NSLog(@"hit test:(%f,%f)",point.x,point.y);
        for (UIView *subView in self.subviews) {
            UIView *testView = [subView hitTest:point withEvent:event];
            if (testView) {
                return testView;
                break;
            }
        }
        return self;
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

@end
