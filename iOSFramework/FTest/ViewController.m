//
//  ViewController.m
//  FTest
//
//  Created by 张志勋 on 14-1-2.
//  Copyright (c) 2014年 IntSig. All rights reserved.
//

#import "ViewController.h"
#import <iOSFramework/ClassAViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push{
    ClassAViewController *classA = [[ClassAViewController alloc]init];
    [classA.view setBackgroundColor:[UIColor redColor]];
    [self presentViewController:classA animated:YES completion:^{
        
    }];
}

@end
