//
//  CustomLayoutAttributes.m
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-24.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "CustomLayoutAttributes.h"

@implementation CustomLayoutAttributes

- (BOOL)isEqual:(id)object{
    CustomLayoutAttributes *otherAttr = (CustomLayoutAttributes *)object;
    if ([self.children isEqualToArray:otherAttr.children]) {
        return YES;
    }
    return NO;
}

@end
