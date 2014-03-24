//
//  ViewController.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import "EGORefreshTableHeaderView.h"
#import "EGOLoadMoreFooterView.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout,EGORefreshTableHeaderDelegate,EGOLoadMoreFooterDelegate>{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGOLoadMoreFooterView *_loadMoreFooterView;
    
	BOOL _reloading;
}
@property (nonatomic, strong) UICollectionView *collectionView;

- (void)reloadCollectionViewDataSource;
- (void)doneLoadingCollectionViewData;

@end
