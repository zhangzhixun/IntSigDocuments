//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-17.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCell.h"
#import "CircleLayout.h"
#import "Item.h"
#import "SupplementaryView.h"

typedef int(^getAuth)(BOOL value);

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (id)init{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(100, 80);
//    layout.minimumLineSpacing = 20;
//    layout.sectionInset = UIEdgeInsetsMake(10, 20, 40, 80);
//    return [self initWithCollectionViewLayout:layout];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemArray = [NSMutableArray array];
    self.itemArray1 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        Item *item = [[Item alloc]initWithImage:[UIImage imageNamed:@"2465577_6.jpg"] name:[NSString stringWithFormat:@"image_%d",i] childrenCount:0 childrenIndexPath:nil];
        [self.itemArray addObject:item];
    }
    for (int i = 0; i < 4; i++) {
        Item *item = [[Item alloc]initWithImage:[UIImage imageNamed:@"tip.jpg"] name:[NSString stringWithFormat:@"image_%d",i] childrenCount:0 childrenIndexPath:nil];
        [self.itemArray1 addObject:item];
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SupplementaryView" bundle:nil] forSupplementaryViewOfKind:@"ConnectionViewKind" withReuseIdentifier:@"collectionSV"];
    [self.collectionView setBackgroundColor:[UIColor darkGrayColor]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addItem:)];
    tap.numberOfTapsRequired = 2;
    [self.collectionView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addItem:)];
    [tap requireGestureRecognizerToFail:tap1];
    tap1.numberOfTapsRequired = 3;
    [self.collectionView addGestureRecognizer:tap1];
    
    getAuth auth = ^(BOOL x){
        return x==YES? 1: 2;
    };
    NSLog(@"auth:%d",auth(YES));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)addItem:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    if (tap.numberOfTapsRequired == 2) {
        Item *item = [[Item alloc] initWithImage:[UIImage imageNamed:@"2465577_6.jpg"] name:@"item" childrenCount:0 childrenIndexPath:nil];
        [self.itemArray addObject:item];
        NSIndexPath *paths = [NSIndexPath indexPathForItem:0 inSection:0];
        NSArray *addArray = [[NSArray alloc] initWithObjects:paths, nil];
        [self.collectionView insertItemsAtIndexPaths:addArray];
    }else if (tap.numberOfTapsRequired == 3){
        Item *item = [[Item alloc] initWithImage:[UIImage imageNamed:@"tip.jpg"] name:@"item1" childrenCount:0 childrenIndexPath:nil];
        [self.itemArray1 addObject:item];
        NSIndexPath *paths = [NSIndexPath indexPathForItem:0 inSection:1];
        NSArray *addArray = [[NSArray alloc] initWithObjects:paths, nil];
        [self.collectionView insertItemsAtIndexPaths:addArray];
    }

}
#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected item at indexPath:%d,",indexPath.row);
    CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        [cell.imageView setTransform:CGAffineTransformRotate(cell.imageView.transform, 3.14)];
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    // Support only copying and pasting of cells.
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]
        || [NSStringFromSelector(action) isEqualToString:@"paste:"])
        return YES;
    
    // Prevent all other actions.
    return NO;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return [self.itemArray count];
    }else
        return [self.itemArray1 count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *resueIdentifier = @"collectionCell";
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:resueIdentifier forIndexPath:indexPath];
    //view didload 里已经 注册过nib，所以会自动判断 如果为空就去加载nib

    if (indexPath.section == 0) {
        Item *item = [self.itemArray objectAtIndex:indexPath.row];
        [cell.imageView setImage:item.image];
        [cell.textLabel setText:item.name];
    }else{
        Item *item = [self.itemArray1 objectAtIndex:indexPath.row];
        [cell.imageView setImage:item.image];
        [cell.textLabel setText:item.name];
    }
    UIView *bgView = [[UIView alloc]initWithFrame:cell.bounds];
    [bgView setBackgroundColor:[UIColor clearColor]];
    cell.backgroundView = bgView;
    
    UIView *selectedbgView = [[UIView alloc]initWithFrame:cell.bounds];
    [selectedbgView setBackgroundColor:[UIColor blueColor]];
    cell.selectedBackgroundView = selectedbgView;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString *resueIdentifier = @"collectionSV";
    SupplementaryView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:resueIdentifier forIndexPath:indexPath];
    
    return view;
}

#pragma mark - MyCustomDataSource

- (NSInteger)numRowsForClassAndChildrenAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 1;
        }
        if (indexPath.row == 4) {
            return 3;
        }
        
        
    }else if (indexPath.section == 1){
        return 1;
    }
    return 1;
}

- (Item *)itemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            Item *item = [self.itemArray objectAtIndex:indexPath.row];
            NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:1];
            NSArray *array = [NSArray arrayWithObjects:path, nil];
            item.childrenIndexPaths = array;
            return item;
        }else if (indexPath.row == 4){
            Item *item = [self.itemArray objectAtIndex:indexPath.row];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 1; i < 4; i ++) {
                NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:1];
                [array addObject:path];
            }
            item.childrenIndexPaths = array;
            return item;
        }
        return [self.itemArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 1)
        return [self.itemArray1 objectAtIndex:indexPath.row];
    return nil;    
}

@end
