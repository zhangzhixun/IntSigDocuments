//
//  MyActionSheet.h
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-16.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyActionSheet : UIActionSheet{
    UINavigationBar *navBar;
}

@property (nonatomic, retain) UIView *customView;
@property (nonatomic, retain) NSString *customTitle;

- (id)initWithViewHeight:(float)height title:(NSString *)title;

@end
