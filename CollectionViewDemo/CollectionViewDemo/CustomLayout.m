//
//  CustomLayout.m
//  CollectionViewDemo
//
//  Created by 张志勋 on 13-12-24.
//  Copyright (c) 2013年 IntSig. All rights reserved.
//

#import "CustomLayout.h"

#define INSET_TOP 20
#define INSET_LEFT 20
#define INSET_BOTTOM 20
#define INSET_RIGHT 20
#define ITEM_WIDTH 100
#define ITEM_HEIGHT 30

@interface CustomLayout()

@property (nonatomic) NSDictionary *layoutInformation;  //the layout attributes for all types of views within the collection view
@property (nonatomic) NSInteger maxNumRows; // how many rows are needed to populate the tallest column of the tree
@property (nonatomic) UIEdgeInsets insets;  //spacing between cells

@end

@implementation CustomLayout

- (id)init{
    if (self = [super init]) {
        _insets = UIEdgeInsetsMake(INSET_TOP, INSET_LEFT, INSET_BOTTOM, INSET_RIGHT);
        return self;
    }
    return nil;
}

- (void)prepareLayout{
    NSMutableDictionary *layoutInformation = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellInformation = [NSMutableDictionary dictionary];
    NSMutableDictionary *supplementaryInfo = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;
    
    NSInteger numSections = [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < numSections; section++){
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for(NSInteger item = 0; item < numItems; item++){
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            //cell view
            CustomLayoutAttributes *attributes = [self attributesWithChildrenAtIndexPath:indexPath];
            [cellInformation setObject:attributes forKey:indexPath];
            
            //supplementary view
            UICollectionViewLayoutAttributes *supplemenaryAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"ConnectionViewKind" withIndexPath:indexPath];
            [supplementaryInfo setObject:supplemenaryAttributes forKey:indexPath];
        }
    }
    for(NSInteger section = numSections - 1; section >= 0; section--){
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        NSInteger totalHeight = 0;
        for(NSInteger item = 0; item < numItems; item++){
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CustomLayoutAttributes *attributes = [cellInformation objectForKey:indexPath]; // 1
            attributes.frame = [self frameForCellAtIndexPath:indexPath
                                                  withHeight:totalHeight];
            cellInformation = [self adjustFramesOfChildrenForClassAtIndexPath:indexPath withAttributes:attributes toCellInformation:cellInformation]; // 2
            cellInformation[indexPath] = attributes;
            
            totalHeight += [self.dataSource numRowsForClassAndChildrenAtIndexPath:indexPath]; // 3
            
            
        }
        if(section == 0){
            self.maxNumRows = totalHeight; // 4
        }
    }
    for(NSInteger section = numSections - 1; section > 0; section--){
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for(NSInteger item = 0; item < numItems; item++){
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CustomLayoutAttributes *attributes = [cellInformation objectForKey:indexPath];
            UICollectionViewLayoutAttributes *supplementaryAttributes = [supplementaryInfo objectForKey:indexPath];
            supplementaryAttributes.frame = [self frameForSupplementaryViewOfKind:@"ConnectionViewKind" AtIndexPath:indexPath];
            supplementaryAttributes.frame = [self adjustFramesOfConnectorsForClassAtIndexPath:indexPath withAttributes:attributes toSupplementaryAttr:supplementaryAttributes];
            [supplementaryInfo setObject:supplementaryAttributes forKey:indexPath];
        }
    }
    
    [layoutInformation setObject:cellInformation forKey:@"MyCellKind"]; // 5
    [layoutInformation setObject:supplementaryInfo forKey:@"ConnectionViewKind"];
    
    
    self.layoutInformation = layoutInformation;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = self.collectionView.numberOfSections * (ITEM_WIDTH + self.insets.left + self.insets.right);
    CGFloat height = self.maxNumRows * (ITEM_HEIGHT + _insets.top + _insets.bottom);
    return CGSizeMake(width, height);
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *myAttributes = [NSMutableArray arrayWithCapacity:self.layoutInformation.count];
    for(NSString *key in self.layoutInformation){
        NSDictionary *attributesDict = [self.layoutInformation objectForKey:key];
        for(NSIndexPath *key in attributesDict){
            UICollectionViewLayoutAttributes *attributes = [attributesDict objectForKey:key];
            if(CGRectIntersectsRect(rect, attributes.frame)){
                [myAttributes addObject:attributes];
            }
        }
    }
    return myAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.layoutInformation[@"MyCellKind"][indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return self.layoutInformation[kind][indexPath];
}

#pragma mark - Custom Method

- (CustomLayoutAttributes *)attributesWithChildrenAtIndexPath:(NSIndexPath *)indexPath{
    CustomLayoutAttributes *itemAttributes = [CustomLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    Item *item = [self.dataSource itemAtIndexPath:indexPath];
    itemAttributes.children = item.childrenIndexPaths;

    return itemAttributes;
}

- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath
                       withHeight:(NSInteger)totalHeight{
    
    CGRect frame;
    frame.origin.x = indexPath.section * (_insets.left + _insets.right + ITEM_WIDTH);
    frame.origin.y = totalHeight * (_insets.top + _insets.bottom + ITEM_HEIGHT);
    frame.size.width = ITEM_WIDTH;
    frame.size.height = ITEM_HEIGHT;
    return frame;
}

- (CGRect)frameForSupplementaryViewOfKind:(NSString *)kind
                              AtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame;
    if ([kind isEqualToString:@"ConnectionViewKind"]) {
        if (indexPath.section > 0) {
            frame.origin.x = indexPath.section *(ITEM_WIDTH + _insets.left + _insets.right) - _insets.left - _insets.right;
            frame.origin.y = indexPath.row * (ITEM_HEIGHT + _insets.top + _insets.bottom);
            frame.size.width = _insets.left + _insets.right;
            frame.size.height = ITEM_HEIGHT + _insets.top + _insets.bottom;
            return frame;
        }
    }
    return CGRectZero;
}

- (NSMutableDictionary *)adjustFramesOfChildrenForClassAtIndexPath:(NSIndexPath *)indexPath
                                                withAttributes:(CustomLayoutAttributes *)attributes
                                             toCellInformation:(NSMutableDictionary *)cellInformation
{
    NSInteger sectionCount = [self.collectionView numberOfSections];
    if (indexPath.section < sectionCount - 1) {
        
        NSArray *attrArray = attributes.children;
        for (int i = 0 ; i < [attrArray count]; i++) {
            NSIndexPath *path = [attrArray objectAtIndex:i];
            CustomLayoutAttributes *attrChild = [self attributesWithChildrenAtIndexPath:path];
            CGRect frame = attributes.frame;
            frame.origin.x += _insets.left + _insets.right + ITEM_WIDTH;
            frame.origin.y += (_insets.top + _insets.bottom + ITEM_HEIGHT) * i;
            attrChild.frame = frame;
            [cellInformation setObject:attrChild forKey:path];
            
        }
    }
    return cellInformation;
}

- (CGRect)adjustFramesOfConnectorsForClassAtIndexPath:(NSIndexPath *)indexPath
                                       withAttributes:(CustomLayoutAttributes *)attributes
                                  toSupplementaryAttr:(UICollectionViewLayoutAttributes *)supplementaryAttr
{
    if (indexPath.section > 0) {
        CGRect frame = attributes.frame;
        frame.origin.x -= _insets.left + _insets.right;
        frame.size = supplementaryAttr.frame.size;
        return frame;
    }
    return CGRectZero;
}

@end
