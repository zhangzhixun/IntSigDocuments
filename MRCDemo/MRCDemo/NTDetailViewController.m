//
//  NTDetailViewController.m
//  MRCDemo
//
//  Created by 张志勋 on 13-11-26.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NTDetailViewController.h"
#import "NTTiger.h"

@interface NTDetailViewController ()

@end

@implementation NTDetailViewController

- (void)dealloc
{
    [voiceView release];
    voiceView = nil;
    [super dealloc];
}

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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleBordered target:self action:@selector(tigerSaved)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    [rightButton release];
    if (!voiceView) {
        voiceView = [[UITextView alloc]initWithFrame:CGRectMake(10, 20, 200, 100)];
        voiceView.text = [self.theTiger voice];
        [self.view addSubview:voiceView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tigerSaved{
    if ([self.delegate respondsToSelector:@selector(tigerVoiceChanged:)]) {
        [self.delegate tigerVoiceChanged:voiceView.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
