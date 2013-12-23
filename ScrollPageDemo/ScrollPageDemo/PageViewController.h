//
//  PageViewController.h
//  ScrollPageDemo
//
//  Created by 张志勋 on 13-12-23.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController<UIScrollViewDelegate>{
    UIScrollView *scrollView;
    NSArray *pictures;
}

@property (nonatomic,weak)IBOutlet UIPageControl *pageControl;

@end
