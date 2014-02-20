//
//  MDViewController.m
//  UIDynamicDemo
//
//  Created by 张志勋 on 13-12-9.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "MDViewController.h"

@interface MDViewController (){
    UIView *gView;
}

@property (nonatomic,strong)UIDynamicAnimator *animator;
@property (nonatomic,strong)UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic,strong)UIGravityBehavior *behavior;
@property (nonatomic,strong)UICollisionBehavior *collisionBehavior;
@property (nonatomic,strong)UIView *gView;

@end

@implementation MDViewController

@synthesize gView = gView;


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
    
    gView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [gView setBackgroundColor:[UIColor grayColor]];
    gView.transform = CGAffineTransformRotate(gView.transform, 45);
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleAttachmentGesture:)];
    [gView addGestureRecognizer:gesture];
    
    [self.view addSubview:gView];    

    [self fallDown];
}

- (void)fallDown{
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    self.behavior = [[UIGravityBehavior alloc] initWithItems:@[gView]];
    
    self.collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[gView]];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    
    [self.animator addBehavior:self.collisionBehavior];
    
    [self.animator addBehavior:self.behavior];
    
    

}

- (void)handleAttachmentGesture:(UIPanGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"started");

        CGPoint centerPoint = CGPointMake(gView.center.x, gView.center.y - 100.0);
        UIOffset attachmentOffset = UIOffsetMake(-25, -25);
        
        self.attachmentBehavior = [[UIAttachmentBehavior alloc]initWithItem:gView offsetFromCenter:attachmentOffset attachedToAnchor:centerPoint];
        
        [self.animator addBehavior:self.attachmentBehavior];


    }else if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint location = [gesture locationInView:self.view];
        NSLog(@"changed:%f,%f",location.x,location.y);
        
        [self.attachmentBehavior setAnchorPoint:location];

    }else if (gesture.state == UIGestureRecognizerStateEnded){
        NSLog(@"ended");

        [self.animator removeBehavior:self.attachmentBehavior];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
