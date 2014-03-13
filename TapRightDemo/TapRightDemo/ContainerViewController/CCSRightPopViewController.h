//
//  CCSRightPopViewController.h
//  CamCard_Sales
//
//  Created by Erick Xi on 3/11/14.
//
//

#import <UIKit/UIKit.h>

@interface CCSRightPopViewController : UIViewController

@property (nonatomic, readonly) UIViewController *contentViewController;

- (id)initWithContentViewController:(UIViewController *)viewController;

- (void)showFromViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)hideAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end


@interface UIViewController (RightPopOver)

- (CCSRightPopViewController *)rightPopViewController;

@end