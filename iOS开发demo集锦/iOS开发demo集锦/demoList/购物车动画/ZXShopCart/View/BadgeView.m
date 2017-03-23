//
//  BadgeView.m
//  ZXShopCart
//
//  Created by Xiang on 16/1/28.
//  Copyright © 2016年 周想. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

- (instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = frame.size.height / 2;
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.font = [UIFont systemFontOfSize:10.0f];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.text = string;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
        self.badgeValue = string;
    }
    return self;
}

+ (BadgeView *)initWithString:(NSString *)string {
    return [[self alloc] initWithString:string];
}

@end
