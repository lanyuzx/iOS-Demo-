//
//  PopOutView.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//
//  购物车弹出列表背景视图

#import <UIKit/UIKit.h>
@class ShopCartView;

@interface PopOutView : UIView

/** 购物车 */
@property (strong, nonatomic) ShopCartView *shopCartView;

@end
