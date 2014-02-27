//
//  ViewController.m
//  TableViewTouchImageDemo
//
//  Created by 张志勋 on 14-2-26.
//  Copyright (c) 2014年 zhixun_zhang. All rights reserved.
//

#import "ViewController.h"
#import "CustomImageVIew.h"
#import "CustomSearchBar.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UITableView *tableView;
    CustomSearchBar *searchBar;
}

@end

#define FULL_WIDTH self.view.bounds.size.width
#define FULL_HEIGHT self.view.bounds.size.height

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, FULL_WIDTH, FULL_HEIGHT - 50) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    searchBar = [[CustomSearchBar alloc]initWithFrame:CGRectMake(0, 20, FULL_WIDTH, 30)];
    searchBar.barTintColor = [UIColor lightGrayColor];
    searchBar.placeholder = @"aaaaaa";
    searchBar.showsCancelButton = YES;
    
    //set textfield background image
//    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"Unknown.jpg"] forState:UIControlStateNormal];
    
    //set inputAccessoryView
    [searchBar setInputAccessoryView:({
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [img setBackgroundColor:[UIColor blueColor]];
        img;
    })];
    
    [searchBar setPositionAdjustment:UIOffsetMake(0, 0) forSearchBarIcon:UISearchBarIconSearch];
    [searchBar setSearchTextPositionAdjustment:UIOffsetMake(0, 0)];
    
    [self.view addSubview:searchBar];
}

- (void)viewDidAppear:(BOOL)animated{
    //获取textfield
    for (UIView *v in searchBar.subviews) {
        for (UIView *subV in v.subviews) {
            if ([subV isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                NSLog(@"found textfield");
            }
        }
    }
    //另一种方法获取textfield
    UITextField *txfSearchField = [searchBar valueForKey:@"_searchField"];
    CGRect f = txfSearchField.frame;
    f.size.width -= 30;
    txfSearchField.frame = f;
    txfSearchField.rightViewMode = UITextFieldViewModeWhileEditing;
    [txfSearchField setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightView setContentMode:UIViewContentModeScaleAspectFill];
    [rightView setBackgroundColor:[UIColor yellowColor]];
    txfSearchField.rightView = rightView;
    //    txfSearchField.textAlignment = NSTextAlignmentCenter;
    //    [txfSearchField setBorderStyle:UITextBorderStyleRoundedRect];
    //    txfSearchField.layer.borderWidth = 8.0f;
    //    txfSearchField.layer.cornerRadius = 10.0f;
    //    txfSearchField.layer.borderColor = [UIColor clearColor].CGColor;
    
    // Change search bar text color
    txfSearchField.textColor = [UIColor redColor];
    
    // Change the search bar placeholder text color
    [txfSearchField setValue:[UIColor greenColor] forKeyPath:@"_placeholderLabel.textColor"];
    
//    [txfSearchField setLeftViewMode:UITextFieldViewModeNever];
    //custom searchbar and use private API
//    searchBar.hasCentredPlaceholder = NO;
    txfSearchField.textAlignment = NSTextAlignmentLeft;
    
    
    //默认的放大镜
//    txfSearchField.leftView = ({
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-50, 0, 30, 30)];
//        [view setBackgroundColor:[UIColor purpleColor]];
//        view;
//    });
    

    for (id btn in [[searchBar.subviews objectAtIndex:0] subviews]) {
        if ([btn isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn=(UIButton *)btn;
            [tempBtn setHighlighted:YES];
            [tempBtn setBackgroundImage:[UIImage imageNamed:@"Unknown.jpg"] forState:UIControlStateNormal];
            [tempBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
            tempBtn.showsTouchWhenHighlighted=YES;
        }
    }

}

- (void)tapImage:(UIGestureRecognizer *)sender{
    NSLog(@"tap gesture");
    [searchBar resignFirstResponder];

}



#pragma mark - UITableView DataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:@"aaaa"];
    CustomImageVIew *imgView = [[CustomImageVIew alloc]initWithFrame:CGRectMake(200, 0, 100, 100)];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setImage:[UIImage imageNamed:@"Unknown.jpg"]];
    imgView.userInteractionEnabled = YES;
    [cell.contentView addSubview:imgView];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [name setText:@"jialebihaidao"];
    name.userInteractionEnabled = YES;
    [name setFont:[UIFont systemFontOfSize:11.0f]];
    [name setTextColor:[UIColor redColor]];
    [imgView addSubview:name];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    tap.delaysTouchesBegan = NO;//if YES, then cancelsTouchesInView is not significant
    tap.cancelsTouchesInView = NO;
    tap.delegate = self;
    [imgView addGestureRecognizer:tap];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select row at indexpath:%d",indexPath.row);
    [searchBar resignFirstResponder];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
