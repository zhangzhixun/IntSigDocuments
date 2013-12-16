//
//  OViewController.m
//  OverwriteDemo
//
//  Created by 张志勋 on 13-12-5.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "OViewController.h"
#import "OImageView.h"
#import "OLabel.h"
#import "OButton.h"

@interface OViewController (){
    OLabel *label;
}

@end

@implementation OViewController

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
    
    OImageView *imgView = [[OImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    [imgView setImage:[UIImage imageNamed:@"2465577_6.jpg"]];
    [self.view addSubview:imgView];
    [imgView release];

    
    label = [[OLabel alloc]initWithFrame:CGRectMake(50, 310, 100, 30)];
    label.text = @"hell world";
    label.font = [UIFont fontWithName:@"alba" size:20];
    label.color = [UIColor redColor];
    [label.layer addAnimation:[self getKeyframeAni] forKey:@"popUp"];
    [self.view addSubview:label];
    [label release];
    
    OButton *btn = [[OButton alloc] initWithFrame:CGRectMake(50, 350, 100, 30)];
    [btn setText:@"btn"];
    [btn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn release];
}

- (void)print{    
    [label.layer addAnimation:[self getKeyframeAni] forKey:@"popUp"];
}

- (CAKeyframeAnimation *)getKeyframeAni{
    CAKeyframeAnimation* popAni=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAni.duration=0.4;
    popAni.values=@[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1.0)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAni.keyTimes=@[@0.0,@0.5,@0.75,@1.0];
    popAni.timingFunctions=@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    
    return popAni;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
