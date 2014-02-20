//
//  NTDetailViewController.h
//  MRCDemo
//
//  Created by 张志勋 on 13-11-26.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NTTiger;

@protocol TigerProtocol <NSObject>

- (void)tigerVoiceChanged:(NSString *)changedVoice;

@end

@interface NTDetailViewController : UIViewController{
    UITextView *voiceView;
}

@property(nonatomic,retain)NTTiger *theTiger;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)id<TigerProtocol> delegate;

@end
