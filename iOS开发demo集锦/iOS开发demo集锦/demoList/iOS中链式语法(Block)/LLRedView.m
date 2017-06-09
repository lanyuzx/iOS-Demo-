//
//  LLRedView.m
//  iOS中的链式语法
//
//  Created by 周尊贤 on 2017/6/6.
//  Copyright © 2017年 周尊贤. All rights reserved.
//



#import "LLRedView.h"


@implementation LLRedView{
    UILabel * _titleLable;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLable = [UILabel new];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont systemFontOfSize:17];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLable];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _titleLable.frame = CGRectMake(CGRectGetMidX(self.frame) -40, CGRectGetMidY(self.frame) -18, 80, 36);
}

+(makeUp)makeDo{
    
    return ^(void){
        return [[self alloc]init];
    };
}
-(frame)frameBlock{
    return ^(CGRect frame){
        
        self.frame = frame;
        
        return self;
    };
}

-(type)typeBlock{
    return ^(NSInteger type){
        
        NSLog(@"type=%ld",(long)type);
        return self;
    };
}

-(color)colorBlock{
    
    return ^(UIColor *color){
        
        NSLog(@"type=%@",color);
        self.backgroundColor = color;

        return self;
    };
}

-(title)titleBlock{
    return ^(NSString *title){
        NSLog(@"title=%@",title);
        _titleLable .text = title;
        return self;
    };
}


@end
