//
//  ViewController.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "ViewController.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *cellSizes;

@end

@implementation ViewController

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.columnCount = 3;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.headerHeight = 15;
        layout.footerHeight = 40;
        layout.minimumColumnSpacing = 20;
        layout.minimumInteritemSpacing = 30;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
            forCellWithReuseIdentifier:CELL_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
                   withReuseIdentifier:HEADER_IDENTIFIER];
        [_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:FOOTER_IDENTIFIER];
    }
    return _collectionView;
}

- (NSMutableArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = [NSMutableArray array];
        for (NSInteger i = 0; i < CELL_COUNT; i++) {
            CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
            _cellSizes[i] = [NSValue valueWithCGSize:size];
        }
    }
    return _cellSizes;
}

- (NSMutableArray *)newCellSizesToAdd {
    NSMutableArray *newCellSizes = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i++) {
            CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
            newCellSizes[i] = [NSValue valueWithCGSize:size];
        }
    return newCellSizes;
}

#pragma mark - Life Cycle

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addDataToCollectionView)];
//    tap.numberOfTapsRequired = 2;
//    [self.collectionView addGestureRecognizer:tap];
    
    if (_refreshHeaderView == nil) {
		
		_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.collectionView.bounds.size.height, self.view.frame.size.width, self.collectionView.bounds.size.height)];
		_refreshHeaderView.delegate = self;
		[self.collectionView addSubview:_refreshHeaderView];
		
	}
	[_refreshHeaderView refreshLastUpdatedDate];
    
    if (_loadMoreFooterView == nil) {
        _loadMoreFooterView = [[EGOLoadMoreFooterView alloc]initWithFrame:CGRectZero];
        _loadMoreFooterView.delegate = self;
        [self.collectionView addSubview:_loadMoreFooterView];
    }
    [_loadMoreFooterView refreshLastUpdatedDate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
    
    [self setLoadMoreFooterView];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 3 : 4;
}

- (void)setLoadMoreFooterView
{
    //如果contentsize的高度比collectionView的高度小，那么就需要把刷新视图放在collectionView的bounds的下面
    CGFloat height = MAX(self.collectionView.bounds.size.height, self.collectionView.contentSize.height);
    if (_loadMoreFooterView && _loadMoreFooterView.superview) {
        _loadMoreFooterView.frame =CGRectMake(0.0f, height, self.collectionView.frame.size.width, self.view.bounds.size.height);
    }else{
        _loadMoreFooterView = [[EGOLoadMoreFooterView alloc] initWithFrame:CGRectMake(0.0f, height, self.collectionView.frame.size.width, self.view.bounds.size.height)];
        _loadMoreFooterView.delegate = self;
        [self.collectionView addSubview:_loadMoreFooterView];
        [_loadMoreFooterView refreshLastUpdatedDate];
    }
}

- (void)removeLoadMoreFooterView{
    if (_loadMoreFooterView && [_loadMoreFooterView superview])
	{
        [_loadMoreFooterView removeFromSuperview];
    }
    _loadMoreFooterView = nil;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellSizes.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    cell.displayString = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:FOOTER_IDENTIFIER
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellSizes[indexPath.item] CGSizeValue];
}

#pragma mark - Data source reloading / adding method

// header view , reloading data
- (void)reloadCollectionViewDataSource{

	_reloading = YES;
	[self performSelector:@selector(doneLoadingCollectionViewData) withObject:nil afterDelay:1.0];
}

// header view , data has been reloaded
- (void)doneLoadingCollectionViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
}

// footer view , adding data
- (void)addDataToCollectionView{
    _reloading = YES;
    
    //TODO - adding data custom method
    [self.cellSizes addObjectsFromArray:[self newCellSizesToAdd]];
    
    [self performSelector:@selector(doneAddingCollectionViewData) withObject:nil afterDelay:1.0];
}

// footer view, data has been added
- (void)doneAddingCollectionViewData{
	_reloading = NO;
//	[_loadMoreFooterView egoLoadMoreScrollViewDataSourceDidFinishedLoading:self.collectionView];
    [self.collectionView reloadData];
    [self removeLoadMoreFooterView];
    [self performSelector:@selector(setLoadMoreFooterView) withObject:nil afterDelay:0.1];
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreFooterView egoLoadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	[_loadMoreFooterView egoLoadMoreScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
	[self reloadCollectionViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark - EGOLoadMoreFooterDelegate

- (void)egoLoadMoreFooterDidTriggerRefresh:(EGOLoadMoreFooterView *)view{
    [self addDataToCollectionView];
	
}

- (BOOL)egoLoadMoreFooterDataSourceIsLoading:(EGOLoadMoreFooterView *)view{
    return _reloading;
}

- (NSDate *)egoLoadMoreFooterDataSourceLastUpdated:(EGOLoadMoreFooterView *)view{
    return [NSDate date];
}
@end
