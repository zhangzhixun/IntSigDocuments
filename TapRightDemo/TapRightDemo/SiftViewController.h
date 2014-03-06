//
//  SiftViewController.h
//  TapRightDemo
//
//  Created by 张志勋 on 14-3-3.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideViewDelegate <NSObject>

- (void)slideViewDidDismiss:(UIView *)view;
- (void)slideView:(UIView *)view selectedItem:(NSIndexPath *)indexPath;

@end

@interface SiftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,weak)id<SlideViewDelegate> delegate;
@property(nonatomic,weak)IBOutlet UINavigationBar *navBar;

@property(nonatomic,strong)NSArray *cardData;

@end
