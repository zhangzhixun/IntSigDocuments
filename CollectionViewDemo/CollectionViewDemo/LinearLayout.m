//
//  LinearLayout.m
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-19.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "LinearLayout.h"

@implementation LinearLayout

- (id)init{
    if (self = [super init]) {
        self.minimumInteritemSpacing = 20.0;
        self.minimumLineSpacing = 50.0;
        return self;
    }
    return nil;
}

@end
