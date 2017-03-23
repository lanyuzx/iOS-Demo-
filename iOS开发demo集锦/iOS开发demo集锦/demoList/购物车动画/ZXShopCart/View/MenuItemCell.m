//
//  MenuItemCell.m
//  ZXShopCart
//
//  Created by Xiang on 16/2/17.
//  Copyright © 2016年 周想. All rights reserved.
//

#import "MenuItemCell.h"
#import "GoodsModel.h"

@interface MenuItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsIconView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSalePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
//@property (weak, nonatomic) IBOutlet UIView *soldoutBackgroudView;
@property (weak, nonatomic) IBOutlet UIImageView *soldoutIconView;
//@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@end

@implementation MenuItemCell

- (void)setGoods:(GoodsModel *)goods {
    _goods = goods;
    
    self.goodsIconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", goods.goodsIcon]];
    self.goodsNameLabel.text = [NSString stringWithFormat:@"%@", goods.goodsName];
    self.goodsOriginalPriceLabel.text = [NSString stringWithFormat:@"原价：¥ %.2f", goods.goodsOriginalPrice];
    self.goodsSalePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", goods.goodsSalePrice];
    self.goodsCountLabel.text = [NSString stringWithFormat:@"%zd", goods.orderCount];
    
    if (_goods.orderCount > 0) {
        [self.minusButton setHidden:NO];
        [self.goodsCountLabel setHidden:NO];
    } else {
        [self.minusButton setHidden:YES];
        [self.goodsCountLabel setHidden:YES];
    }
    
    if (!(_goods.goodsStock  > 0)) {
        //self.soldoutBackgroudView.hidden = NO;
        self.soldoutIconView.hidden = NO;
        _plusButton.enabled = NO;
    } else {
        //self.soldoutBackgroudView.hidden = YES;
        self.soldoutIconView.hidden = YES;
        _plusButton.enabled = YES;
    }
}

- (IBAction)plusButtonClicked {
    _goods.orderCount++;    // 修改模型
    _goods.goodsStock--;
    _goodsCountLabel.text = [NSString stringWithFormat:@"%i", _goods.orderCount];
    _minusButton.hidden = NO;
    _goodsCountLabel.hidden = NO;
    if (_goods.goodsStock == 0) {
        _plusButton.enabled = NO;
        self.soldoutIconView.hidden = NO;
    }
    
    // 通知代理（调用代理的方法）
    // respondsToSelector:能判断某个对象是否实现了某个方法
    if ([self.delegate respondsToSelector:@selector(menuItemCellDidClickPlusButton:)]) {
        [self.delegate menuItemCellDidClickPlusButton:self];
    }
}

- (IBAction)minusButtonClicked {
    _goods.orderCount--;
    _goods.goodsStock++;
    _goodsCountLabel.text = [NSString stringWithFormat:@"%i", _goods.orderCount];
    
    if (_goods.orderCount == 0) {
        _minusButton.hidden = YES;
        _goodsCountLabel.hidden = YES;
    }
    
    if (_goods.goodsStock > 0) {
        _plusButton.enabled = YES;
        self.soldoutIconView.hidden = YES;
    }
    
    // 通知代理（调用代理的方法）
    if ([self.delegate respondsToSelector:@selector(menuItemCellDidClickMinusButton:)]) {
        [self.delegate menuItemCellDidClickMinusButton:self];
    }
}

@end
