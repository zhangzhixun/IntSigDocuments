//
//  NTTiger.m
//  MRCDemo
//
//  Created by 张志勋 on 13-11-25.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NTTiger.h"

@implementation NTTiger

@synthesize voice;

- (void)dealloc{
    [_voice release];
    [super dealloc];
}

- (id)init{
    if (self = [super init]) {
        _voice = [@"Roar, I'm a tiger" copy];
        
    }
    return self;
}

- (NSString *)voice{
    return _voice;
}

- (void)setVoice:(NSString *)thevoice{
    if (_voice != thevoice) {
        [_voice release];
        _voice = [thevoice retain]; 
    }
}

- (id)initWithVoice:thevoice{
    if (self = [self init]) {
        self.voice = thevoice;
    }
    return self;
}

- (NSString *)name{
    return self.voice;
}

#pragma mark - NSCopy Protocol

- (NTTiger *)copyWithZone:(NSZone *)zone{
    NTTiger *newTiger = [[NTTiger alloc]init];
    [_voice copy];
    return newTiger;
}

#pragma mark - NSCoding Protocol

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_voice forKey:@"voice"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    _voice = [[aDecoder decodeObjectForKey:@"voice"] retain];
    return self;
}

@end
