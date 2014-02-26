//
//  CustomTableView.m
//  MapTableViewDemo
//
//  Created by 张志勋 on 14-2-26.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "CustomTableView.h"

@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    CGPoint mapPoint = [_mapView convertPoint:point fromView:self];
//    NSLog(@"contentInset top = %f",self.contentInset.top);
//    
//    NSLog(@"point:(%f,%f)",point.x,point.y);
//
//    NSLog(@"mapPoint:(%f,%f)",mapPoint.x,mapPoint.y);
    
    //如果转换过得坐标是否在map内
//    if ([_mapView pointInside:mapPoint withEvent:event]) {
//        return [_mapView hitTest:point withEvent:event];
//    }
    
    if (point.y < 0) {
        return [_mapView hitTest:point withEvent:event];
    }
    return [super hitTest:point withEvent:event];
}


@end
