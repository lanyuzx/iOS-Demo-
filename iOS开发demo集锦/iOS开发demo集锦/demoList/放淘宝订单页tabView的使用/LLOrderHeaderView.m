//
//  LLOrderHeaderView.m
//  测试
//
//  Created by 周尊贤 on 2017/5/18.
//  Copyright © 2017年 毛织网. All rights reserved.
//

#import "LLOrderHeaderView.h"
#import "Masonry.h"
@implementation LLOrderHeaderView
{
    UILabel * _companyNameLable;
    UILabel * _orderStateLable;
    

}

-(void)setModel:(LLListModel *)model {
    _model = model;
    _companyNameLable.text = [NSString stringWithFormat:@"%@  >",model.companyName];
    _orderStateLable.text = @"交易成功";

}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        _companyNameLable = [UILabel new];
        [self.contentView addSubview:_companyNameLable];
        _companyNameLable.textColor = [UIColor darkGrayColor];
        _companyNameLable.font = [UIFont systemFontOfSize:16];
        _companyNameLable.textAlignment = NSTextAlignmentLeft;
        [_companyNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.centerY.equalTo(self.contentView);
        }];
        
        _orderStateLable = [UILabel new];
        [self.contentView addSubview:_orderStateLable];
        _orderStateLable.textColor = [UIColor orangeColor];
        _orderStateLable.font = [UIFont systemFontOfSize:16];
        _orderStateLable.textAlignment = NSTextAlignmentRight;
        [_orderStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12);
            make.centerY.equalTo(self.contentView);
        }];
        
        
    }
    
    return self;

}

@end
