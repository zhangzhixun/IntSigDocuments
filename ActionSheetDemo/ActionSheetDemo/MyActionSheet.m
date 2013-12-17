//
//  MyActionSheet.m
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-16.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "MyActionSheet.h"

@implementation MyActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithViewHeight:(float)height title:(NSString *)title{
    if (self = [super init]) {
        _customTitle = title;
//        _customView = [[UIView alloc]init];
//        [_customView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height, [UIScreen mainScreen].bounds.size.width, height)];
//        [_customView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.7]];
        return self;
    }
    return nil;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    

    
    navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 280, 320, 30)];
    navBar.barStyle = UIBarStyleBlackOpaque;
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:self.customTitle];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
    navItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    navItem.rightBarButtonItem = rightButton;
    NSArray *array = [[NSArray alloc] initWithObjects:navItem, nil];
    [navBar setItems:array];
    
    [self.superview addSubview:navBar];
    
    [self.superview addSubview:self.customView];
}

- (void)docancel{
    [self dismissWithClickedButtonIndex:0 animated:YES];
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)done{
    [self dismissWithClickedButtonIndex:0 animated:YES];
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)showInView:(UIView *)view{
    navBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, -200);
    navBar.alpha = 0.2;
    [UIView animateWithDuration:1 animations:^{
        navBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity,0, 200);
        navBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        [super showInView:view];
    }];
    
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    if (animated) {
        navBar.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:1.0 animations:^{
            navBar.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -200);
            navBar.alpha = 0.2;
        } completion:^(BOOL finished) {
            
        }];
        [super dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }else{
        [super dismissWithClickedButtonIndex:buttonIndex animated:NO];
    }
    
}


@end
