//
//  DetailListCell.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsModel, DetailListCell;

@protocol DetailListCellDelegate <NSObject>

@optional
- (void)orderDetailCellPlusButtonClicked:(DetailListCell *)cell;
- (void)orderDetailCellMinusButtonClicked:(DetailListCell *)cell;
@end

@interface DetailListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;

/** 下单数量 */
@property (nonatomic, assign) int orderCount;

//@property (nonatomic,copy) void (^operationBlock)(NSInteger number,BOOL plus);

/** 商品模型 */
@property (strong, nonatomic) GoodsModel *goods;

/** 代理对象 */
@property (nonatomic, weak) id<DetailListCellDelegate> delegate;

@end
