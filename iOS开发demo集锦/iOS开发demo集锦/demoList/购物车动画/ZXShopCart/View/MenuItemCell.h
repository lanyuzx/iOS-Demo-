//
//  MenuItemCell.h
//  ZXShopCart
//
//  Created by Xiang on 16/2/17.
//  Copyright © 2016年 周想. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel, MenuItemCell;

@protocol MenuItemCellDelegate <NSObject>

@optional
- (void)menuItemCellDidClickPlusButton:(MenuItemCell *)itemCell;
- (void)menuItemCellDidClickMinusButton:(MenuItemCell *)itemCell;

@end

@interface MenuItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *plusButton;

/** 商品模型 */
@property (strong, nonatomic) GoodsModel *goods;

/** 代理对象 */
@property (nonatomic, weak) id<MenuItemCellDelegate> delegate;

@end
