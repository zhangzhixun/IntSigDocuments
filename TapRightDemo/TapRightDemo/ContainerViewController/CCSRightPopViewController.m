//
//  CCSRightPopViewController.m
//  CamCard_Sales
//
//  Created by Erick Xi on 3/11/14.
//
//

#import "CCSRightPopViewController.h"

@interface CCSRightPopViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, readwrite, strong) UIViewController *contentViewController;
@property (retain, nonatomic) IBOutlet UIView *containerView;

@end

@implementation CCSRightPopViewController

- (void)dealloc
{
    [_contentViewController release];
    [_containerView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0]];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [tapGR setDelegate:self];
    [self.view addGestureRecognizer:tapGR];
    [tapGR release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithContentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        _contentViewController = [viewController retain];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.containerView];
    if (![self.containerView pointInside:location withEvent:nil])
    {
        return YES;
    }
    return NO;
}

- (void)didTap:(UITapGestureRecognizer *)tap
{
    [self hideAnimated:YES completion:nil];
}

- (void)showFromViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    
    __block CGRect rect = viewController.view.bounds;
    rect.origin = CGPointMake(CGRectGetWidth(rect), 0);
    rect.size = CGSizeMake(CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(viewController.view.bounds));
    [self.containerView setFrame:rect];
    
    [self addChildViewController:self.contentViewController];
    [self.contentViewController.view setFrame:self.containerView.bounds];
    [self.containerView addSubview:self.contentViewController.view];
    
    CGFloat duration = animated? .25 : 0;
    
    [UIView animateWithDuration:duration animations:^
     {
         rect.origin = CGPointMake(CGRectGetWidth(viewController.view.bounds) - CGRectGetWidth(self.containerView.bounds), 0);
         [self.containerView setFrame:rect];
         [self.view setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.8]];
     }
     
                     completion:^(BOOL finished)
     {
         [self.contentViewController didMoveToParentViewController:self];
         [self didMoveToParentViewController:viewController];
         if (completion) {
             completion(finished);
         }
     }];
    
}

- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    CGFloat duration = animated? .25 : 0;
    [self willMoveToParentViewController:nil];
    [UIView animateWithDuration:duration animations:^
     {
         CGRect rect = self.containerView.frame;
         rect.origin.x += CGRectGetWidth(rect);
         [self.containerView setFrame:rect];
         [self.view setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0]];
     }
                     completion:^(BOOL finished)
     {
         [self.view removeFromSuperview];
         [self removeFromParentViewController];
         if (completion) {
             completion(finished);
         }
     }];
}

@end


@implementation UIViewController (RightPopOver)

- (CCSRightPopViewController *)rightPopViewController
{
    if ([self.parentViewController isKindOfClass:[CCSRightPopViewController class]])
    {
        return (id)self.parentViewController;
    }
    return nil;
}

@end
