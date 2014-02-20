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
    _detailViewController = nil;
    [_tigerArray release];
    [_catArray release];
    _detailViewController.delegate = nil;
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
//
//- (void)awakeFromNib{
//    NSString *tit = [[[NSString alloc]initWithString:@"aaaa"] autorelease];
//    NSLog(@"%@",tit);
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // wrong code here. arrayWithCapacity leads to autorelease.
//	tigerArray = [NSMutableArray arrayWithCapacity:4];
    _tigerArray = [[NSMutableArray alloc]init];
    NTTiger *tiger1 = [[NTTiger alloc]initWithVoice:@"hahahaah"];
    NTTiger *tiger2 = [[NTTiger alloc]initWithVoice:@"miaomiao"];
    NTTiger *tiger3 = [[NTTiger alloc]initWithVoice:@"wangwang"];
    NTTiger *tiger4 = [[NTTiger alloc]initWithVoice:@"wuwu"];
    
    [_tigerArray addObject:tiger1];
    [_tigerArray addObject:tiger2];
    [_tigerArray addObject:tiger3];
    [_tigerArray addObject:tiger4];
    [tiger1 release];
    [tiger2 release];
    [tiger3 release];
    [tiger4 release];
    
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        // solve the problem of seperate line 
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    NSLog(@"root view frame:%f",[self.tableView frame].origin.y);
    
    //invoke function
    [self sort];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.detailViewController = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tigerArray count];
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
    NTTiger *cellTiger = [_tigerArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:cellTiger.voice];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NTTiger *theTiger = [_tigerArray objectAtIndex:indexPath.row];
    if (!self.detailViewController) {
        
        self.detailViewController = [[[NTDetailViewController alloc]init]autorelease] ;
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
    [_tigerArray replaceObjectAtIndex:self.detailViewController.index withObject:changedTiger];
    [changedTiger release];
    [self.tableView reloadData];
}

#pragma mark - NSArray Sort

- (void)sort{
    [_tigerArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj2 name] compare:[obj1 name]];
        
    }];
    for (int i = 0; i < [_tigerArray count]; i++) {
        NSLog(@"%@",[[_tigerArray objectAtIndex:i] name]);
    }
}

#pragma mark - NSData Demo

- (void)getData{
    unsigned char aBuffer[20];
    NSString *myString = [@"Hello, world" copy];
    const char *utf8String = [myString UTF8String];
    NSData *myData = [NSData dataWithBytes:utf8String length:strlen(utf8String)];
    [myData getBytes:aBuffer length:20];
    NSLog(@"%s",aBuffer);
    [myString release];
}


@end
