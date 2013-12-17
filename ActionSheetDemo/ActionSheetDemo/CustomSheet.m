//
//  CustomSheet.m
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-16.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "CustomSheet.h"

@implementation CustomSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<CustomSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    if (self = [super init]) {
        _delegate = delegate;
        _buttonTitles = [NSMutableArray array];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *title = otherButtonTitles; title != nil; title = va_arg(args, NSString *)) {
            [_buttonTitles addObject:title];
        }
        va_end(args);
        if (destructiveButtonTitle) {
            [_buttonTitles addObject:destructiveButtonTitle];
        }
        if (cancelButtonTitle) {
            [_buttonTitles addObject:cancelButtonTitle];
        }
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 16)];
        [_titleLabel setText:title];
        
        return self;
    }
    return nil;
}

- (void)show{

    _mainWindow = [[[UIApplication sharedApplication]delegate] window];
    
    _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_maskView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.5]];
    
    _overlayWindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayWindow.hidden = NO;
    [_overlayWindow setWindowLevel:UIWindowLevelAlert];
    [_overlayWindow addSubview:_maskView];
    
//    [_mainWindow addSubview:_maskView];
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 60 * [self.buttonTitles count], [[UIScreen mainScreen] bounds].size.width, 60 * [self.buttonTitles count])];
    [self.backgroundView setBackgroundColor:[UIColor colorWithRed:0.4 green:0.6 blue:0.2 alpha:0.7]];
    [self addSubview:_backgroundView];
    
    [_titleLabel setCenter:CGPointMake(_backgroundView.frame.size.width/2, 8)];
    [_titleLabel setFont:[UIFont fontWithName:@"ST-Hei" size:8]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.backgroundView addSubview:_titleLabel];
    for (int i = 0; i < [self.buttonTitles count]; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 15*(i+1) + i * 40, [[UIScreen mainScreen] bounds].size.width - 60, 40)];

        [btn setTag:i];
        [btn setBackgroundColor:[UIColor darkGrayColor]];
        [btn setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundView addSubview:btn];
    }
    [_maskView addSubview:self];
    [self setFrame:_maskView.bounds];
    
    _maskView.alpha = 0;
    self.transform = CGAffineTransformMakeTranslation(0, self.backgroundView.frame.size.height);
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 1.0;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    [_overlayWindow makeKeyAndVisible];

    
}

- (void)buttonClicked:(id)sender{
    UIButton *clickedBtn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(customSheet:clickedButtonAtIndex:)]) {
        [self.delegate customSheet:self clickedButtonAtIndex:clickedBtn.tag];
    }
}

- (void)hide{

    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.alpha = 0;
        [self setTransform:CGAffineTransformTranslate(self.transform, 0, self.backgroundView.frame.size.height)];
    } completion:^(BOOL finished) {
        _maskView.hidden = YES;
        _overlayWindow.hidden = YES;
    }];
    [_mainWindow makeKeyAndVisible];

}

@end
