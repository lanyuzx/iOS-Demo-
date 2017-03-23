//
//  GoodsCategory.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//
//  商品类型模型

#import <Foundation/Foundation.h>

@interface GoodsCategory : NSObject

/** 商品分类名称 */
@property (copy, nonatomic) NSString *goodsCategoryName;

/** 商品分类说明 */
@property (copy, nonatomic) NSString *goodsCategoryDesc;

/** 商品分类中包含的商品模型数组 */
@property (strong, nonatomic) NSMutableArray *goodsArray;

@end
