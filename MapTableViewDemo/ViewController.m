//
//  ViewController.m
//  MapTableViewDemo
//
//  Created by 张志勋 on 14-2-18.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//


//-----------------------------------------------------
//tableview
//初始位置  0,200
//隐藏位置  0,self.view.bounds.size.height
//全屏位置  0,0
//
//
//
//





#import "ViewController.h"
#import <MapKit/MapKit.h>

#define FULL_HEIGHT self.view.bounds.size.height
#define TABLE_YPOINT 200
#define MAP_YPOINT -100

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate>{
    MKMapView *map;
    CLLocationManager *locationManager;
    BOOL isMapFullScreen;
    CGPoint previousLocation;
    CGPoint currentLocation;
    UIButton *showTableButton;
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //set the map
    map = [[MKMapView alloc]initWithFrame:CGRectMake(0, MAP_YPOINT, self.view.bounds.size.width, FULL_HEIGHT)];
    map.showsUserLocation = YES;
    map.delegate = self;
    [self.view addSubview:map];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TABLE_YPOINT, self.view.bounds.size.width, FULL_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = NO;
    self.tableView.clipsToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    self.tableView.autoresizesSubviews = YES;
    
    showTableButton = [[UIButton alloc]initWithFrame:CGRectMake(50, self.view.bounds.size.height - 100, 70, 40)];
    [showTableButton setTitle:@"显示列表" forState:UIControlStateNormal];
    [showTableButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showTableButton setBackgroundColor:[UIColor colorWithRed:22 green:100 blue:66 alpha:1.0]];
    [showTableButton.layer setBorderWidth:2.0];
    [showTableButton.layer setBorderColor:[UIColor grayColor].CGColor];
    showTableButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [showTableButton addTarget:self action:@selector(showTableView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showTableView{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.transform = CGAffineTransformIdentity;
        [showTableButton removeFromSuperview];
        map.frame = CGRectMake(0, MAP_YPOINT, self.view.bounds.size.width, FULL_HEIGHT);
    } completion:^(BOOL finished) {
        isMapFullScreen = NO;
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isMapFullScreen = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollOffset = scrollView.contentOffset.y;
    
    if (self.tableView.frame.origin.y < TABLE_YPOINT && self.tableView.frame.origin.y > 0) {// table在上半部分时
        isMapFullScreen = NO;
        NSLog(@"---1----scroll offset = %f",scrollOffset);
        if (scrollOffset < 0) {//下拉
            [UIView animateWithDuration:0.3 animations:^{
//                CGAffineTransform trans = self.tableView.transform;
//                self.tableView.transform = CGAffineTransformTranslate(trans, 0, fabsf(scrollOffset));
                
                
                CGRect tableFrame = self.tableView.frame;
                tableFrame.origin.y -= scrollOffset;
                self.tableView.frame = tableFrame;
                
                CGRect mapFrame = map.frame;
                mapFrame.origin.y -= scrollOffset;
                map.frame = mapFrame;
            } completion:^(BOOL finished) {
                [self.tableView setContentOffset:CGPointZero];
                
            }];
            
        }else if(scrollOffset > 0){// 上拉
            [UIView animateWithDuration:0.3 animations:^{
                
//                CGAffineTransform trans = self.tableView.transform;
//                self.tableView.transform = CGAffineTransformTranslate(trans, 0, -fabsf(scrollOffset));
                
                CGRect f = self.tableView.frame;
                f.origin.y -= scrollOffset;
                [self.tableView setFrame:f];
                
                f = CGRectMake(0, MAP_YPOINT, self.view.bounds.size.width, FULL_HEIGHT);
                CGFloat deltaY = TABLE_YPOINT - self.tableView.frame.origin.y;
                f.origin.y -= deltaY;
                [map setFrame:f];
                [self.tableView setContentOffset:CGPointZero];
            } completion:^(BOOL finished) {
                if (self.tableView.frame.origin.y < 10) {
                    [map setFrame:CGRectMake(0, MAP_YPOINT - TABLE_YPOINT, self.view.bounds.size.width, FULL_HEIGHT)];
                    [self.tableView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, FULL_HEIGHT)];
                }
            }];
        }
    }
    else if(self.tableView.frame.origin.y == 0){//table全屏时
        isMapFullScreen = NO;
        if (scrollOffset < 0) {//触发下拉
            [UIView animateWithDuration:0.3 animations:^{
                CGRect tableFrame = self.tableView.frame;
                tableFrame.origin.y -= scrollOffset;
                self.tableView.frame = tableFrame;
                
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    else{//初始位置
        NSLog(@"---2----scroll offset = %f",scrollOffset);
        if (!isMapFullScreen) {
            if(scrollOffset <= 0) {  // 下拉
                
                CGRect f = CGRectMake(0, MAP_YPOINT, self.view.bounds.size.width, FULL_HEIGHT);
                f.origin.y -= scrollOffset/2;
                [map setFrame:f];
            }else{//触发上拉效果
                if (self.tableView.frame.origin.y > 0 && scrollView.contentOffset.y < TABLE_YPOINT) {
                    [UIView animateWithDuration:0.3 animations:^{
                        CGRect f = self.tableView.frame;
                        f.origin.y -= scrollOffset*1;
                        [self.tableView setFrame:f];
                        
                        f = CGRectMake(0, MAP_YPOINT, self.view.bounds.size.width, FULL_HEIGHT);
                        f.origin.y -= scrollOffset;
                        [map setFrame:f];
                        [self.tableView setContentOffset:CGPointZero];
                    } completion:^(BOOL finished) {
                    }];
                }

            }
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // show the full map
    if ((map.frame.origin.y > -60 || scrollView.contentOffset.y < -80) && self.tableView.frame.origin.y >= TABLE_YPOINT){
        isMapFullScreen = YES;
        [self.tableView setContentInset:UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)];
        [UIView animateWithDuration:0.3 animations:^{
            map.frame = CGRectMake(0, 0, self.view.bounds.size.width, FULL_HEIGHT);
            //使用了transform属性
            self.tableView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, FULL_HEIGHT - TABLE_YPOINT);
        } completion:^(BOOL finished) {
            [self.tableView setContentInset:UIEdgeInsetsZero];
            [self.view addSubview:showTableButton];
            [self.view bringSubviewToFront:showTableButton];
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"Map-%ld",(long)indexPath.row]];

    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

#pragma mark - MKMapViewDelegate

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(map.userLocation.coordinate, 500, 500);
    MKCoordinateRegion mapRegion = [map regionThatFits:region];
    [map setRegion:mapRegion];
    
    //更改定位的显示中心
    CGFloat ratio = ABS(TABLE_YPOINT)/ 20 / (map.bounds.size.height - ABS(MAP_YPOINT));
    CGFloat y = ratio * (map.bounds.size.height - ABS(MAP_YPOINT))/2/(1- ratio);
    CGFloat height = (map.bounds.size.height - ABS(MAP_YPOINT))/2 - y;
    
    CGRect frame = CGRectMake(0, height, self.view.bounds.size.width, map.bounds.size.height - ABS(MAP_YPOINT) - height);
    mapRegion = [map convertRect:frame toRegionFromView:self.view];
    [map setRegion:mapRegion];
}

@end
