//
//  OButton.h
//  OverwriteDemo
//
//  Created by 张志勋 on 13-12-5.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OButton : UIView{
    id _delegate;
    UIControlEvents controlEvent;
    SEL methodAction;
}
@property (nonatomic,copy)NSString *text;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents; 

@end
