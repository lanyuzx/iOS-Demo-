//
//  BadgeView.h
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//
//  购物车脚标视图

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

@property (strong, nonatomic) NSString  *badgeValue;
//@property (strong, nonatomic) UIColor   *textColor;
@property (strong, nonatomic) UILabel   *textLabel;

- (instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string;

@end
