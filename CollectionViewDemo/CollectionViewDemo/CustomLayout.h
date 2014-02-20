//
//  CustomLayout.h
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-24.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "CustomLayoutAttributes.h"

@protocol MyCustomDataSource;


@interface CustomLayout : UICollectionViewLayout

@property (nonatomic,weak)id<MyCustomDataSource>dataSource;


@end


@protocol MyCustomDataSource <NSObject>

- (NSInteger)numRowsForClassAndChildrenAtIndexPath:(NSIndexPath *)indexPath;
- (Item *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end