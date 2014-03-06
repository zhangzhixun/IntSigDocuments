//
//  SiftViewController.m
//  TapRightDemo
//
//  Created by 张志勋 on 14-3-3.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "SiftViewController.h"
#import "CardCell.h"

#define SLIDE_HEIGHT [UIScreen mainScreen].bounds.size.height - 20
#define SLIDE_OFFSET 80

@interface SiftViewController ()

@end

@implementation SiftViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
   
    [self.view setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 20, [UIScreen mainScreen].bounds.size.width - SLIDE_OFFSET, SLIDE_HEIGHT)];
    
    self.navBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - SLIDE_OFFSET, 44);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width - SLIDE_OFFSET, SLIDE_HEIGHT - 44) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:@"CardCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)hideSlideView{
    [UIView animateWithDuration:0.3 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        if ([self.delegate respondsToSelector:@selector(slideViewDidDismiss:)]) {
            [self.delegate slideViewDidDismiss:self.view];
        }
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return 8;
    }
    return 13;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CardCell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *text = [NSString stringWithFormat: @"名片标签-%d",indexPath.row];
    [cell setLabelText:text];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
    [label setFont:[UIFont systemFontOfSize:13.0f]];
    [label setBackgroundColor:[UIColor clearColor]];
    [view addSubview:label];
    if (section == 0) {
        label.text = @"标签筛选";
        [label setTextColor:[UIColor redColor]];
        return view;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"";
    }else if (section == 1){
        return @"公共标签";
    }else
        return @"私有标签";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // send data
    if ([self.delegate respondsToSelector:@selector(slideView:selectedItem:)]) {
        [self.delegate slideView:self.view selectedItem:indexPath];
    }
    [self hideSlideView];
}


@end
