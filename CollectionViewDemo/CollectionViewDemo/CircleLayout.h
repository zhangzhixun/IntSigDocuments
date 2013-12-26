//
//  CircleLayout.h
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-17.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

@end
