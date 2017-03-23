//
//  ZZXClothesCollectionViewController.m
//  瀑布流效果的实现
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 zunxian. All rights reserved.
//

#import "ZZXClothesCollectionViewController.h"
#import "ZZXClothers.h"
#import "ZZXWaterfalllayout.h"
#import "ZZXColotherCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
@interface ZZXClothesCollectionViewController ()<UITableViewDelegate>
//保存衣服的数组模型
@property(nonatomic,strong)NSMutableArray * clothersArray;
@end

@implementation ZZXClothesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    //使用第三框框架字典转模型
    NSArray * tempArray = [ZZXClothers objectArrayWithFilename:@"clothes.plist"];
    [self.clothersArray addObjectsFromArray:tempArray];
    //设置布局属性为自定义
    
    ZZXWaterfalllayout * layout = [[ZZXWaterfalllayout alloc]init];
    layout.clothesArray = self.clothersArray;
   
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.collectionViewLayout = layout;
    
    //下拉刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSArray * tempArray = [ZZXClothers objectArrayWithFilename:@"clothes.plist"];
        //把刷新的数据加载到 pilis 文件中
        [self.clothersArray insertObjects:tempArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempArray.count)]];
        
        //刷新 tableView
        [self.collectionView reloadData];
        
        //结束刷新
        
        [self.collectionView.header endRefreshing];
        
    }];
    
    //设置下拉刷新
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        
        NSArray * tempArray = [ZZXClothers objectArrayWithFilename:@"clothes.plist"];
        //把刷新的数据加载到 pilis 文件中

        [self.clothersArray addObjectsFromArray:tempArray];
        
        [self.collectionView reloadData];
        
        //结束率先呢
        
        [self.collectionView.footer endRefreshing];
        
        
    }];
   

}
#pragma mark ---- 懒加载
-(NSMutableArray *)clothersArray {
    if (_clothersArray == nil) {
        _clothersArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _clothersArray;

}

#pragma mark <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.clothersArray.count ;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZZXColotherCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ZZXColotherCell alloc]init];
    }
    
    ZZXClothers * colothers = self.clothersArray[indexPath.item];
    
    cell.clothers = colothers;
    return cell;
    
    

}

#pragma mark --- 代理方法

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
