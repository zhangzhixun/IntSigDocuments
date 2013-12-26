//
//  Item.m
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-18.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "Item.h"

@implementation Item

- (id)initWithImage:(UIImage *)image name:(NSString *)name childrenCount:(NSInteger)count childrenIndexPath:(NSArray *)indexPath{
    if (self = [super init]) {
        _image = image;
        _name = name;
        _childrenCount = count;
        _childrenIndexPaths = indexPath;
        return self;
    }
    return nil;
}

@end
