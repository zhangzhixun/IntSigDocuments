//
//  CustomSearchBar.m
//  TableViewTouchImageDemo
//
//  Created by 张志勋 on 14-2-27.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar


// ------------------------------------------------------------------------------------------
#pragma mark - Initializers
// ------------------------------------------------------------------------------------------
- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.hasCentredPlaceholder = YES;
    }
    
    return self;
}


// ------------------------------------------------------------------------------------------
#pragma mark - Methods
// ------------------------------------------------------------------------------------------
- (void)setHasCentredPlaceholder:(BOOL)hasCentredPlaceholder
{
    _hasCentredPlaceholder = hasCentredPlaceholder;
    
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector])
    {
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&_hasCentredPlaceholder atIndex:2];
        [invocation invoke];
    }
    
}


@end
