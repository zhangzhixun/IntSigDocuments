//
//  PageViewController.m
//  ScrollPageDemo
//
//  Created by 张志勋 on 13-12-23.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pictures = [NSArray arrayWithObjects:@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg", nil];
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * [pictures count], [UIScreen mainScreen].bounds.size.height);
//    scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * [pictures count]/2, 0);
//    scrollView.contentInset = UIEdgeInsetsMake(20, 10, 20, 10);
    [scrollView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.8]];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    for (int i = 0; i < [pictures count]; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[pictures objectAtIndex:i]]];
        [imgView setFrame: CGRectMake(320 * i, 0, 320, 480)];
        [scrollView addSubview:imgView];
    }
    
    [self.view bringSubviewToFront:self.pageControl];
    [self.pageControl setTintColor:[UIColor colorWithCGColor:[UIColor redColor].CGColor]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changePage:(id)sender{
    int page = self.pageControl.currentPage;
    [UIView animateWithDuration:0.5 animations:^{
        [scrollView setContentOffset:CGPointMake(page * 320, 0)];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)ascrollView{
    int x = scrollView.contentOffset.x / 320;
    [self.pageControl setCurrentPage:x];
}

@end
