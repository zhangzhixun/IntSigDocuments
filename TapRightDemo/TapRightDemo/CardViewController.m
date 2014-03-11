//
//  CardViewController.m
//  TapRightDemo
//
//  Created by 张志勋 on 14-3-3.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "CardViewController.h"
#import "SiftViewController.h"

#define SLIDE_OFFSET 80
#define TABBAR_HEIGHT 49

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
#endif

#define kIsRunVersionIOS7 kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber_iOS_6_1

@interface CardViewController ()<UITableViewDataSource,UITableViewDelegate,SlideViewDelegate>{
    SiftViewController *siftVC;
    UIView *_maskView;
    BOOL isSlideShown;
    UITapGestureRecognizer *tapGesture;
}

@end

@implementation CardViewController


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
    isSlideShown = NO;
    
    if (kIsRunVersionIOS7) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - TABBAR_HEIGHT) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - TABBAR_HEIGHT - 44) style:UITableViewStylePlain];
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview: self.tableView];

    if (kIsRunVersionIOS7) {
        self.tabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - TABBAR_HEIGHT, self.view.bounds.size.width, TABBAR_HEIGHT)];
    }else{
        self.tabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - TABBAR_HEIGHT - 44, self.view.bounds.size.width, TABBAR_HEIGHT)];
    }
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.tiff"]];
    [self.view addSubview:self.tabBar];

    
    _maskView = [[UIView alloc]initWithFrame:self.navigationController.view.bounds];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.hidden = YES;
    _maskView.alpha = 0.0;
    [self.navigationController.view addSubview:_maskView];
    
    
    if (kIsRunVersionIOS7) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    }
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(leftBarButtonClicked)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    siftVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Sift"];
    siftVC.delegate = self;
    [self.navigationController.view addSubview:siftVC.view];
    
    tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithGesture:)];
    [_maskView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - custom method

- (void)rightBarButtonClicked{    
    [UIView animateWithDuration:0.3 animations:^{
        siftVC.view.transform = CGAffineTransformMakeTranslation(SLIDE_OFFSET - [UIScreen mainScreen].bounds.size.width, 0);
        _maskView.hidden = NO;
        _maskView.alpha = 0.5;
    } completion:^(BOOL finished) {
        isSlideShown = YES;
    }];
}

- (void)leftBarButtonClicked{

}

- (void)tapWithGesture:(UIGestureRecognizer *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        siftVC.view.transform = CGAffineTransformIdentity;
        _maskView.hidden = YES;
        _maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        isSlideShown = NO;
    }];
}

#pragma mark - SlideViewDelegate

- (void)slideViewDidDismiss:(UIView *)view{
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformIdentity;
        _maskView.hidden = YES;
        _maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        isSlideShown = NO;
    }];
}

- (void)slideView:(UIView *)view selectedItem:(NSIndexPath *)indexPath{
    NSLog(@"selected item %d",indexPath.row);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:@"aaa"];
    return cell;
}

#pragma mark - Orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"%@,%@",NSStringFromSelector(_cmd),self);
}

-(void)viewWillLayoutSubviews{
    NSLog(@"%@,%@",NSStringFromSelector(_cmd),self);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"%@,%@",NSStringFromSelector(_cmd),self);
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - TABBAR_HEIGHT);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"%@,%@",NSStringFromSelector(_cmd),self);
}

@end
