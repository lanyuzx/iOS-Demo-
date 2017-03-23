//
//  LLDemoHeaderFooterView.m
//  iOS开发demo集锦
//
//  Created by JYD on 2017/3/14.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLDemoHeaderFooterView.h"
#import "LLDemoModel.h"


@implementation LLDemoHeaderFooterView
{
    UILabel * _titleLable;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
            self.contentView.backgroundColor = [UIColor orangeColor];
        _titleLable = [UILabel new];
        [self.contentView addSubview:_titleLable];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont boldSystemFontOfSize:16];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:lineView];
        lineView.frame = CGRectMake(0, 54.5, [UIScreen mainScreen].bounds.size.width, 0.5);
    
        [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headFootClick)]];
        
    }
    return self;
}
-(void)setModel:(LLDemoModel *)model {
    _model = model;
    _titleLable.text = model.updateTime;
     _titleLable.frame = CGRectMake(CGRectGetMidX([UIScreen mainScreen].bounds) - 100, 55 /2 - 35 /2, 200, 35);
}

-(void)headFootClick {
    
    self.block(self);
}
@end
