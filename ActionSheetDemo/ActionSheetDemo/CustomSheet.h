//
//  CustomSheet.h
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-16.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSheetDelegate;

@interface CustomSheet : UIView{
    UIWindow *_overlayWindow;
    UIWindow *_mainWindow;
    UIView *_maskView;
    UILabel *_titleLabel;
}

@property (nonatomic,weak)id<CustomSheetDelegate> delegate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,strong)NSMutableArray *buttonTitles;


- (id)initWithTitle:(NSString *)title delegate:(id<CustomSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)show;
- (void)hide;

@end

@protocol CustomSheetDelegate <NSObject>

- (void)customSheet:(CustomSheet *)customSheet clickedButtonAtIndex:(NSInteger)index;

@end
