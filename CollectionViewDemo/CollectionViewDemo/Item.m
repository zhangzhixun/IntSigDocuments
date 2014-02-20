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

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_childrenIndexPaths forKey:@"childrenIndexPaths"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.childrenIndexPaths = [aDecoder decodeObjectForKey:@"childrenIndexPaths"];
        return self;
    }
    return nil;
}

@end
