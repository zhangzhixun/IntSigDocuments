//
//  ViewController.m
//  ActionSheetDemo
//
//  Created by 张志勋 on 13-12-16.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MyActionSheet.h"

@interface ViewController (){
    UIButton *btn;
}

@end

@implementation ViewController

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
    btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"custom sheet" forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"my action sheet" forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, 100, 40)];
    [btn1 setBackgroundColor:[UIColor brownColor]];
    [btn1 setTitle:@"push to another" forState:UIControlStateNormal];
    [btn1 addTarget:self  action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)click{
    NSLog(@"click");
    CustomSheet *sheet = [[CustomSheet alloc] initWithTitle:@"custom" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"action one",@"action two",nil];
    [sheet show];

}

- (void)click2{
    MyActionSheet *sheet = [[MyActionSheet alloc]initWithViewHeight:200 title:@"custom"];
    sheet.delegate = self;
    [sheet addButtonWithTitle:@"action one"];
    [sheet addButtonWithTitle:@"action two"];
    [sheet addButtonWithTitle:@"action three"];
    [sheet setCancelButtonIndex:2];
    [sheet setDestructiveButtonIndex:0];
    [sheet showInView:self.view];
}

- (void)click1{
    [self.navigationController pushViewController:[[DetailViewController alloc] init] animated:YES];
}

#pragma mark CustomSheetDelegate

- (void)customSheet:(CustomSheet *)customSheet clickedButtonAtIndex:(NSInteger)index{
    [customSheet hide];
    NSLog(@"clicked button index : %d",index);
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"click at index:%d",buttonIndex);

}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    NSLog(@"action sheet canceled");
}

@end
