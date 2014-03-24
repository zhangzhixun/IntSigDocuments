//
//  EGOLoadMoreFooterView.h
//  Demo
//
//  Created by 张志勋 on 14-3-19.
//  Copyright (c) 2014年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOLoadMorePulling = 0,
	EGOLoadMoreNormal,
	EGOLoadMoreLoading,
} EGOLoadMoreState;

@protocol EGOLoadMoreFooterDelegate;
@interface EGOLoadMoreFooterView : UIView{
    __weak id _delegate;
	EGOLoadMoreState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
    
    CGFloat triggerPoint;
}

@property(nonatomic,weak) id <EGOLoadMoreFooterDelegate> delegate;

- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor;

- (void)refreshLastUpdatedDate;
- (void)egoLoadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoLoadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoLoadMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end


@protocol EGOLoadMoreFooterDelegate
- (void)egoLoadMoreFooterDidTriggerRefresh:(EGOLoadMoreFooterView *)view;
- (BOOL)egoLoadMoreFooterDataSourceIsLoading:(EGOLoadMoreFooterView*)view;
@optional
- (NSDate*)egoLoadMoreFooterDataSourceLastUpdated:(EGOLoadMoreFooterView*)view;
@end