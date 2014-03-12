//
//  NSString+Language.h
//  SlideRightDemo
//
//  Created by 张志勋 on 14-3-11.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

//  Judge the string's language in scope of Chinese, Japanese and Korean.

#import <Foundation/Foundation.h>

@interface NSString (Language)

- (BOOL)isChinese;

- (BOOL)isJapanese;

- (BOOL)isKorean;

- (BOOL)isInScopeOfCJK;

@end
