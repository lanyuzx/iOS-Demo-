//
//  LLPhotoesView.m
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/7.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLPhotoesView.h"
#import "LLCollectionViewCell.h"
#import "LLModel.h"
@interface LLPhotoesView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation LLPhotoesView

{
    NSArray * _dataArr;

}

-(void)setModel:(LLModel *)model {
    _model = model;
    _dataArr = model.photoArr;
    [self reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout  {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor yellowColor];
        [self registerClass:[LLCollectionViewCell class] forCellWithReuseIdentifier:@"LLPhotoesView"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    
    return _dataArr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LLCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLPhotoesView" forIndexPath:indexPath];
    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArr.count > 1) {
         return (CGSize){80,60};
    }else {
     return (CGSize){130,150};
    }
   
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 1, 5, 1);
}

@end
