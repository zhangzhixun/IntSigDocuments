//
//  NTDetailViewController.m
//  MRCDemo
//
//  Created by 张志勋 on 13-11-26.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "NTDetailViewController.h"
#import "NTTiger.h"
#import <CoreLocation/CoreLocation.h>

@interface NTDetailViewController ()<CLLocationManagerDelegate>

@end

@implementation NTDetailViewController

- (void)dealloc
{
    [voiceView release];
    [_theTiger release];
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
    [self.view setBackgroundColor:[UIColor redColor]];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleBordered target:self action:@selector(tigerSaved)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    [rightButton release];
    if (!voiceView) {
        voiceView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 200, 100)];
        voiceView.text = self.theTiger.voice;
        [self.view addSubview:voiceView];
    }
    NSLog(@"detail view frame:%f",[self.view frame].origin.y);
    [self gestureTest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Custom Method

- (void)tigerSaved{
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(tigerVoiceChanged:)]) {
        [self.delegate tigerVoiceChanged:voiceView.text];
    }
}

- (void)ptahForSandBox{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tempPath = NSTemporaryDirectory();
    NSLog(@"%@,%@",[paths objectAtIndex:0],tempPath);
}

- (void)locationCode{
    CLLocationManager *locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate=self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; locationManager.distanceFilter = 1000.0f;
    [locationManager startUpdatingLocation];
}

- (void)gestureTest{
    // 向上擦碰
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)] autorelease];
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:oneFingerSwipeUp];
}

- (void) oneFingerSwipeUp:(UISwipeGestureRecognizer *) recognizer {
    CGPoint point = [recognizer locationInView:self.view];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

#pragma mark -
#pragma mark UIResponder Method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        [self.view performSelector:@selector(setBackgroundColor:) withObject:[UIColor blueColor] afterDelay:2.0];
    }
    if (touch.tapCount == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self.view selector:@selector(setBackgroundColor:) object:[UIColor redColor]];
        [self.view setBackgroundColor:[UIColor greenColor]];
    }
}

@end
