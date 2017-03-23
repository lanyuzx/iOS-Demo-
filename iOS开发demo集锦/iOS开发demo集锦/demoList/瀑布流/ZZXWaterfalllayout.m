//
//  ZZXWaterfalllayout.m
//  瀑布流效果的实现
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 zunxian. All rights reserved.
// 思想:找出最短的 cell, 进行添加

#import "ZZXWaterfalllayout.h"
#import "ZZXClothers.h"

#define HMCollectionViewWidth self.collectionView.frame.size.width
// 默认行间距
static const CGFloat HMDefaultRowSpacing = 10;
// 默认列间距
static const CGFloat HMDefaultColumnSpacing = 10;
// 默认边距
static const UIEdgeInsets HMDefaultEdgeInsets = {10, 10, 10, 10};
// 默认列数
static const NSUInteger HMDefaultColumnCount = 3;


@interface ZZXWaterfalllayout ()
// 每一列的最大y坐标
@property (nonatomic, strong) NSMutableArray *columnMaxYArray;
// 存放所有cell的布局属性
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end

@implementation ZZXWaterfalllayout
#pragma mark - 懒加载
- (NSMutableArray *)columnMaxYArray {
    if (!_columnMaxYArray) {
        _columnMaxYArray = [[NSMutableArray alloc] init];
    }
    return _columnMaxYArray;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

#pragma mark - 实现内部方法
/**
 *  决定CollectionView的ContentSize
 */
- (CGSize)collectionViewContentSize {
    // 找出最长那一列的最大y坐标
    CGFloat destColumnMaxY = [self.columnMaxYArray[0] doubleValue];
    for (int i = 1; i < self.columnMaxYArray.count; i++) {
        CGFloat columnMaxY = [self.columnMaxYArray[i] doubleValue];
        if (columnMaxY > destColumnMaxY) {
            destColumnMaxY = columnMaxY;
        }
    }
    return CGSizeMake(HMCollectionViewWidth, destColumnMaxY + HMDefaultEdgeInsets.bottom);
}

- (void)prepareLayout {
    //    NSLog(@"prepareLayout");
    [super prepareLayout];
    // 重置每一列的最大y坐标
    [self.columnMaxYArray removeAllObjects];
    for (int i = 0; i < HMDefaultColumnCount; i++) {
        [self.columnMaxYArray addObject:@(HMDefaultEdgeInsets.top)];
    }
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  说明所有元素最终显示出来的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    //    NSLog(@"layoutAttributesForElementsInRect");
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.attrsArray.count; i++) {
        UICollectionViewLayoutAttributes *attrs = self.attrsArray[i];
        if (CGRectIntersectsRect(rect, attrs.frame)) {
            [array addObject:attrs];
        }
    }
    return array;
}

/**
 *  说明indexPath位置cell的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 计算indexPath位置cell的布局属性
    // 找出最短那一列的列号和最大y坐标
    CGFloat destColumnMaxY = [self.columnMaxYArray[0] doubleValue];
    NSUInteger destColumnIndex = 0;
    for (int i = 1; i < self.columnMaxYArray.count; i++) {
        CGFloat columnMaxY = [self.columnMaxYArray[i] doubleValue];
        if (columnMaxY < destColumnMaxY) {
            destColumnMaxY = columnMaxY;
            destColumnIndex = i;
        }
    }
    CGFloat totalColumnSpacing = (HMDefaultColumnCount - 1) * HMDefaultColumnSpacing;
    CGFloat width = (HMCollectionViewWidth - HMDefaultEdgeInsets.left - HMDefaultEdgeInsets.right - totalColumnSpacing) / HMDefaultColumnCount;
#warning TODO
    //根据模型中的高度计算 cell 的高度 不建议这样做
    
    ZZXClothers * clothes = self.clothesArray[indexPath.item];
    CGFloat height = clothes.h*width /clothes.w;
    
    
    CGFloat x = HMDefaultEdgeInsets.left + destColumnIndex * (width + HMDefaultColumnSpacing);
    CGFloat y = destColumnMaxY;
    if (destColumnMaxY != HMDefaultEdgeInsets.top) {
        y += HMDefaultRowSpacing;
    }
    attrs.frame = CGRectMake(x, y, width, height);
    // 更新最大y坐标
    self.columnMaxYArray[destColumnIndex] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

@end
