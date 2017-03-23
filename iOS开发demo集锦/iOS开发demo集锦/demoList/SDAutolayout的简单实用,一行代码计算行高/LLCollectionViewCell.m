//
//  LLCollectionViewCell.m
//  仿微信cell小弹框
//
//  Created by JYD on 2017/2/7.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLCollectionViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation LLCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor purpleColor];
        
        UILabel * lable = [UILabel new];
        lable.text = @"图片";
        lable.font = [UIFont boldSystemFontOfSize:16];
        lable.textColor = [UIColor blueColor];
        [self.contentView sd_addSubviews:@[lable]];
        lable.sd_layout
        .centerYEqualToView(self.contentView)
        .widthIs(50)
        .heightIs(35)
        .centerXEqualToView(self.contentView);
    
    }
    return self;
}

@end
