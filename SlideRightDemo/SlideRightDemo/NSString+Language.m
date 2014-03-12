//
//  NSString+Language.m
//  SlideRightDemo
//
//  Created by 张志勋 on 14-3-11.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "NSString+Language.h"



@implementation NSString (Language)


- (BOOL)isChinese{
    unichar c;
    for (int i = 0; i < [self length]; i++) {
        c = [self characterAtIndex:i];
        if (![self isCharacterChinese:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isJapanese{
    unichar c;
    for (int i = 0; i < [self length]; i++) {
        c = [self characterAtIndex:i];
        if (![self isCharacterJapanese:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isKorean{
    unichar c;
    for (int i = 0; i < [self length]; i++) {
        c = [self characterAtIndex:i];
        if (![self isCharacterKorean:c]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)isInScopeOfCJK{
    unichar c;
    for (int i = 0; i < [self length]; i++) {
        c = [self characterAtIndex:i];
        if (![self isCharacterInScopeOfCJK:c]) {
            return NO;
        }
    }
    return YES;
}

//Chinese unicode : 2E80-2FDF,3400-4DBF,4E00-9FFF
- (BOOL)isCharacterChinese:(unichar)aChar{
    long num = aChar;
    if ((num >= 0x4E00 && num <= 0x9FFF) || (num >= 0x2E80 && num <= 0x2FDF) || (num >= 0x3400 && num <= 0x4DBF)) {
        return YES;
    }
    return NO;
}
//Japanese unicode : 3040-30FF,31F0-31FF
- (BOOL)isCharacterJapanese:(unichar)aChar{
    long num = aChar;
    if ((num >= 0x3040 && num <= 0x30FF) || (num >= 0x31F0 && num <= 0x31FF)) {
        return YES;
    }
    return NO;
}

//Korean unicode : 1100-11FF,3130-318F,AC00-D7AF
- (BOOL)isCharacterKorean:(unichar)aChar{
    long num = aChar;
    if ((num >= 0x1100 && num <= 0x11FF) || (num >= 0x3130 && num <= 0x318F) || (num >= 0xAC00 && num <= 0xD7AF)) {
        return YES;
    }
    return NO;
}

- (BOOL)isCharacterInScopeOfCJK:(unichar)aChar{
    long num = aChar;
    if ((num >= 0x4E00 && num <= 0x9FFF) || (num >= 0x2E80 && num <= 0x2FDF) || (num >= 0x3400 && num <= 0x4DBF) || (num >= 0x3040 && num <= 0x30FF) || (num >= 0x31F0 && num <= 0x31FF) || (num >= 0x1100 && num <= 0x11FF) || (num >= 0x3130 && num <= 0x318F) || (num >= 0xAC00 && num <= 0xD7AF)) {
        return YES;
    }
    return NO;
}

@end
