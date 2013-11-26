//
//  NTTiger.m
//  MRCDemo
//
//  Created by 张志勋 on 13-11-25.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NTTiger.h"

@implementation NTTiger
@synthesize voice = voice;

- (void)dealloc{
    [voice release];
    [super dealloc];
}

- (id)init{
    if (self = [super init]) {
        voice = @"Roar, I'm a tiger";
    }
    return self;
}

- (NSString *)voice{
    return voice;
}

- (id)initWithVoice:thevoice{
    if (self = [self init]) {
        voice = [thevoice retain];
    }
    return self;
}


@end
