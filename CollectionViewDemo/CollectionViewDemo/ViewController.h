//
//  ViewController.h
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-17.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLayout.h"

@interface ViewController : UICollectionViewController<MyCustomDataSource>

@property (nonatomic,strong)NSMutableArray *itemArray;
@property (nonatomic,strong)NSMutableArray *itemArray1;

@end
