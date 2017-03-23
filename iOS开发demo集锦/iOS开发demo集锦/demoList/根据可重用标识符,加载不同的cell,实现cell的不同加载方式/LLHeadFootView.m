//
//  LLHeadFootView.m
//  cell的加载方式
//
//  Created by 周尊贤 on 16/10/27.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import "LLHeadFootView.h"
#import "LLTempModel.h"
@interface LLHeadFootView()

@property(nonatomic,strong) UILabel* nameLable;
@end

@implementation LLHeadFootView

-(void)setModel:(LLTempModel *)model {
    _model = model;
    self.nameLable.text = model.name;

}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        

        self.nameLable = [[UILabel alloc]init];
        self.nameLable.textColor = [UIColor orangeColor];
        self.nameLable.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.nameLable];
        self.nameLable.frame = CGRectMake(15, self.frame.size.height / 2+(35/2), 120, 35);
        
        UIView * lineView = [[UIView alloc]init];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor =[ UIColor darkGrayColor];
        lineView.frame = CGRectMake(0, self.frame.size.height -1, [UIScreen mainScreen].bounds.size.width, 0.8);
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
        [self.contentView addGestureRecognizer:tap];
        
    }
    return self;

}
-(void)click {
    self.model.headViewEnum = loadIng;
    self.model.isClick = !self.model.isClick;
    if ([self.delegate respondsToSelector:@selector(headFootViewDelegateClick:::)]) {
        [self.delegate headFootViewDelegateClick:self.model :self.section :self];
    }

}

@end
