//
//  NTTiger.h
//  MRCDemo
//
//  Created by 张志勋 on 13-11-25.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTTiger : NSObject<NSCopying,NSCoding>{
    NSString *_voice;
}

@property(nonatomic,copy)NSString *voice;

- (id)initWithVoice:(NSString *)thevoice;
- (NSString *)name;

@end
