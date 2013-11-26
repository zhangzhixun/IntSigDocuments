//
//  NTRootViewController.m
//  MRCDemo
//
//  Created by 张志勋 on 13-11-26.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NTRootViewController.h"
#import "NTTiger.h"
#import "NTDetailViewController.h"

@interface NTRootViewController ()

@end

@implementation NTRootViewController

- (void)dealloc
{
    [_detailViewController release];
    [tigerArray release];
    [_catArray release];
    self.detailViewController.delegate = nil;
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
    // wrong code here. arrayWithCapacity leads to autorelease.
//	tigerArray = [NSMutableArray arrayWithCapacity:4];
    tigerArray = [[NSMutableArray alloc]init];
    NTTiger *tiger1 = [[NTTiger alloc]initWithVoice:@"hahahaah"];
    NTTiger *tiger2 = [[NTTiger alloc]initWithVoice:@"miaomiao"];
    NTTiger *tiger3 = [[NTTiger alloc]initWithVoice:@"wangwang"];
    NTTiger *tiger4 = [[NTTiger alloc]initWithVoice:@"wuwu"];
    [tigerArray addObject:tiger1];
    [tigerArray addObject:tiger2];
    [tigerArray addObject:tiger3];
    [tigerArray addObject:tiger4];
    [tiger1 release];
    [tiger2 release];
    [tiger3 release];
    [tiger4 release];
    
    self.detailViewController = [[[NTDetailViewController alloc]init] autorelease];
    self.detailViewController.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tigerArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    NTTiger *cellTiger = [tigerArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:cellTiger.voice];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NTTiger *theTiger = [tigerArray objectAtIndex:indexPath.row];
    if (!self.detailViewController) {
        
        self.detailViewController = [[[NTDetailViewController alloc]init] autorelease];
        self.detailViewController.delegate = self;
    }
    self.detailViewController.theTiger = theTiger;
    self.detailViewController.index = indexPath.row;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
//    [theTiger release];
}

#pragma mark - TigerProtocol
- (void)tigerVoiceChanged:(NSString *)changedVoice{
    NTTiger *changedTiger = [[NTTiger alloc]initWithVoice:changedVoice];
    [tigerArray replaceObjectAtIndex:self.detailViewController.index withObject:changedTiger];
    [changedTiger release];
    [self.tableView reloadData];
    self.detailViewController = nil;
}

@end
