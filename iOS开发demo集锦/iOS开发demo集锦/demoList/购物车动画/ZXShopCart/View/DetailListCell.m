//
//  DetailListCell.m
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//

#import "DetailListCell.h"
#import "GoodsModel.h"

@implementation DetailListCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setGoods:(GoodsModel *)goods {
    _goods = goods;
    
    self.orderNameLabel.text = [NSString stringWithFormat:@"%@", goods.goodsName];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"¥ %0.2f", goods.goodsSalePrice];
    self.orderCountLabel.text = [NSString stringWithFormat:@"%zd", goods.orderCount];
    
    if (!(_goods.goodsStock  > 0)) {
        _plusButton.enabled = NO;
    } else {
        _plusButton.enabled = YES;
    }
}

- (IBAction)addButtonClicked {
    self.orderCount = [self.orderCountLabel.text intValue];
    self.orderCount++;
    [self showNumber:self.orderCount];
    
    _goods.orderCount++;    // 修改模型
    _goods.goodsStock--;
    
    // 通知代理（调用代理的方法）
    // respondsToSelector:能判断某个对象是否实现了某个方法
    if ([self.delegate respondsToSelector:@selector(orderDetailCellPlusButtonClicked:)]) {
        [self.delegate orderDetailCellPlusButtonClicked:self];
    }
}

- (IBAction)subButtonClicked {
    self.orderCount = [self.orderCountLabel.text intValue];
    self.orderCount--;
    [self showNumber:self.orderCount];
    _goods.orderCount--;
    _goods.goodsStock++;
    
    if ([self.delegate respondsToSelector:@selector(orderDetailCellMinusButtonClicked:)]) {
        [self.delegate orderDetailCellMinusButtonClicked:self];
    }
}

- (void)showNumber:(NSUInteger)count {
    self.orderCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.orderCount];
}

@end
