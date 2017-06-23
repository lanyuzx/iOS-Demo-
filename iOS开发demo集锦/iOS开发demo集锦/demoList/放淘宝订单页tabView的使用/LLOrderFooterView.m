//
//  LLOrderFooterView.m
//  测试
//
//  Created by 周尊贤 on 2017/5/18.
//  Copyright © 2017年 毛织网. All rights reserved.
//

#import "LLOrderFooterView.h"
#import "Masonry.h"
#import "LLCartVoListModel.h"
@implementation LLOrderFooterView
{
    UILabel * _statistical;
    UIView * _lineView;
    UIButton * _moreButton;
    UIButton * _logisticsButton;
    UIButton * _sellButton;
    UIButton * _evaluationButton;
   
    
    

}
-(void)setModel:(LLListModel *)model {
    
    _model = model;
    
    float  finalMoeny = 0.0 ;
    for (LLCartVoListModel * cartVoModel in model.cartVoList ) {
        finalMoeny += [cartVoModel.realPrice floatValue];
        
    }
    _statistical.text = [NSString stringWithFormat:@"共%lu件商品  合计:¥ %.2f (含运费¥ 0.00)",(unsigned long)model.cartVoList.count,finalMoeny];

}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIView * topLineView = [UIView new];
        [self.contentView addSubview:topLineView];
        topLineView.backgroundColor = [UIColor darkGrayColor];
        [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
        
        _statistical = [UILabel new];
        _statistical.textColor = [UIColor darkGrayColor];
        _statistical.font = [UIFont systemFontOfSize:14];
        _statistical.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_statistical];
        [_statistical mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLineView.mas_bottom).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.height.equalTo(@35);
        }];
        
        _lineView = [UIView new];
        [self.contentView addSubview:_lineView];
        _lineView.backgroundColor = [UIColor darkGrayColor];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(_statistical.mas_bottom).offset(5);
            make.height.equalTo(@0.5);
        }];
        
        _evaluationButton = [UIButton new];
        [_evaluationButton setTitle:@"追加评价" forState:UIControlStateNormal];
        [_evaluationButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         _evaluationButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _evaluationButton.layer.masksToBounds = true;
        _evaluationButton.layer.cornerRadius = 10;
        _evaluationButton.layer.borderWidth = 0.5;
        _evaluationButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self.contentView addSubview:_evaluationButton];
        [_evaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.height.equalTo(@35);
            make.width.equalTo(@80);
        }];
        
        _sellButton = [UIButton new];
        [_sellButton setTitle:@"卖了换钱" forState:UIControlStateNormal];
        [_sellButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _sellButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _sellButton.layer.masksToBounds = true;
        _sellButton.layer.cornerRadius = 10;
        _sellButton.layer.borderWidth = 0.5;
        _sellButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self.contentView addSubview:_sellButton];
        [_sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).offset(5);
            make.right.equalTo(_evaluationButton.mas_left).offset(-5);
            make.height.equalTo(@35);
            make.width.equalTo(@80);
        }];
        
        _logisticsButton = [UIButton new];
        [_logisticsButton setTitle:@"查看物流" forState:UIControlStateNormal];
         _logisticsButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_logisticsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _logisticsButton.layer.masksToBounds = true;
        _logisticsButton.layer.cornerRadius = 10;
        _logisticsButton.layer.borderWidth = 0.5;
        _logisticsButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
        [self.contentView addSubview:_logisticsButton];
        [_logisticsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).offset(5);
            make.right.equalTo(_sellButton.mas_left).offset(-5);
             make.height.equalTo(@35);
            make.width.equalTo(@80);
        }];
    
        _moreButton = [UIButton new];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_moreButton];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView.mas_bottom).offset(5);
            make.right.equalTo(_logisticsButton.mas_left).offset(-5);
            make.height.equalTo(@35);
            make.width.equalTo(@50);
        }];
        
        
        
    }
    
    return self;

}

@end
