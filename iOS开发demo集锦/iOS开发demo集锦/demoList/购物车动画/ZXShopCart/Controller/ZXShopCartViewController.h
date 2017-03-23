//
//  ZXShopCartViewController.h
//  ZXShopCart
//
//  Created by Xiang on 16/2/2.
//  Copyright © 2016年 周想. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXShopCartViewController : UIViewController

/** 订单数据 */
@property (nonatomic, strong) NSMutableArray *orderArray;

/** 订单所选总数量 */
@property (nonatomic, assign) NSInteger totalOrderCount;

/** 订单总价 */
@property (assign, nonatomic) double totalPrice;

@end
