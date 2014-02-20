//
//  ViewController.m
//  MapTableViewDemo
//
//  Created by 张志勋 on 14-2-18.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

#define FULL_HEIGHT self.view.bounds.size.height
#define TABLE_HEIGHT 400

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
        showTableButton = [[UIButton alloc]initWithFrame:CGRectMake(50, self.view.bounds.size.height - 200, 70, 40)];
        [showTableButton setTitle:@"显示列表" forState:UIControlStateNormal];
        [showTableButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [showTableButton.layer setBorderWidth:2.0];
        [showTableButton.layer setBorderColor:[UIColor grayColor].CGColor];
        showTableButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [showTableButton addTarget:self action:@selector(showTableView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    //set the map
    map = [[MKMapView alloc]initWithFrame:CGRectMake(0, -100, self.view.bounds.size.width, FULL_HEIGHT)];
    map.showsUserLocation = YES;
    map.delegate = self;
    [self.view addSubview:map];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - TABLE_HEIGHT, self.view.bounds.size.width, TABLE_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = NO;
    self.tableView.clipsToBounds = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    self.tableView.autoresizesSubviews = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)showTableView{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, self.view.bounds.size.height - TABLE_HEIGHT, self.view.bounds.size.width, TABLE_HEIGHT);
        [showTableButton removeFromSuperview];
        map.frame = CGRectMake(0, -100, self.view.bounds.size.width, FULL_HEIGHT);
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
    NSLog(@"-------scroll offset = %f",scrollOffset);
    if(scrollOffset <= 0) {  // 下拉
        if (!isMapFullScreen) {
            CGRect f = CGRectMake(0, -100, self.view.bounds.size.width, FULL_HEIGHT);
            f.origin.y -= scrollOffset/2;
            [map setFrame:f];
        }
        
    }else{  //上拉
        if (self.isRollUpEnabled) {
            CGRect f = CGRectMake(0, -100, self.view.bounds.size.width, FULL_HEIGHT);
            f.origin.y -= scrollOffset/3;
            [map setFrame:f];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // show the full map
    if (map.frame.origin.y > -60 || scrollView.contentOffset.y < -80) {
        isMapFullScreen = YES;
        [self.tableView setContentInset:UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)];
        
        [UIView animateWithDuration:0.3 animations:^{
            map.frame = self.view.bounds;
            CGRect f = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
            [self.tableView setFrame:f];
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
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"Map-%ld",(long)indexPath.row]];

    [cell setBackgroundColor:[UIColor yellowColor]];
    return cell;
}

#pragma mark - MKMapViewDelegate

- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(map.userLocation.coordinate, 500, 500);
    MKCoordinateRegion mapRegion = [map regionThatFits:region];
    [map setRegion:mapRegion];
}

@end
