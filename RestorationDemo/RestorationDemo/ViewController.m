//
//  ViewController.m
//  RestorationDemo
//
//  Created by 张志勋 on 13-12-30.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    NSLog(@"viewcontroller encode called");
    [coder encodeObject:[self.tf text] forKey:@"text"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    NSString *text = [coder decodeObjectForKey:@"text"];
    [self.tf setText:text];
    [super decodeRestorableStateWithCoder:coder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tf.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
