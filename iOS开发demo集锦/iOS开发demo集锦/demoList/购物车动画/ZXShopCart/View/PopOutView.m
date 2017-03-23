//
//  PopOutView.m
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//

#import "PopOutView.h"
#import "ShopCartView.h"

@implementation PopOutView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    // 点击背景收起购物车
    if (view == self) {
        [self.shopCartView dismissAnimated:YES];
    }
}

@end
