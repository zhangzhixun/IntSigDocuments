//
//  ViewController.h
//  ScrollPageDemo
//
//  Created by 张志勋 on 13-12-23.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>{

    NSMutableArray *pageViewControllers;
    UIPageViewController *pv;
}

- (IBAction)go:(id)sender;
- (IBAction)gotoPage:(id)sender;

@end
