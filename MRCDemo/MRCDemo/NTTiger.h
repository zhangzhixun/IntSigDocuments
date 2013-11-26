//
//  NTTiger.h
//  MRCDemo
//
//  Created by 张志勋 on 13-11-25.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTTiger : NSObject{
    NSString *voice;
}

@property(nonatomic,retain)NSString *voice;

- (id)initWithVoice:(NSString *)thevoice;

@end
