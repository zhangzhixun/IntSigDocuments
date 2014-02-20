//
//  NADetailViewController.m
//  NavAnimationDemo
//
//  Created by 张志勋 on 13-12-2.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NADetailViewController.h"
#import "NACoreAnimationController.h"

@interface NADetailViewController ()

@end

@implementation NADetailViewController

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

    [self.customBtn addTarget:self action:@selector(coreAnimationGoBack) forControlEvents:UIControlEventTouchUpInside];
    [self.textLabel addTarget:self action:@selector(customGoBack) forControlEvents:UIControlEventTouchUpInside];
    
    //Core Animation
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customGoBack{
    [UIView animateWithDuration:0.75
                     animations:^{
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
                     }];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)coreAnimationGoBack{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    NADetailViewController *caVC = [storyBoard instantiateViewControllerWithIdentifier:@"Core"];
    [self.navigationController pushViewController:caVC animated:YES];
}


@end
