//
//  Item.h
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-18.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject<NSCoding>

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSIndexPath *itemIndexPath;
@property(nonatomic)NSInteger childrenCount;
@property(nonatomic,strong)NSArray *childrenIndexPaths;

- (id)initWithImage:(UIImage *)image name:(NSString *)name childrenCount:(NSInteger)count childrenIndexPath:(NSArray *)indexPath;



@end
