//
//  XMGTagButton.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTagButton.h"
#import "PrefixHeader.pch"
@implementation XMGTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = XMGTagBg;
        self.titleLabel.font = XMGTagFont;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * XMGTagMargin;
    self.height = XMGTagH;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = XMGTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + XMGTagMargin;
}

@end
