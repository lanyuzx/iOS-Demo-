//
//  OrderDetailListView.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//
//  购物车订单详情列表

#import <UIKit/UIKit.h>

@class ShopCartView;

@interface OrderDetailListView : UIView

/** 订单详情列表 */
@property (strong, nonatomic) UITableView *listTableView;

/** 订单对象 */
@property (strong, nonatomic) NSMutableArray *objects;

@property (strong, nonatomic) ShopCartView *shopCartView;

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects;

- (instancetype)initWithFrame:(CGRect)frame withObjects:(NSMutableArray *)objects canReorder:(BOOL)reOrder;

@end
